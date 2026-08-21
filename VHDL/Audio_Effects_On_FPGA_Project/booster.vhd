-- ================================================================================================
-- Written by Esteban Halliez
--
-- This files describes the gain logic applied to the "distorsion" component 
-- ================================================================================================


library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity booster is
	port(
		--I/O:
		sample_in  : in std_logic_vector(15 downto 0);
		sample_out : out std_logic_vector(15 downto 0);
		--Parameters:
		multiplier : in std_logic_vector(15 downto 0)
	);
end entity booster;

architecture a of booster is
	signal signal_unnormalized: std_logic_vector(31 downto 0);
	begin
		
		signal_unnormalized<=signed(sample_in)*signed(multiplier);
		boost: process(signal_unnormalized)
		begin
			if (signal_unnormalized(31) = '1') then --Negative case
				sample_out <= '1' & signal_unnormalized(22 downto 8);
			else --Positive case
				sample_out <= '0' & signal_unnormalized(22 downto 8);
			end if;
	end process;
	
end architecture a;