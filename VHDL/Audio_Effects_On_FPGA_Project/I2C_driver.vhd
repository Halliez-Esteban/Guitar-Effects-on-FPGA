-- ================================================================================================
-- Written by Esteban Halliez
-- 
-- This file describes the I2C driver logic used in this project.
-- ================================================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee. Std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

entity I2C_driver is

	port
	(
		CLOCK			: in  std_logic;									-- 48 kHz clock given by "config_CODEC"
		GO				: in  std_logic;									-- Init Signal for I2C transmision ,
		DATA			: in	 std_logic_vector(23 downto 0);		-- Data to transmit , given by "config_CODEC"
		I2C_SDA		: inout  std_logic;	-- i2c clock
		I2C_SCL		: out  std_logic;		-- i2c clock
		SENT			: out  std_logic;		-- 1 in sleep mode, switches to 0 as the transmission begins, comes back to 1 as it finishes
		ACK			: out  std_logic		-- must value 0 if ACK is receveid with each byte being sent by the I2C transmision
	);
end I2C_driver;

architecture I2C of I2C_driver is

	signal data_to_send : std_logic_vector(23 downto 0);	-- Stores data to transmit
																			
	signal I2C_counter : integer range 0 to 63;		-- Counter incremented on rising edge, gives the position in the I2C sequency
	signal SDA : std_logic;									-- Data to transmit on i2c_SDA
	signal SCLK : std_logic;								-- Indicates if I2C_SCLK is stuck at 1
	signal ACK1 : std_logic;
	signal ACK2 : std_logic;
	signal ACK3 : std_logic;

begin

	I2C_SDA <= '0' when (SDA = '0') else 'Z';
	
	process(SCLK, I2C_counter, CLOCK) is
	begin
		if (SCLK = '1') then													-- If SCLK is at 1, I2C_SCL is at 1 too
			I2C_SCL <= '1';
		elsif (I2C_counter >= 4) AND (I2C_counter <= 30) then		-- when I2C_counter is between 4 and 30, I2C_SCLK is NOT(CLOCK)
			I2C_SCL <= NOT CLOCK;											-- (inverted because I2C_SDA switches on CLOCK rising edge, and the rising edges
																					-- from I2C_SCLK must be shifted)
		else
			I2C_SCL <= '0';													-- In other cases, I2C_SCL is at 0
		end if;
 	end process;
	
	ACK <= ACK1 OR ACK2 OR ACK3;		-- ACK = 0 if the I2C transmision is correct

	process(CLOCK, GO) is 
	begin 
		if(rising_edge(CLOCK)) then				-- i2c_counter set back to 0 when GO est actived (synchronous reset))
			if (GO = '0') then						-- then incremented until to its max value (0 to 63)
				I2C_counter <= 0;
			elsif (I2C_counter < 63) then
				I2C_counter <= I2C_counter + 1;
			else
				I2C_counter <= I2C_counter;
			end if;
		end if;
	end process;

	process(CLOCK, I2C_counter) is 
	begin 
			if(rising_edge(CLOCK)) then
				case I2C_counter is
				when 0 => SDA <= '1'; SCLK <= '1'; SENT <= '0'; ACK1 <= '0'; ACK2 <= '0'; ACK3 <= '0';
				-- start
				when 1 => SDA <= '0'; SCLK <= '1'; SENT <= '0'; data_to_send <= DATA;
				when 2 => SDA <= '0'; SCLK <= '0'; SENT <= '0';
				-- send slave address + Write
				when 3 => SDA <= data_to_send(23); SCLK <= '0'; SENT <= '0';
				when 4 => SDA <= data_to_send(22); SCLK <= '0'; SENT <= '0';
				when 5 => SDA <= data_to_send(21); SCLK <= '0'; SENT <= '0';
				when 6 => SDA <= data_to_send(20); SCLK <= '0'; SENT <= '0';
				when 7 => SDA <= data_to_send(19); SCLK <= '0'; SENT <= '0';
				when 8 => SDA <= data_to_send(18); SCLK <= '0'; SENT <= '0';
				when 9 => SDA <= data_to_send(17); SCLK <= '0'; SENT <= '0';
				when 10 => SDA <= data_to_send(16); SCLK <= '0'; SENT <= '0';
				when 11 => SDA <= '1'; SCLK <= '0'; SENT <= '0';						-- I2C_SDA at high impedance
				-- send next byte (7 bits for CODEC's register address + 1st bit of CODEC's register content)
				when 12 => SDA <= data_to_send(15); SCLK <= '0'; SENT <= '0';
							  ACK1 <= I2C_SDA;
				when 13 => SDA <= data_to_send(14); SCLK <= '0'; SENT <= '0';
				when 14 => SDA <= data_to_send(13); SCLK <= '0'; SENT <= '0';
				when 15 => SDA <= data_to_send(12); SCLK <= '0'; SENT <= '0';
				when 16 => SDA <= data_to_send(11); SCLK <= '0'; SENT <= '0';
				when 17 => SDA <= data_to_send(10); SCLK <= '0'; SENT <= '0';
				when 18 => SDA <= data_to_send(9); SCLK <= '0'; SENT <= '0';
				when 19 => SDA <= data_to_send(8); SCLK <= '0'; SENT <= '0';
				when 20 => SDA <= '1'; SCLK <= '0'; SENT <= '0';						-- I2C_SDA at high impedance
				-- send next byte (8 remaining bits of CODEC's register content)
				when 21 => SDA <= data_to_send(7); SCLK <= '0'; SENT <= '0';
							  ACK2 <= I2C_SDA;
				when 22 => SDA <= data_to_send(6); SCLK <= '0'; SENT <= '0';
				when 23 => SDA <= data_to_send(5); SCLK <= '0'; SENT <= '0';
				when 24 => SDA <= data_to_send(4); SCLK <= '0'; SENT <= '0';
				when 25 => SDA <= data_to_send(3); SCLK <= '0'; SENT <= '0';
				when 26 => SDA <= data_to_send(2); SCLK <= '0'; SENT <= '0';
				when 27 => SDA <= data_to_send(1); SCLK <= '0'; SENT <= '0';
				when 28 => SDA <= data_to_send(0); SCLK <= '0'; SENT <= '0';
				when 29 => SDA <= '1'; SCLK <= '0'; SENT <= '0';						-- I2C_SDA at high impedance
				-- stop
				when 30 => SDA <= '0'; SCLK <= '0'; SENT <= '0';
							  ACK3 <= I2C_SDA;
				when 31 => SDA <= '0'; SCLK <= '1'; SENT <= '0';
				when 32 => SDA <= '1'; SCLK <= '1'; SENT <= '1';
				when others => SDA <= '1'; SCLK <= '1'; SENT <= '1';
				end case;
			end if;
	end process;

end I2C;
