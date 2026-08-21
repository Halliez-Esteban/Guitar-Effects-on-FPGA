-- ================================================================================================
-- Written by Esteban Halliez
-- 
-- This file remains a test file for octaver on both guitar and vocal signals
-- ================================================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity octaver is
    port (
        clk           : in  std_logic; 
        reset_n       : in  std_logic;
        sample_en     : in  std_logic; 
        octave_choice : in  std_logic; -- '0' for +1 Octave, '1' for +2 Octaves
        audio_in      : in  std_logic_vector(15 downto 0);
        audio_out     : out std_logic_vector(15 downto 0)
    );
end entity;

architecture rtl of octaver is

    component RAM_Octaver
        PORT (
            address_a : IN  STD_LOGIC_VECTOR (13 DOWNTO 0);
            address_b : IN  STD_LOGIC_VECTOR (13 DOWNTO 0);
            clock     : IN  STD_LOGIC := '1';
            data_a    : IN  STD_LOGIC_VECTOR (15 DOWNTO 0);
            data_b    : IN  STD_LOGIC_VECTOR (15 DOWNTO 0);
            wren_a    : IN  STD_LOGIC := '0';
            wren_b    : IN  STD_LOGIC := '0';
            q_a       : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            q_b       : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
        );
    end component;

    -- 2048 samples buffer (11 bits) 
    signal addr_a, addr_b : unsigned(10 downto 0);
    signal q_a, q_b       : std_logic_vector(15 downto 0);
    signal wren_a_sig     : std_logic := '0';
    
    signal wr_ptr         : unsigned(10 downto 0) := (others => '0');
    signal rd_ptr1        : unsigned(10 downto 0) := (others => '0');
    signal rd_ptr2        : unsigned(10 downto 0) := to_unsigned(1024, 11); 
    
    signal gain1, gain2   : signed(15 downto 0);
    signal dsp_state      : integer range 0 to 7 := 0;

begin

    RAM_inst : RAM_Octaver PORT MAP (
        address_a => "000" & std_logic_vector(addr_a), 
        address_b => "000" & std_logic_vector(addr_b),
        clock     => clk, 
        data_a    => audio_in, 
        data_b    => (others => '0'),
        wren_a    => wren_a_sig, 
        wren_b    => '0', 
        q_a       => q_a, 
        q_b       => q_b
    );

    -- Gain calculation
    process(rd_ptr1, rd_ptr2, wr_ptr)
        variable dist1, dist2 : unsigned(10 downto 0);
    begin
        dist1 := rd_ptr1 - wr_ptr;
        dist2 := rd_ptr2 - wr_ptr;
        
        -- Triangle shaped windowing (MSB at 10th bit )
        if dist1(10) = '0' then 
            gain1 <= signed('0' & dist1(9 downto 0) & "00000"); 
        else 
            gain1 <= signed('0' & (not dist1(9 downto 0)) & "00000");
        end if;

        if dist2(10) = '0' then 
            gain2 <= signed('0' & dist2(9 downto 0) & "00000");
        else 
            gain2 <= signed('0' & (not dist2(9 downto 0)) & "00000");
        end if;
    end process;

    -- DSP State Machine
    process(clk, reset_n)
        variable s1, s2     : signed(15 downto 0);
        variable mix1, mix2 : signed(31 downto 0); 
        variable wet_signal : signed(15 downto 0);
    begin
        if reset_n = '0' then
            dsp_state <= 0; audio_out <= (others => '0');
            wr_ptr <= (others => '0');
            rd_ptr1 <= (others => '0');
            rd_ptr2 <= to_unsigned(1024, 11);
            wren_a_sig <= '0';
        elsif rising_edge(clk) then
            case dsp_state is
                
                when 0 => 
                    wren_a_sig <= '0';
                    if sample_en = '1' then
                        addr_a <= wr_ptr; 
                        wren_a_sig <= '1';
                        dsp_state <= 1;
                    end if;

                when 1 => 
                    wren_a_sig <= '0';
                    addr_a <= rd_ptr1;
                    addr_b <= rd_ptr2;
                    dsp_state <= 2;

                when 2 => dsp_state <= 3; 
                when 3 => dsp_state <= 4; 

                when 4 => 
                    s1 := signed(q_a); 
                    s2 := signed(q_b);
                    mix1 := s1 * gain1;
                    mix2 := s2 * gain2;
                    dsp_state <= 5;

                when 5 => 
                    wet_signal := mix1(30 downto 15) + mix2(30 downto 15);
                    
                    -- Mixing Dry/Wet
                    audio_out <= std_logic_vector(
                        shift_right(signed(audio_in), 1) + shift_right(wet_signal, 1)
                    );
                    
                    -- SETTING POINTERS
                    wr_ptr  <= wr_ptr + 1;
                    
                    if octave_choice = '0' then
                        -- Mode +1 Octave : Speed x2
                        rd_ptr1 <= rd_ptr1 + 2; 
                        rd_ptr2 <= rd_ptr2 + 2;
                    else
                        -- Mode +2 Octaves : Speed x4
                        rd_ptr1 <= rd_ptr1 + 4; 
                        rd_ptr2 <= rd_ptr2 + 4;
                    end if;
                    
                    dsp_state <= 0;

                when others => dsp_state <= 0;
            end case;
        end if;
    end process;

end architecture;