LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee. Std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

entity parallel_to_serial is

	port
	(
		BCLK			: in  std_logic;
		DACLRC		: in  std_logic;
		left_in		: in	std_logic_vector(15 downto 0);
		right_in		: in	std_logic_vector(15 downto 0);
		DACDAT		: out  std_logic
	);
end parallel_to_serial;

architecture par_to_ser of parallel_to_serial is

	signal DACLRC_sample : std_logic_vector(1 downto 0);		-- Stores the two last samples from ADCLRC
	signal DACLRC_falling : std_logic;								-- ADCLRC falling edge
	signal DACLRC_rising : std_logic;								-- ADCLRC rising edge
	signal counter : integer range 0 to 31;					
	signal left_shift_reg : std_logic_vector(15 downto 0);	-- Stores serial input
	signal right_shift_reg : std_logic_vector(15 downto 0);
	

begin

	process(BCLK) is  						-- shift register to store DACLRC
	begin											
		if (rising_edge(BCLK)) then
			DACLRC_sample(1 downto 0) <= DACLRC & DACLRC_sample(1);
		end if;
	end process;

	process(BCLK, DACLRC_sample) is  	-- DACLRC_falling and DACLRC_rising evaluation (modified on BCLK falling edge:
	begin											
		if (falling_edge(BCLK)) then
			if (DACLRC_sample(1) = '0') AND (DACLRC_sample(0) = '1') then		-- DACLRC is now 0, was 1
				DACLRC_falling <= '1';
				DACLRC_rising <= '0';
			elsif (DACLRC_sample(1) = '1') AND (DACLRC_sample(0) = '0') then	-- DACLRC is now 1, was 0
				DACLRC_falling <= '0';
				DACLRC_rising <= '1';
			else
				DACLRC_falling <= '0';
				DACLRC_rising <= '0';
			end if;

		end if;
	end process;

	process(BCLK, DACLRC_falling, DACLRC_rising) is  						
	begin																					
		if (rising_edge(BCLK)) then												
			if ((DACLRC_falling = '1') OR (DACLRC_rising = '1')) then	
				counter <= 0;
			elsif (counter < 31) then
				counter <= counter + 1;
			else
				counter <= counter;
			end if;
		end if;
	end process;

	process(BCLK, counter, DACLRC) is  															-- Shift register reading serial input
	begin 																								-- sampled on BCLK rising edge
		if(falling_edge(BCLK)) then
			if (counter >= 0) AND (counter <= 14) AND (DACLRC = '0')then				-- shifted 15 times
				left_shift_reg(15 downto 0) <= left_shift_reg(14 downto 0) & '0';		-- (MSB first)

			elsif (counter = 15) AND (DACLRC = '0') then										-- shifted 15 times
				left_shift_reg(15 downto 0) <= left_in(15 downto 0);						-- 16 bits are read by the CODEC
																											-- => we can change its value
			else
				left_shift_reg(15 downto 0) <= left_shift_reg(15 downto 0);
			end if;
		end if;
	end process;

	process(BCLK, counter, DACLRC) is  															-- Shift register reading serial input
	begin 																								-- sampled on BCLK rising edge
		if(falling_edge(BCLK)) then
			if (counter >= 0) AND (counter <= 14) AND (DACLRC = '1')then				-- shifted 15 times
				right_shift_reg(15 downto 0) <= right_shift_reg(14 downto 0) & '0';	-- (MSB first)

			elsif (counter = 15) AND (DACLRC = '1') then										-- register has been shifted 15 times
				right_shift_reg(15 downto 0) <= right_in(15 downto 0);					-- 16 bits are read by the CODEC
																											-- => we can change its value
			else
				right_shift_reg(15 downto 0) <= right_shift_reg(15 downto 0);
			end if;
		end if;
	end process;


	DACDAT <= left_shift_reg(15) when (DACLRC = '0') else right_shift_reg(15);

end par_to_ser;
