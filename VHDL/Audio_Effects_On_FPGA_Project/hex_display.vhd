LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.Std_logic_arith.all;


ENTITY HEX_DISPLAY IS
	PORT (volume_level: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));


END HEX_DISPLAY;

ARCHITECTURE HEX_DISPLAY_Circuit OF HEX_DISPLAY IS

	
ALIAS segments_tens : STD_LOGIC_VECTOR(6 DOWNTO 0) IS HEX1;
ALIAS segments_units : STD_LOGIC_VECTOR(6 DOWNTO 0) IS HEX0;

BEGIN

	process(volume_level)
		begIN
			if(volume_level="00000") then segments_units <= "1111001";segments_tens <= "1000000";
			elsif(volume_level="00001") then segments_units <= "0100100";segments_tens <= "1000000";
			elsif(volume_level="00010") then segments_units <= "0110000";segments_tens <= "1000000";
			elsif(volume_level="00011") then segments_units <= "0011001";segments_tens <= "1000000";
			elsif(volume_level="00100") then segments_units <= "0010010";segments_tens <= "1000000";
			elsif(volume_level="00101") then segments_units <= "0000010";segments_tens <= "1000000";
			elsif(volume_level="00110") then segments_units <= "1111000";segments_tens <= "1000000";
			elsif(volume_level="00111") then segments_units <= "0000000";segments_tens <= "1000000";
			elsif(volume_level="01000") then segments_units <= "0010000";segments_tens <= "1000000";
			elsif(volume_level="01001") then segments_units <= "1000000";segments_tens <= "1111001";
			elsif(volume_level="01010") then segments_units <= "1111001";segments_tens <= "1111001";
			elsif(volume_level="01011") then segments_units <= "0100100";segments_tens <= "1111001";
			elsif(volume_level="01100") then segments_units <= "0110000";segments_tens <= "1111001";
			elsif(volume_level="01101") then segments_units <= "0011001";segments_tens <= "1111001";
			elsif(volume_level="01110") then segments_units <= "0010010";segments_tens <= "1111001";
			elsif(volume_level="01111") then segments_units <= "0000010";segments_tens <= "1111001";
			elsif(volume_level="10000") then segments_units <= "1111000";segments_tens <= "1111001";
			elsif(volume_level="10001") then segments_units <= "0000000";segments_tens <= "1111001";
			elsif(volume_level="10010") then segments_units <= "0010000";segments_tens <= "1111001";
			elsif(volume_level="10011") then segments_units <= "1000000";segments_tens <= "0100100";
			elsif(volume_level="10100") then segments_units <= "1111001";segments_tens <= "0100100";
			elsif(volume_level="10101") then segments_units <= "0100100";segments_tens <= "0100100";
			elsif(volume_level="10110") then segments_units <= "0110000";segments_tens <= "0100100";
			elsif(volume_level="10111") then segments_units <= "0011001";segments_tens <= "0100100";
			elsif(volume_level="11000") then segments_units <= "0010010";segments_tens <= "0100100";
			elsif(volume_level="11001") then segments_units <= "0000010";segments_tens <= "0100100";
			elsif(volume_level="11010") then segments_units <= "1111000";segments_tens <= "0100100";
			elsif(volume_level="11011") then segments_units <= "0000000";segments_tens <= "0100100";
			elsif(volume_level="11100") then segments_units <= "0010000";segments_tens <= "0100100";
			elsif(volume_level="11101") then segments_units <= "1000000";segments_tens <= "0110000";
			elsif(volume_level="11110") then segments_units <= "1111001";segments_tens <= "0110000";
			elsif(volume_level="11111") then segments_units <= "0100100";segments_tens <= "0110000";
			else segments_units <= "1111111";segments_tens <= "1111111";

			end if;
	end process;


END HEX_DISPLAY_Circuit;


