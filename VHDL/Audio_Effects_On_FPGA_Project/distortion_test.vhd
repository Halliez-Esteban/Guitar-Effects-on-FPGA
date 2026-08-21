-- ================================================================================================
-- Written by Esteban Halliez
-- 
-- This file describes the first implementaion of a distorsion effect I've tried.
-- Its result is noisy and rough but remains a greatoverview of the test process.
-- ================================================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity distortion_test is
	port
	(
		-- Clock
		clock_48kHz : in std_logic;
		
		-- Audio Signal
		audio_in : in std_logic_vector(15 downto 0);
		audio_out : out std_logic_vector(15 downto 0)
	distortion_test
end distortion;

architecture distortion_test_circuit of distortion_test is
	
	-- x12.0 Gain
    constant C_GAIN_12_0 : signed(15 downto 0) := to_signed(12, 16); 
    
    -- Clipping constants Q1.15 (+1 and -1)
    constant C_MAX_Q1_15 : signed(15 downto 0) := to_signed(32767, 16);
    constant C_MIN_Q1_15 : signed(15 downto 0) := to_signed(-32768, 16);
	
	-- Calculation
	
	signal echantillon : signed(15 downto 0);
	signal produit_brut : signed(31 downto 0); --Amplified output on 32bits..16X16

   signal sortie_amplifiee : signed(15 downto 0); -- Q1.15 Signal after shifting
   signal sortie_clipped : signed(15 downto 0); -- Clipped final signal (Q1.15)	
	
begin
	
	echantillon <= signed(audio_in); 
	
	--Distortion (Harsh Amplification)
	
	process(clock_48kHz)
	begin
		if rising_edge(clock_48kHz) then
			
			produit_brut <= echantillon * C_GAIN_12_0;
			sortie_amplifiee <= produit_brut(16 downto 1);
			
			-- Clipping (Harsh Clipping)
         if sortie_amplifiee > C_MAX_Q1_15 then
				sortie_clipped <= C_MAX_Q1_15; -- Clip at +1.0
         elsif sortie_amplifiee < C_MIN_Q1_15 then
            sortie_clipped <= C_MIN_Q1_15; -- Clip at -1.0
         else
            sortie_clipped <= sortie_amplifiee;
         end if;
			
			
		end if;
	end process;
		
	-- Output (16 bits SIGNED to 16 bits STD_LOGIC_VECTOR conversion)
   audio_out <= STD_LOGIC_VECTOR(sortie_amplifiee(15 downto 0));

end distortion_test_circuit;