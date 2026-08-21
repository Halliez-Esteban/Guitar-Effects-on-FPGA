-- ================================================================================================
-- écrit par Jean-Marc Capron
-- 31 juillet 2014
--
-- Ce fichier décrit un filtre FIR à 37 coefficients symétriques (soit 19 coefficients différents),
-- le signal d'entrée du filtre est sur 16 bits,
-- les coefficients sont également sur 16 bits (déclarés comme un tableau de 19 x 16 bits).
-- ================================================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee. Std_logic_arith.all;
USE ieee.std_logic_signed.all;

PACKAGE package_19_by_16 IS
	type ARRAY_19_by_16 is array (18 downto 0) of STD_LOGIC_VECTOR(15 downto 0);
END PACKAGE package_19_by_16;

--LIBRARY work;								-- cette ligne est facultative
USE work.package_19_by_16.all;

LIBRARY ieee;									-- cette partie doit être recopiée,
USE ieee.std_logic_1164.ALL;				-- sinon, STD_LOGIC et STD_LOGIC_VECTOR
USE ieee. Std_logic_arith.all;			-- ne sont pas reconnus
USE ieee.std_logic_signed.all;			-- même si "LIBRARY ieee; etc." a déjà été mis au début de ce fichier


entity FIR_filter_37_tap is
-- 37-tap filter with symetrical coefficients => 19 different coefficients
	port
	(
		clock_in		: in  std_logic;
		filter_in	: in  std_logic_vector(15 downto 0);
		coef			: in	ARRAY_19_by_16;							-- 19 coefficients, each 16-bit wide
		filter_out	: out	 std_logic_vector(37 downto 0)	
	);
end FIR_filter_37_tap;

architecture FIR_37_tap of FIR_filter_37_tap is

	type ARRAY_37_by_16 is array (36 downto 0) of STD_LOGIC_VECTOR(15 downto 0);
	signal input_sample : ARRAY_37_by_16;														-- 37 16-bit input samples

	type ARRAY_19_by_17 is array (18 downto 0) of STD_LOGIC_VECTOR(16 downto 0);
	signal partial_sum : ARRAY_19_by_17;														-- 19 17-bit partial sums

	type ARRAY_19_by_33 is array (18 downto 0) of STD_LOGIC_VECTOR(32 downto 0);
	signal product : ARRAY_19_by_33;																-- 19 33-bit products (17-bit partial sum * 16-bit coefficient)

	type ARRAY_19_by_38 is array (18 downto 0) of STD_LOGIC_VECTOR(37 downto 0);
	signal ext_product : ARRAY_19_by_38;														-- 19 38-bit extended products
																											-- the width extension is needed since all products will be added
																											-- to give a 38-bit result
																										
begin

	process(clock_in) is 
	begin													-- shift register to store
		if(rising_edge(clock_in)) then			-- the successive input samples
															-- (37 samples, each 16-bit wide)
		input_sample(0) <= filter_in;
 
		for i in 1 to 36 loop
			input_sample(i) <= input_sample(i-1);
		end loop;

		end if;
	end process;
	
	process(input_sample) is 
	begin
		for i in 0 to 17 loop
			partial_sum(i) <= (input_sample(i)(15) & input_sample(i)) + (input_sample(36-i)(15) & input_sample(36-i));
									-- sum output is 17-bit, so sum inputs must be extended to the same width
		end loop;
	end process;
	
	partial_sum(18) <= input_sample(18)(15) & input_sample(18);				-- the number of samples is odd, so the middle one is alone

	process(partial_sum, coef) is 
	begin
		for i in 0 to 18 loop
			product(i) <= partial_sum(i) * coef(i);
		end loop;
	end process;

	process(product) is 
	begin
		for i in 0 to 18 loop
			ext_product(i) <= product(i)(32) & product(i)(32) & product(i)(32) & product(i)(32) & product(i)(32) & product(i);
		end loop;			-- 33-bit product extended to 38-bit ext_product
	end process;


	filter_out <=	ext_product(0) + ext_product(1) + ext_product(2) + ext_product(3)
						+ ext_product(4) + ext_product(5) + ext_product(6) + ext_product(7)
						+ ext_product(8) + ext_product(9) + ext_product(10) + ext_product(11)
						+ ext_product(12) + ext_product(13) + ext_product(14) + ext_product(15)
						+ ext_product(16) + ext_product(17) + ext_product(18);

end FIR_37_tap;