LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

ENTITY key_detect IS
	
	--Detecting button trigger
	
	PORT(CLOCK_50 : IN STD_LOGIC;
	KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	key0_pressed : OUT STD_LOGIC;
	key1_pressed : OUT STD_LOGIC);
	
END key_detect;

ARCHITECTURE key_detect_circuit OF key_detect IS

signal counter50k : std_logic_vector(10 downto 0) := (others => '0'); --Dividing the MCLK by 1000
signal bitRegister0 : STD_LOGIC_VECTOR(3 DOWNTO 0); --Registers storing last 4 values of the button
signal bitRegister1 : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

	PROCESS(CLOCK_50)
	BEGIN
	
	--Detecting clock rising edge
		IF rising_edge(CLOCK_50) THEN
				
		--Dividing MCLK by 1000 with a counter
			
			IF (unsigned(counter50k) = to_unsigned(999, counter50k'length)) THEN 
				counter50k <=(others => '0');
				
				--Sampling at 50kHz both buttons
				
				FOR i in 1 TO 3 LOOP
				bitRegister0(i) <= bitRegister0(i-1);
				bitRegister1(i) <= bitRegister1(i-1);
				END LOOP;
				
				bitRegister0(0) <= KEY(0);
				bitRegister1(0) <= KEY(1);
				
				--Press Detected
				
				IF bitRegister0 = "0011" THEN key0_pressed <= '0' ;
				ELSE key0_pressed <= '1';
				END IF;
				
				IF bitRegister1 = "0011" THEN key1_pressed <= '0';
				ELSE key1_pressed <= '1';
				END IF;
				
				
			ELSE counter50k <= std_logic_vector(unsigned(counter50k) + 1);
			END IF;
			
		END IF;
		
	END PROCESS;
	
END key_detect_circuit ;