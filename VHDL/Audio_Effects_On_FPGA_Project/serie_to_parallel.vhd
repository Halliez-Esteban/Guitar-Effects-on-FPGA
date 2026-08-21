LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee. Std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

entity serial_to_parallel is

	port
	(
		BCLK			: in  std_logic;
		ADCLRC		: in  std_logic;
		ADCDAT		: in  std_logic;
		left_out		: out	std_logic_vector(15 downto 0);
		right_out	: out	std_logic_vector(15 downto 0)
	);
end serial_to_parallel;

architecture ser_to_par of serial_to_parallel is

	signal ADCLRC_sample : std_logic_vector(1 downto 0);		-- Stores the two last samples from ADCLRC
	signal ADCLRC_falling : std_logic;								-- ADCLRC falling edge
	signal ADCLRC_rising : std_logic;								-- ADCLRC rising edge
	signal counter : integer range 0 to 31;						
	signal left_shift_reg : std_logic_vector(15 downto 0);	-- Stores serial input
	signal right_shift_reg : std_logic_vector(15 downto 0);
	signal left_data : std_logic_vector(15 downto 0);			-- Input put on parallel on 16 bits
	signal right_data : std_logic_vector(15 downto 0);
	

begin

	process(BCLK) is  						-- Shift register to store the two last samples from ADCLRC
	begin											
		if (rising_edge(BCLK)) then
			ADCLRC_sample(1 downto 0) <= ADCLRC & ADCLRC_sample(1);
		end if;
	end process;
	
	ADCLRC_falling <= (NOT ADCLRC_sample(1)) AND ADCLRC_sample(0);		-- signals at 1 during one périod of BCLK
	ADCLRC_rising <= (ADCLRC_sample(1)) AND (NOT ADCLRC_sample(0));	-- if ADCLRC changes
	
	process(BCLK, ADCLRC_falling, ADCLRC_rising) is  						
	begin																					
		if (falling_edge(BCLK)) then												
			if ((ADCLRC_falling = '1') OR (ADCLRC_rising = '1')) then	
				counter <= 0;
			elsif (counter < 31) then
				counter <= counter + 1;
			else
				counter <= counter;
			end if;
		end if;
	end process;

	process(BCLK, counter, ADCLRC) is  															-- Shift register reading serial input
	begin 																								-- Shifted on BCLK rising edge
		if(rising_edge(BCLK)) then
			if (counter >= 0) AND (counter <= 15) AND (ADCLRC = '0')then
				left_shift_reg(15 downto 0) <= left_shift_reg(14 downto 0) & ADCDAT;	-- Shifting register with ADCDAT loading from the right 
				left_data(15 downto 0) <= left_data(15 downto 0);							-- (MSB first)
				
			elsif (counter = 16) AND (ADCLRC = '0') then
				left_shift_reg(15 downto 0) <= left_shift_reg(15 downto 0);				-- 16 left bits received
				left_data(15 downto 0) <= left_shift_reg(15 downto 0);					-- => we update left_data

			else
				left_shift_reg(15 downto 0) <= left_shift_reg(15 downto 0);
				left_data(15 downto 0) <= left_data(15 downto 0);
			end if;
		end if;
	end process;
	
	process(BCLK, counter, ADCLRC) is  
	begin 
		if(rising_edge(BCLK)) then
			if (counter >= 0) AND (counter <= 15) AND (ADCLRC = '1')then
				right_shift_reg(15 downto 0) <= right_shift_reg(14 downto 0) & ADCDAT;	-- Shifting register with ADCDAT loading from the right 
				right_data(15 downto 0) <= right_data(15 downto 0);							-- (MSB first)
				
			elsif (counter = 16) AND (ADCLRC = '1') then
				right_shift_reg(15 downto 0) <= right_shift_reg(15 downto 0);				-- 16 right bits received
				right_data(15 downto 0) <= right_shift_reg(15 downto 0);						-- => we update right_data

			else
				right_shift_reg(15 downto 0) <= right_shift_reg(15 downto 0);
				right_data(15 downto 0) <= right_data(15 downto 0);
			end if;
		end if;
	end process;

	left_out(15 downto 0) <= left_data(15 downto 0);
	right_out(15 downto 0) <= right_data(15 downto 0);

end ser_to_par;
