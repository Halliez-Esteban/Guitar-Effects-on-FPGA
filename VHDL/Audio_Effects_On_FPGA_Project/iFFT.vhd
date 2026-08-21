-- ================================================================================================
-- Written by Esteban Halliez
-- 
-- This file performs the reversed Fourier Transform of an audio frequency spectrum.
-- The objective is to rebuild the audio output from its spectrum
-- ================================================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity iFFT_System is
    port (
		  -- Clock
        clk              : in  std_logic;
        reset_n          : in  std_logic;
		  --iFFT Input
        spectrum_real_in : in  std_logic_vector(15 downto 0);
        spectrum_imag_in : in  std_logic_vector(15 downto 0);
        data_valid_in    : in  std_logic; 
		  -- Audio ouput
        audio_out        : out std_logic_vector(15 downto 0);
        audio_valid_out  : out std_logic
    );
end entity iFFT_System;

architecture rtl of iFFT_System is
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

    signal count           : unsigned(10 downto 0) := (others => '0'); 
    signal sink_sop_int    : std_logic := '0';
    signal sink_eop_int    : std_logic := '0';
    signal sink_valid_int  : std_logic := '0';
    signal raw_real_out    : std_logic_vector(15 downto 0);
    signal source_valid_int : std_logic;

begin

    ---------------------------------------------------------
    -- Input flow management (To IP)
    ---------------------------------------------------------
    process(clk, reset_n)
    begin
        if reset_n = '0' then
            count <= (others => '0');
            sink_valid_int <= '0';
            sink_sop_int   <= '0';
            sink_eop_int   <= '0';
        elsif rising_edge(clk) then
            sink_valid_int <= data_valid_in; 
            
            if data_valid_in = '1' then
                -- SOP Management (Start of Packet) / EOP (End of Packet)
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
                sink_sop_int <= '0';
                sink_eop_int <= '0';
            end if;
        end if;
    end process;

    ---------------------------------------------------------
    -- IP ALCORA FFT INSTANCE (Reversed Mode)
    ---------------------------------------------------------
    u_ifft_ip : FFT port map (
        clk          => clk,
        reset_n      => reset_n,
        sink_valid   => sink_valid_int,
        sink_ready   => open,
        sink_error   => "00",
        sink_sop     => sink_sop_int,
        sink_eop     => sink_eop_int,
        sink_real    => spectrum_real_in, -- Real data coming from de FFT_System
        sink_imag    => spectrum_imag_in, -- Imaginaru data coming from de FFT_System
        inverse      => "1",               -- 1 = iFFT, 0 = FFT
        source_valid => source_valid_int,
        source_ready => '1',
        source_sop   => open,
        source_eop   => open,
        source_real  => raw_real_out,
        source_imag  => open,
        source_exp   => open
    );

    ---------------------------------------------------------
    -- Output Management & Gain
    ---------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            if source_valid_int = '1' then
                -- Gain application (shift_left) to reduce the iFFT attenuation's impact
                audio_out <= std_logic_vector(signed(raw_real_out));
                audio_valid_out <= '1';
            else
                audio_valid_out <= '0';
            end if;
        end if;
    end process;

end architecture;