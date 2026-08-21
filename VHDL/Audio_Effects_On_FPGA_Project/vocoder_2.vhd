-- ================================================================================================
-- Written by Esteban Halliez
-- 
-- This file remains a test file for a vocoder on vocal signals
-- ================================================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vocoder_2 is
    port (
        clock_50    : in  std_logic;
        clock_48kHz : in  std_logic;
        audio_in    : in  std_logic_vector(15 downto 0);
        audio_out   : out std_logic_vector(15 downto 0)
    );
end entity vocoder_2;

architecture rtl of vocoder_2 is
    constant NB : integer := 16;
    type band_array is array (0 to NB-1) of signed(15 downto 0);
    type env_array  is array (0 to NB-1) of unsigned(15 downto 0);
    type coeff_type is array (0 to 15) of integer;

    signal v_filt, c_filt : band_array := (others => (others => '0'));
    signal envelopes      : env_array  := (others => (others => '0'));
    
    constant ALPHA : coeff_type := (15, 22, 32, 45, 65, 95, 135, 190, 270, 380, 530, 750, 1050, 1450, 2000, 2800);

    signal ph_acc    : unsigned(31 downto 0) := (others => '0');
    signal carrier_s : signed(15 downto 0);
    signal sync_reg  : std_logic_vector(1 downto 0) := "00";
    signal pulse_48k : std_logic;

begin

    -- 1. PORTEUSE : Dent de scie très faible pour éviter tout overflow
    process(clock_50)
    begin
        if rising_edge(clock_50) then
            -- Note bien marquée (Sol3/La3)
            ph_acc <= ph_acc + 25000; 
            
            -- Dent de scie "Hard" (Inversée)
            -- On utilise le complément à un pour un piquant maximum
            carrier_s <= signed(not ph_acc(31 downto 16));
            
            -- On ne réduit presque plus l'amplitude pour garder le piquant
            carrier_s <= shift_right(carrier_s, 1); 
        end if;
    end process;
	 
    process(clock_50) begin
        if rising_edge(clock_50) then sync_reg <= sync_reg(0) & clock_48kHz; end if;
    end process;
    pulse_48k <= '1' when sync_reg = "01" else '0';

    -- 2. DSP CORE
    process(clock_50)
        variable v_in, c_in     : signed(15 downto 0);
        variable v_calc, c_calc : signed(63 downto 0); 
        variable v_prod         : signed(32 downto 0); 
        variable mix_voc        : signed(23 downto 0);
        variable mix_final      : signed(23 downto 0);
    begin
        if rising_edge(clock_50) then
            if pulse_48k = '1' then
                v_in := signed(audio_in);
                c_in := carrier_s;
                
                mix_voc := (others => '0'); 

                for i in 0 to NB-1 loop
                    -- ANALYSE : On réduit encore le diviseur pour être ultra-réactif
                    v_calc := (resize(v_in, 32) - resize(v_filt(i), 32)) * to_signed(ALPHA(i), 32);
                    v_filt(i) <= v_filt(i) + signed(resize(v_calc / 1024, 16));

                    -- SYNTHÈSE : RÉSONANCE EXTRÊME (/32768)
                    -- On passe au diviseur maximum pour transformer le filtre en oscillateur
                    c_calc := (resize(c_in, 32) - resize(c_filt(i), 32)) * to_signed(ALPHA(i), 32);
                    c_filt(i) <= c_filt(i) + signed(resize(c_calc / 32768, 16));

                    -- ENVELOPPE "AGRESSIVE" (/32)
                    -- On veut que le robot réagisse au moindre chuchotement
                    envelopes(i) <= envelopes(i) - shift_right(envelopes(i), 5) + shift_right(unsigned(abs(v_filt(i))), 5);

                    -- MODULATION
                    v_prod := c_filt(i) * signed('0' & envelopes(i));
                    
                    -- ACCUMULATION (On remonte sur les bits de force : 27 downto 12)
                    mix_voc := mix_voc + resize(v_prod(27 downto 12), 24);
                end loop;

                -- MIXAGE FINAL : On ajoute un "Soft-Clipper" manuel
                mix_final := resize(mix_voc * to_signed(10, 8), 24);
            end if;
        end if;
    end process;
end architecture;