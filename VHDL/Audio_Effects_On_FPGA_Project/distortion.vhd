-- ================================================================================================
-- Written by Esteban Halliez
-- 
-- This file describes the distortion component.
-- It is based on the "booster" component.
-- This entity over-amplify the audio input signal and clip it harshly.
-- ================================================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity distortion is
	port(
		--I/O:
		sample_in  : in std_logic_vector(15 downto 0);
		sample_out : out std_logic_vector(15 downto 0);
		--Parameters:
		gain : in std_logic_vector(15 downto 0);
		dist_pos : in std_logic_vector(15 downto 0)
	);
end entity distortion;

architecture distortion_circuit of distortion is

	component booster
		port (
			sample_in : in	std_logic_vector(15 downto 0);
			multiplier : in	std_logic_vector(15 downto 0);
			sample_out : out std_logic_vector(15 downto 0)
		);
	end component;

	signal dist_neg: std_logic_vector(15 downto 0);
	signal signal_dist: std_logic_vector(15 downto 0);
begin
	dist_neg<= -dist_pos;
	boost: process(dist_pos, dist_neg)
	--Clipping logic
	begin
		if (sample_in(15) = '1') then --Negative case
			if (signed(sample_in(15 downto 0))<signed(dist_neg(15 downto 0))) then
				signal_dist <= dist_neg;
			else
				signal_dist <= sample_in;
			end if;
		else --Positive case
			if (signed(sample_in(15 downto 0))>signed(dist_pos(15 downto 0))) then
				signal_dist <= dist_pos;
			else
				signal_dist <= sample_in;
			end if;
		end if;

	end process;
	--Gain logic component
	s1 : booster
		port map (	
				sample_in => signal_dist,
				multiplier => gain,
				sample_out => sample_out 	
		);
end architecture distortion_circuit;