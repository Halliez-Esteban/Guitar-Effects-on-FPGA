-- ================================================================================================
-- Written by Esteban Halliez
-- 
-- This file is a hard written Sinus LUT used for effects
-- ================================================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SinusLUT is
    Port (
        clk      : in  std_logic;
        address  : in  std_logic_vector(7 downto 0); -- 256 positions
        data_out : out std_logic_vector(6 downto 0)  -- Max Value 127 (7 bits)
    );
end SinusLUT;

architecture Behavioral of SinusLUT is
    type rom_type is array (0 to 255) of std_logic_vector(6 downto 0);
    
    constant SINE_TABLE : rom_type := (
        conv_std_logic_vector(64, 7), conv_std_logic_vector(65, 7), conv_std_logic_vector(67, 7), conv_std_logic_vector(68, 7), 
        conv_std_logic_vector(70, 7), conv_std_logic_vector(71, 7), conv_std_logic_vector(73, 7), conv_std_logic_vector(74, 7),
        conv_std_logic_vector(76, 7), conv_std_logic_vector(77, 7), conv_std_logic_vector(79, 7), conv_std_logic_vector(80, 7), 
        conv_std_logic_vector(82, 7), conv_std_logic_vector(83, 7), conv_std_logic_vector(85, 7), conv_std_logic_vector(86, 7),
        conv_std_logic_vector(88, 7), conv_std_logic_vector(89, 7), conv_std_logic_vector(91, 7), conv_std_logic_vector(92, 7), 
        conv_std_logic_vector(93, 7), conv_std_logic_vector(95, 7), conv_std_logic_vector(96, 7), conv_std_logic_vector(97, 7),
        conv_std_logic_vector(99, 7), conv_std_logic_vector(100, 7), conv_std_logic_vector(101, 7), conv_std_logic_vector(103, 7), 
        conv_std_logic_vector(104, 7), conv_std_logic_vector(105, 7), conv_std_logic_vector(106, 7), conv_std_logic_vector(107, 7),
        conv_std_logic_vector(108, 7), conv_std_logic_vector(109, 7), conv_std_logic_vector(111, 7), conv_std_logic_vector(112, 7), 
        conv_std_logic_vector(113, 7), conv_std_logic_vector(114, 7), conv_std_logic_vector(115, 7), conv_std_logic_vector(115, 7),
        conv_std_logic_vector(116, 7), conv_std_logic_vector(117, 7), conv_std_logic_vector(118, 7), conv_std_logic_vector(119, 7), 
        conv_std_logic_vector(120, 7), conv_std_logic_vector(120, 7), conv_std_logic_vector(121, 7), conv_std_logic_vector(122, 7),
        conv_std_logic_vector(122, 7), conv_std_logic_vector(123, 7), conv_std_logic_vector(123, 7), conv_std_logic_vector(124, 7), 
        conv_std_logic_vector(124, 7), conv_std_logic_vector(125, 7), conv_std_logic_vector(125, 7), conv_std_logic_vector(125, 7),
        conv_std_logic_vector(126, 7), conv_std_logic_vector(126, 7), conv_std_logic_vector(126, 7), conv_std_logic_vector(127, 7), 
        conv_std_logic_vector(127, 7), conv_std_logic_vector(127, 7), conv_std_logic_vector(127, 7), conv_std_logic_vector(127, 7),
        conv_std_logic_vector(127, 7), conv_std_logic_vector(127, 7), conv_std_logic_vector(127, 7), conv_std_logic_vector(127, 7), 
        conv_std_logic_vector(127, 7), conv_std_logic_vector(127, 7), conv_std_logic_vector(126, 7), conv_std_logic_vector(126, 7),
        conv_std_logic_vector(126, 7), conv_std_logic_vector(125, 7), conv_std_logic_vector(125, 7), conv_std_logic_vector(125, 7), 
        conv_std_logic_vector(124, 7), conv_std_logic_vector(124, 7), conv_std_logic_vector(123, 7), conv_std_logic_vector(123, 7),
        conv_std_logic_vector(122, 7), conv_std_logic_vector(122, 7), conv_std_logic_vector(121, 7), conv_std_logic_vector(120, 7), 
        conv_std_logic_vector(120, 7), conv_std_logic_vector(119, 7), conv_std_logic_vector(118, 7), conv_std_logic_vector(117, 7),
        conv_std_logic_vector(116, 7), conv_std_logic_vector(115, 7), conv_std_logic_vector(115, 7), conv_std_logic_vector(114, 7), 
        conv_std_logic_vector(113, 7), conv_std_logic_vector(112, 7), conv_std_logic_vector(111, 7), conv_std_logic_vector(109, 7),
        conv_std_logic_vector(108, 7), conv_std_logic_vector(107, 7), conv_std_logic_vector(106, 7), conv_std_logic_vector(105, 7), 
        conv_std_logic_vector(104, 7), conv_std_logic_vector(103, 7), conv_std_logic_vector(101, 7), conv_std_logic_vector(100, 7),
        conv_std_logic_vector(99, 7), conv_std_logic_vector(97, 7), conv_std_logic_vector(96, 7), conv_std_logic_vector(95, 7), 
        conv_std_logic_vector(93, 7), conv_std_logic_vector(92, 7), conv_std_logic_vector(91, 7), conv_std_logic_vector(89, 7),
        conv_std_logic_vector(88, 7), conv_std_logic_vector(86, 7), conv_std_logic_vector(85, 7), conv_std_logic_vector(83, 7), 
        conv_std_logic_vector(82, 7), conv_std_logic_vector(80, 7), conv_std_logic_vector(79, 7), conv_std_logic_vector(77, 7),
        conv_std_logic_vector(76, 7), conv_std_logic_vector(74, 7), conv_std_logic_vector(73, 7), conv_std_logic_vector(71, 7), 
        conv_std_logic_vector(70, 7), conv_std_logic_vector(68, 7), conv_std_logic_vector(67, 7), conv_std_logic_vector(65, 7),
        conv_std_logic_vector(64, 7), conv_std_logic_vector(62, 7), conv_std_logic_vector(60, 7), conv_std_logic_vector(59, 7), 
        conv_std_logic_vector(57, 7), conv_std_logic_vector(56, 7), conv_std_logic_vector(54, 7), conv_std_logic_vector(53, 7),
        conv_std_logic_vector(51, 7), conv_std_logic_vector(50, 7), conv_std_logic_vector(48, 7), conv_std_logic_vector(47, 7), 
        conv_std_logic_vector(45, 7), conv_std_logic_vector(44, 7), conv_std_logic_vector(42, 7), conv_std_logic_vector(41, 7),
        conv_std_logic_vector(39, 7), conv_std_logic_vector(38, 7), conv_std_logic_vector(36, 7), conv_std_logic_vector(35, 7), 
        conv_std_logic_vector(34, 7), conv_std_logic_vector(32, 7), conv_std_logic_vector(31, 7), conv_std_logic_vector(30, 7),
        conv_std_logic_vector(28, 7), conv_std_logic_vector(27, 7), conv_std_logic_vector(26, 7), conv_std_logic_vector(24, 7), 
        conv_std_logic_vector(23, 7), conv_std_logic_vector(22, 7), conv_std_logic_vector(21, 7), conv_std_logic_vector(20, 7),
        conv_std_logic_vector(19, 7), conv_std_logic_vector(18, 7), conv_std_logic_vector(16, 7), conv_std_logic_vector(15, 7), 
        conv_std_logic_vector(14, 7), conv_std_logic_vector(13, 7), conv_std_logic_vector(12, 7), conv_std_logic_vector(12, 7),
        conv_std_logic_vector(11, 7), conv_std_logic_vector(10, 7), conv_std_logic_vector(9, 7), conv_std_logic_vector(8, 7), 
        conv_std_logic_vector(7, 7), conv_std_logic_vector(7, 7), conv_std_logic_vector(6, 7), conv_std_logic_vector(5, 7),
        conv_std_logic_vector(5, 7), conv_std_logic_vector(4, 7), conv_std_logic_vector(4, 7), conv_std_logic_vector(3, 7), 
        conv_std_logic_vector(3, 7), conv_std_logic_vector(2, 7), conv_std_logic_vector(2, 7), conv_std_logic_vector(2, 7),
        conv_std_logic_vector(1, 7), conv_std_logic_vector(1, 7), conv_std_logic_vector(1, 7), conv_std_logic_vector(0, 7), 
        conv_std_logic_vector(0, 7), conv_std_logic_vector(0, 7), conv_std_logic_vector(0, 7), conv_std_logic_vector(0, 7),
        conv_std_logic_vector(0, 7), conv_std_logic_vector(0, 7), conv_std_logic_vector(0, 7), conv_std_logic_vector(0, 7), 
        conv_std_logic_vector(0, 7), conv_std_logic_vector(0, 7), conv_std_logic_vector(1, 7), conv_std_logic_vector(1, 7),
        conv_std_logic_vector(1, 7), conv_std_logic_vector(2, 7), conv_std_logic_vector(2, 7), conv_std_logic_vector(2, 7), 
        conv_std_logic_vector(3, 7), conv_std_logic_vector(3, 7), conv_std_logic_vector(4, 7), conv_std_logic_vector(4, 7),
        conv_std_logic_vector(5, 7), conv_std_logic_vector(5, 7), conv_std_logic_vector(6, 7), conv_std_logic_vector(7, 7), 
        conv_std_logic_vector(7, 7), conv_std_logic_vector(8, 7), conv_std_logic_vector(9, 7), conv_std_logic_vector(10, 7),
        conv_std_logic_vector(11, 7), conv_std_logic_vector(12, 7), conv_std_logic_vector(12, 7), conv_std_logic_vector(13, 7), 
        conv_std_logic_vector(14, 7), conv_std_logic_vector(15, 7), conv_std_logic_vector(16, 7), conv_std_logic_vector(18, 7),
        conv_std_logic_vector(19, 7), conv_std_logic_vector(20, 7), conv_std_logic_vector(21, 7), conv_std_logic_vector(22, 7), 
        conv_std_logic_vector(23, 7), conv_std_logic_vector(24, 7), conv_std_logic_vector(26, 7), conv_std_logic_vector(27, 7),
        conv_std_logic_vector(28, 7), conv_std_logic_vector(30, 7), conv_std_logic_vector(31, 7), conv_std_logic_vector(32, 7), 
        conv_std_logic_vector(34, 7), conv_std_logic_vector(35, 7), conv_std_logic_vector(36, 7), conv_std_logic_vector(38, 7),
        conv_std_logic_vector(39, 7), conv_std_logic_vector(41, 7), conv_std_logic_vector(42, 7), conv_std_logic_vector(44, 7), 
        conv_std_logic_vector(45, 7), conv_std_logic_vector(47, 7), conv_std_logic_vector(48, 7), conv_std_logic_vector(50, 7),
        conv_std_logic_vector(51, 7), conv_std_logic_vector(53, 7), conv_std_logic_vector(54, 7), conv_std_logic_vector(56, 7), 
        conv_std_logic_vector(57, 7), conv_std_logic_vector(59, 7), conv_std_logic_vector(60, 7), conv_std_logic_vector(62, 7)
    );

begin
    process(clk)
    begin
        if rising_edge(clk) then
            data_out <= SINE_TABLE(conv_integer(address));
        end if;
    end process;
end Behavioral;