-- ================================================================================================
-- Written by Esteban Halliez
-- 
-- This file performs the Fourier Transform of an audio input signal.
-- The objective is to extract the signal frequency for frequency based effects
-- ================================================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FFT_System is
    port (
		  --Clock 
        clk           : in  std_logic;
        reset_n       : in  std_logic; 
		  -- Input
        audio_in      : in  std_logic_vector(15 downto 0);
        audio_valid   : in  std_logic; 
		  
		  --FFT Output
        fft_real_out  : out std_logic_vector(15 downto 0);
        fft_imag_out  : out std_logic_vector(15 downto 0);
        fft_valid_out : out std_logic;
        fft_sop_out   : out std_logic; 
        fft_eop_out   : out std_logic; 
        fft_exp_out   : out std_logic_vector(5 downto 0) 
    );
end entity FFT_System;

architecture rtl of FFT_System is

	 --Based on the FFT component from the IP Catalog
    component FFT is
        port (
            clk          : in std_logic; 
            reset_n      : in std_logic;
            sink_valid   : in std_logic; 
            sink_ready   : out std_logic;
            sink_error   : in std_logic_vector(1 downto 0);
            sink_sop     : in std_logic; 
            sink_eop     : in std_logic;
            sink_real    : in std_logic_vector(15 downto 0);
            sink_imag    : in std_logic_vector(15 downto 0);
            inverse      : in std_logic_vector(0 downto 0);
            source_valid : out std_logic; 
            source_ready : in std_logic;
            source_sop   : out std_logic; 
            source_eop   : out std_logic;
            source_real  : out std_logic_vector(15 downto 0);
            source_imag  : out std_logic_vector(15 downto 0);
            source_exp   : out std_logic_vector(5 downto 0)
        );
    end component;

    signal count          : unsigned(10 downto 0) := (others => '0');
    signal sink_sop_int   : std_logic := '0';
    signal sink_eop_int   : std_logic := '0';
    signal sink_valid_int : std_logic := '0';

begin

   process(clk, reset_n)
    begin
		  --Reset logic
        if reset_n = '0' then
            count <= (others => '0');
            sink_valid_int <= '0';
            sink_sop_int   <= '0';
            sink_eop_int   <= '0';
				
		  --Storing 2048samples for the FFT to be performed
        elsif rising_edge(clk) then
            if audio_valid = '1' then
                sink_valid_int <= '1';
                
                if count = 0 then
                    sink_sop_int <= '1';
                else
                    sink_sop_int <= '0';
                end if;

                if count = 2047 then
                    sink_eop_int <= '1';
                    count <= (others => '0');
                else
                    sink_eop_int <= '0';
                    count <= count + 1;
                end if;
            else
                sink_valid_int <= '0';
                sink_sop_int   <= '0';
                sink_eop_int   <= '0';
            end if;
        end if;
    end process;

	 --FFT Instance from IP Catalog
    u_fft_ip : FFT port map (
        clk          => clk, 
        reset_n      => reset_n,
        sink_valid   => sink_valid_int, 
        sink_ready   => open,
        sink_error   => "00", 
        sink_sop     => sink_sop_int,
        sink_eop     => sink_eop_int, 
        sink_real    => audio_in,
        sink_imag    => (others => '0'), 
        inverse      => "0",                -- Mode FFT 
        source_valid => fft_valid_out, 
        source_ready => '1',
        source_sop   => fft_sop_out, 
        source_eop   => fft_eop_out,
        source_real  => fft_real_out, 
        source_imag  => fft_imag_out,
        source_exp   => fft_exp_out
        -- source_error retiré car absent de l'IP
    );

end architecture;