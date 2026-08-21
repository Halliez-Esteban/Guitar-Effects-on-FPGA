-- ================================================================================================
-- Written by Esteban Halliez
-- 
-- This file describes the delay effect logic.
-- The logic beneath is base on the sum of the current input with a delayed sample previously stored
-- ================================================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity delay is
	port
	(
		-- Clock
		clock_100MHz : in std_logic;
		clock_48kHz : in std_logic;
		
		--Delay
		delay_max : in integer range 0 to 50000;
		
		-- Signal Audio 
		audio_in : in std_logic_vector(15 downto 0);
		audio_out : out std_logic_vector(15 downto 0)
	);
end delay;

architecture delay_circuit of delay is

	-- Clock Synchronisation
	
	signal clock_48kHz_sample :std_logic_vector(1 downto 0) ;
	
	-- Counter 
	
	signal counter : integer range 0 to 50000; -- 48kHz Clock, delay between 0 and  1s
	
	-- Calculation
	
	signal echantillon : std_logic_vector(15 downto 0);
	signal echantillon_retard : std_logic_vector(15 downto 0);
	signal produit_brut : signed(31 downto 0);
	signal sortie : std_logic_vector(15 downto 0);
	signal AMORTISSEMENT : signed(15 downto 0) := to_signed(26214, 16); -- 0.8 en Q15 (0.8 * 32768) Q15.1
	
	-- CALCULATION SIGNALS (SIGNED) 
    signal audio_in_s       : signed(15 downto 0);      -- Converted audio input
    signal retard_in_s      : signed(15 downto 0);      -- Converted RAM output (y[n-T])
    
    signal produit_brut_s   : signed(31 downto 0);      -- Multiplication output
    signal amorti_s         : signed(15 downto 0);      -- Shifted Result
    signal sortie_calc_s    : signed(16 downto 0);      -- Sum result (17 bits)
	
	--RAM

	component RAM
	PORT
	(
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (14 DOWNTO 0); -- Range : 0-32767
		wraddress		: IN STD_LOGIC_VECTOR (14 DOWNTO 0); -- Range : 0-32767
		wren		: IN STD_LOGIC  := '0';
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
	end component;

	 --RAM
	 signal ram_data : std_logic_vector(15 downto 0);
	 signal ram_read_adr : std_logic_vector(14 downto 0);
	 signal ram_write_adr: std_logic_vector(14 downto 0) := (others => '0');
	 signal ram_write_en : std_logic;
	 signal ram_output : std_logic_vector(15 downto 0);
																
begin

	--RAM
	RAM_inst : RAM PORT MAP (
		clock	 => clock_100MHz,
		data	 => ram_data,
		rdaddress	 => ram_read_adr,
		wraddress	 => ram_write_adr,
		wren	 => ram_write_en,
		q	 => ram_output
	);
	
	echantillon <= audio_in;
	
	-- Mandatory conversion for the DSP
   audio_in_s  <= SIGNED(echantillon); 
   retard_in_s <= SIGNED(echantillon_retard); 
	
	-- Synchronizing 100Mhz and 48Khz clocks
	process(clock_100MHz)
	begin
		if rising_edge(clock_100MHz) then
			clock_48kHz_sample(1) <= clock_48kHz_sample(0);
			clock_48kHz_sample(0) <= clock_48kHz;
		end if;
	end process;
	
	-- 48kHz counting
	process(clock_100MHz)
	begin
	
		if(rising_edge(clock_100MHz)) then 
		
			-- On Falling edge, increasing delay counter
			if (clock_48kHz_sample="01") then
				if(counter>=delay_max) then counter <= 0;
				else counter <= counter + 1;
				end if;
				
				-- Setting up RAM's writing and reading address
				ram_read_adr <= std_logic_vector(to_signed(counter, 15)); 
				ram_write_adr <= ram_read_adr;
				
			end if;
			
		end if;
	
	end process; 
	
	-- RAM Reading
	process(clock_100MHz)
	begin
			-- Reading the delayed audio sample, stored x ms before
			if(rising_edge(clock_100MHz)) then
				
				if (clock_48kHz_sample="01") then echantillon_retard <= ram_output;
				end if;
				
			end if;
	
	end process;
	
	-- RAM Writing
	process(clock_100MHz)
	begin
	
			if(rising_edge(clock_100MHz)) then
			
				if clock_48kHz_sample="10" then
					-- Delay calculation
					produit_brut_s <= retard_in_s * AMORTISSEMENT;
					amorti_s <= produit_brut_s(31 DOWNTO 16);	
					-- Output combining input sample and previously stored sample
					sortie_calc_s <= ('0' & audio_in_s) + ('0' & amorti_s);

					-- Writing in memory the previously calculated sample (Dry voice + Delay)
					-- This logic lets the signal to be slowly diminished (avoiding harsh audio cutting
					ram_data <= std_logic_vector(sortie_calc_s(15 downto 0));
					ram_write_en <= '1'; 
				
				else
					ram_write_en <= '0';
				end if;
				
			end if;
	
	end process;
	
	-- Sorties (conversion du 17 bits SIGNED vers le 16 bits STD_LOGIC_VECTOR)
   sortie <= STD_LOGIC_VECTOR(sortie_calc_s(15 downto 0));
   audio_out <= sortie;

end delay_circuit;