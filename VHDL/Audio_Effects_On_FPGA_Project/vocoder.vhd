-- ================================================================================================
-- Written by Esteban Halliez
-- 
-- This file remains a test file for a vocoder on vocal signals
-- ================================================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vocoder is
    port (
        clock_50     : in std_logic;
        clock_48kHz  : in std_logic; -- Signal de synchronisation externe
        audio_in     : in std_logic_vector(15 downto 0);
        audio_out    : out std_logic_vector(15 downto 0)
    );
end entity vocoder;

architecture rtl of vocoder is

    -- Signaux de synchronisation (Modèle identique à ton Delay)
    signal clock_48kHz_sample : std_logic_vector(1 downto 0);
    signal pulse_48kHz        : std_logic;

    -- Signaux internes
    signal saw_acc         : unsigned(23 downto 0) := (others => '0');
    signal saw_sig         : std_logic_vector(15 downto 0);
    
    signal fft_real_voice, fft_imag_voice : std_logic_vector(15 downto 0);
    signal fft_valid_voice, sop_voice     : std_logic;
    signal fft_real_saw, fft_imag_saw     : std_logic_vector(15 downto 0);
    
    signal voice_amplitude : std_logic_vector(17 downto 0);
    signal spectrum_real_in, spectrum_imag_in : std_logic_vector(15 downto 0);
    signal data_valid_in   : std_logic := '0';

    -- Delays pour synchro CORDIC (20 cycles)
    type d_array is array (0 to 19) of std_logic_vector(15 downto 0);
    signal d_real_saw, d_imag_saw : d_array;
    signal d_valid : std_logic_vector(19 downto 0);

begin

    ---------------------------------------------------------------------------
    -- 1. SYNCHRONISATION SUR LE 48kHz (Méthode Delay)
    ---------------------------------------------------------------------------
    process(clock_50)
    begin
        if rising_edge(clock_50) then
            clock_48kHz_sample(1) <= clock_48kHz_sample(0);
            clock_48kHz_sample(0) <= clock_48kHz;
        end if;
    end process;

    -- Génération du pulse d'un seul cycle de 50MHz
    pulse_48kHz <= '1' when clock_48kHz_sample = "01" else '0';

    ---------------------------------------------------------------------------
    -- 2. GÉNÉRATEUR DENT DE SCIE (PORTEUSE)
    ---------------------------------------------------------------------------
    process(clock_50)
    begin
        if rising_edge(clock_50) then
            if pulse_48kHz = '1' then
                saw_acc <= saw_acc + 400; -- Fréquence de la porteuse
            end if;
        end if;
    end process;
    -- Conversion en signal centré (not MSB pour passer de unsigned à signed-like)
    saw_sig <= std_logic_vector(not(saw_acc(23)) & saw_acc(22 downto 8));

    ---------------------------------------------------------------------------
    -- 3. ANALYSE SPECTRALE (FFT)
    ---------------------------------------------------------------------------
    -- FFT de la Voix
    FFT_V : entity work.FFT_System port map (
        clk           => clock_50,
        reset_n       => '1',
        audio_in      => audio_in,
        audio_valid   => pulse_48kHz,
        fft_real_out  => fft_real_voice,
        fft_imag_out  => fft_imag_voice,
        fft_valid_out => fft_valid_voice,
        fft_sop_out   => sop_voice,
        fft_eop_out   => open,
        fft_exp_out   => open
    );

    -- FFT de la Porteuse (Sawtooth)
    FFT_S : entity work.FFT_System port map (
        clk           => clock_50,
        reset_n       => '1',
        audio_in      => saw_sig,
        audio_valid   => pulse_48kHz,
        fft_real_out  => fft_real_saw,
        fft_imag_out  => fft_imag_saw,
        fft_valid_out => open,
        fft_sop_out   => open,
        fft_eop_out   => open,
        fft_exp_out   => open
    );

    ---------------------------------------------------------------------------
    -- 4. CORDIC & ALIGNEMENT TEMPOREL
    ---------------------------------------------------------------------------
    -- L'instance CORDIC (Amplitude de la voix) doit être ici
    -- u_cordic : entity work.cordic_ip port map (...) 

    process(clock_50)
    begin
        if rising_edge(clock_50) then
            -- On décale les signaux de la porteuse pour attendre le CORDIC (20 cycles)
            d_real_saw <= fft_real_saw & d_real_saw(0 to 18);
            d_imag_saw <= fft_imag_saw & d_imag_saw(0 to 18);
            d_valid    <= fft_valid_voice & d_valid(19 downto 1);
        end if;
    end process;

    ---------------------------------------------------------------------------
    -- 5. MODULATION (MULTIPLICATION)
    ---------------------------------------------------------------------------
    process(clock_50)
        variable v_ampl : unsigned(17 downto 0);
        variable temp_r, temp_i : signed(33 downto 0);
    begin
        if rising_edge(clock_50) then
            if d_valid(0) = '1' then
                data_valid_in <= '1';
                
                -- Noise Gate
                if unsigned(voice_amplitude) < 500 then 
                    v_ampl := (others => '0');
                else
                    v_ampl := unsigned(voice_amplitude);
                end if;

                -- Modulation : Amplitude Voix * Spectre Porteuse
                temp_r := signed("00" & v_ampl(17 downto 2)) * signed(d_real_saw(19));
                temp_i := signed("00" & v_ampl(17 downto 2)) * signed(d_imag_saw(19));

                -- Gain de sortie (Ajuster ici si trop faible ou trop fort)
                spectrum_real_in <= std_logic_vector(temp_r(20 downto 5));
                spectrum_imag_in <= std_logic_vector(temp_i(20 downto 5));
            else
                data_valid_in <= '0';
            end if;
        end if;
    end process;

    ---------------------------------------------------------------------------
    -- 6. SYNTHÈSE (iFFT)
    ---------------------------------------------------------------------------
    audio_out <= audio_in;

end architecture;