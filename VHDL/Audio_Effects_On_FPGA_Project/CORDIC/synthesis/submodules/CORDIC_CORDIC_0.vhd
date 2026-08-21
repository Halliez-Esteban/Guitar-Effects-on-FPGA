-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 19.1 (Release Build #670)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2019 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from CORDIC_CORDIC_0
-- VHDL created on Thu Apr 16 01:40:17 2026


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity CORDIC_CORDIC_0 is
    port (
        x : in std_logic_vector(16 downto 0);  -- sfix17_en15
        y : in std_logic_vector(16 downto 0);  -- sfix17_en15
        a : in std_logic_vector(17 downto 0);  -- sfix18_en15
        xo : out std_logic_vector(17 downto 0);  -- sfix18_en15
        yo : out std_logic_vector(17 downto 0);  -- sfix18_en15
        clk : in std_logic;
        areset : in std_logic
    );
end CORDIC_CORDIC_0;

architecture normal of CORDIC_CORDIC_0 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstPiO2_uid8_vecRotateTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal absAECostZeroPaddingA_uid9_vecRotateTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal absAENA_uid10_vecRotateTest_q : STD_LOGIC_VECTOR (25 downto 0);
    signal absAEsumAHighB_uid11_vecRotateTest_a : STD_LOGIC_VECTOR (27 downto 0);
    signal absAEsumAHighB_uid11_vecRotateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal absAEsumAHighB_uid11_vecRotateTest_o : STD_LOGIC_VECTOR (27 downto 0);
    signal absAEsumAHighB_uid11_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal absAEsumAHighB_uid11_vecRotateTest_q : STD_LOGIC_VECTOR (26 downto 0);
    signal invMsbuAbsAE_uid13_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal firstQuadrantCond1_uid14_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invSignA_uid15_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal firstQuadrantCond0_uid16_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal firstQuadrant_uid17_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aInFirstQuadrant_mergedSignalTM_uid20_vecRotateTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal absA_uid23_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal absA_uid23_vecRotateTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal padACst_uid24_vecRotateTest_q : STD_LOGIC_VECTOR (14 downto 0);
    signal aPostPad_uid25_vecRotateTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal mx_uid26_vecRotateTest_a : STD_LOGIC_VECTOR (18 downto 0);
    signal mx_uid26_vecRotateTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal mx_uid26_vecRotateTest_o : STD_LOGIC_VECTOR (18 downto 0);
    signal mx_uid26_vecRotateTest_q : STD_LOGIC_VECTOR (17 downto 0);
    signal mxR_uid27_vecRotateTest_in : STD_LOGIC_VECTOR (16 downto 0);
    signal mxR_uid27_vecRotateTest_b : STD_LOGIC_VECTOR (16 downto 0);
    signal my_uid30_vecRotateTest_a : STD_LOGIC_VECTOR (18 downto 0);
    signal my_uid30_vecRotateTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal my_uid30_vecRotateTest_o : STD_LOGIC_VECTOR (18 downto 0);
    signal my_uid30_vecRotateTest_q : STD_LOGIC_VECTOR (17 downto 0);
    signal myR_uid31_vecRotateTest_in : STD_LOGIC_VECTOR (16 downto 0);
    signal myR_uid31_vecRotateTest_b : STD_LOGIC_VECTOR (16 downto 0);
    signal concSignAFirstQuadrant_uid32_vecRotateTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal absX_uid33_vecRotateTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal absX_uid33_vecRotateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal absY_uid34_vecRotateTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal absY_uid34_vecRotateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal xMSB_uid36_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid38_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_0_uid41_vecRotateTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal xip1E_1_uid43_vecRotateTest_a : STD_LOGIC_VECTOR (18 downto 0);
    signal xip1E_1_uid43_vecRotateTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal xip1E_1_uid43_vecRotateTest_o : STD_LOGIC_VECTOR (18 downto 0);
    signal xip1E_1_uid43_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_1_uid43_vecRotateTest_q : STD_LOGIC_VECTOR (17 downto 0);
    signal yip1E_1_uid44_vecRotateTest_a : STD_LOGIC_VECTOR (18 downto 0);
    signal yip1E_1_uid44_vecRotateTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal yip1E_1_uid44_vecRotateTest_o : STD_LOGIC_VECTOR (18 downto 0);
    signal yip1E_1_uid44_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_1_uid44_vecRotateTest_q : STD_LOGIC_VECTOR (17 downto 0);
    signal aip1E_1CostZeroPaddingA_uid46_vecRotateTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal aip1E_1NA_uid47_vecRotateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_1sumAHighB_uid48_vecRotateTest_a : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_1sumAHighB_uid48_vecRotateTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_1sumAHighB_uid48_vecRotateTest_o : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_1sumAHighB_uid48_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_1sumAHighB_uid48_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_uid51_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid51_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid52_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid54_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_1_uid57_vecRotateTest_q : STD_LOGIC_VECTOR (26 downto 0);
    signal xip1E_2NA_uid60_vecRotateTest_q : STD_LOGIC_VECTOR (18 downto 0);
    signal xip1E_2sumAHighB_uid61_vecRotateTest_a : STD_LOGIC_VECTOR (20 downto 0);
    signal xip1E_2sumAHighB_uid61_vecRotateTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal xip1E_2sumAHighB_uid61_vecRotateTest_o : STD_LOGIC_VECTOR (20 downto 0);
    signal xip1E_2sumAHighB_uid61_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_2sumAHighB_uid61_vecRotateTest_q : STD_LOGIC_VECTOR (19 downto 0);
    signal yip1E_2NA_uid63_vecRotateTest_q : STD_LOGIC_VECTOR (18 downto 0);
    signal yip1E_2sumAHighB_uid64_vecRotateTest_a : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1E_2sumAHighB_uid64_vecRotateTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1E_2sumAHighB_uid64_vecRotateTest_o : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1E_2sumAHighB_uid64_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_2sumAHighB_uid64_vecRotateTest_q : STD_LOGIC_VECTOR (19 downto 0);
    signal aip1E_2_uid66_vecRotateTest_a : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_2_uid66_vecRotateTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_2_uid66_vecRotateTest_o : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_2_uid66_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_2_uid66_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_2_uid67_vecRotateTest_in : STD_LOGIC_VECTOR (18 downto 0);
    signal xip1_2_uid67_vecRotateTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal yip1_2_uid68_vecRotateTest_in : STD_LOGIC_VECTOR (18 downto 0);
    signal yip1_2_uid68_vecRotateTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal aip1E_uid69_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid69_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid70_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid72_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_2_uid75_vecRotateTest_q : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_3CostZeroPaddingA_uid77_vecRotateTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal xip1E_3NA_uid78_vecRotateTest_q : STD_LOGIC_VECTOR (20 downto 0);
    signal xip1E_3sumAHighB_uid79_vecRotateTest_a : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1E_3sumAHighB_uid79_vecRotateTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1E_3sumAHighB_uid79_vecRotateTest_o : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1E_3sumAHighB_uid79_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_3sumAHighB_uid79_vecRotateTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal yip1E_3NA_uid81_vecRotateTest_q : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1E_3sumAHighB_uid82_vecRotateTest_a : STD_LOGIC_VECTOR (22 downto 0);
    signal yip1E_3sumAHighB_uid82_vecRotateTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal yip1E_3sumAHighB_uid82_vecRotateTest_o : STD_LOGIC_VECTOR (22 downto 0);
    signal yip1E_3sumAHighB_uid82_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_3sumAHighB_uid82_vecRotateTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal aip1E_3_uid84_vecRotateTest_a : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_3_uid84_vecRotateTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_3_uid84_vecRotateTest_o : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_3_uid84_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_3_uid84_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_3_uid85_vecRotateTest_in : STD_LOGIC_VECTOR (20 downto 0);
    signal xip1_3_uid85_vecRotateTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1_3_uid86_vecRotateTest_in : STD_LOGIC_VECTOR (20 downto 0);
    signal yip1_3_uid86_vecRotateTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal aip1E_uid87_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid87_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid88_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid90_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_3_uid93_vecRotateTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal xip1E_4CostZeroPaddingA_uid95_vecRotateTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal xip1E_4NA_uid96_vecRotateTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal xip1E_4sumAHighB_uid97_vecRotateTest_a : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_4sumAHighB_uid97_vecRotateTest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_4sumAHighB_uid97_vecRotateTest_o : STD_LOGIC_VECTOR (25 downto 0);
    signal xip1E_4sumAHighB_uid97_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_4sumAHighB_uid97_vecRotateTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal yip1E_4NA_uid99_vecRotateTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal yip1E_4sumAHighB_uid100_vecRotateTest_a : STD_LOGIC_VECTOR (25 downto 0);
    signal yip1E_4sumAHighB_uid100_vecRotateTest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal yip1E_4sumAHighB_uid100_vecRotateTest_o : STD_LOGIC_VECTOR (25 downto 0);
    signal yip1E_4sumAHighB_uid100_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_4sumAHighB_uid100_vecRotateTest_q : STD_LOGIC_VECTOR (24 downto 0);
    signal aip1E_4_uid102_vecRotateTest_a : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_4_uid102_vecRotateTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_4_uid102_vecRotateTest_o : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_4_uid102_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_4_uid102_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_4_uid103_vecRotateTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal xip1_4_uid103_vecRotateTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal yip1_4_uid104_vecRotateTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal yip1_4_uid104_vecRotateTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal aip1E_uid105_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid105_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid106_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid108_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_4_uid111_vecRotateTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal xip1E_5NA_uid114_vecRotateTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal xip1E_5sumAHighB_uid115_vecRotateTest_a : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1E_5sumAHighB_uid115_vecRotateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1E_5sumAHighB_uid115_vecRotateTest_o : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1E_5sumAHighB_uid115_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_5sumAHighB_uid115_vecRotateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal yip1E_5NA_uid117_vecRotateTest_q : STD_LOGIC_VECTOR (27 downto 0);
    signal yip1E_5sumAHighB_uid118_vecRotateTest_a : STD_LOGIC_VECTOR (29 downto 0);
    signal yip1E_5sumAHighB_uid118_vecRotateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal yip1E_5sumAHighB_uid118_vecRotateTest_o : STD_LOGIC_VECTOR (29 downto 0);
    signal yip1E_5sumAHighB_uid118_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_5sumAHighB_uid118_vecRotateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_5_uid120_vecRotateTest_a : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_5_uid120_vecRotateTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_5_uid120_vecRotateTest_o : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_5_uid120_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_5_uid120_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_5_uid121_vecRotateTest_in : STD_LOGIC_VECTOR (27 downto 0);
    signal xip1_5_uid121_vecRotateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal yip1_5_uid122_vecRotateTest_in : STD_LOGIC_VECTOR (27 downto 0);
    signal yip1_5_uid122_vecRotateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal aip1E_uid123_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid123_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid124_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid126_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstArcTan2Mi_5_uid129_vecRotateTest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal xip1E_6CostZeroPaddingA_uid131_vecRotateTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal xip1E_6NA_uid132_vecRotateTest_q : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1E_6sumAHighB_uid133_vecRotateTest_a : STD_LOGIC_VECTOR (34 downto 0);
    signal xip1E_6sumAHighB_uid133_vecRotateTest_b : STD_LOGIC_VECTOR (34 downto 0);
    signal xip1E_6sumAHighB_uid133_vecRotateTest_o : STD_LOGIC_VECTOR (34 downto 0);
    signal xip1E_6sumAHighB_uid133_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_6sumAHighB_uid133_vecRotateTest_q : STD_LOGIC_VECTOR (33 downto 0);
    signal yip1E_6NA_uid135_vecRotateTest_q : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1E_6sumAHighB_uid136_vecRotateTest_a : STD_LOGIC_VECTOR (34 downto 0);
    signal yip1E_6sumAHighB_uid136_vecRotateTest_b : STD_LOGIC_VECTOR (34 downto 0);
    signal yip1E_6sumAHighB_uid136_vecRotateTest_o : STD_LOGIC_VECTOR (34 downto 0);
    signal yip1E_6sumAHighB_uid136_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_6sumAHighB_uid136_vecRotateTest_q : STD_LOGIC_VECTOR (33 downto 0);
    signal aip1E_6_uid138_vecRotateTest_a : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_6_uid138_vecRotateTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_6_uid138_vecRotateTest_o : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_6_uid138_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_6_uid138_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_6_uid139_vecRotateTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal xip1_6_uid139_vecRotateTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1_6_uid140_vecRotateTest_in : STD_LOGIC_VECTOR (32 downto 0);
    signal yip1_6_uid140_vecRotateTest_b : STD_LOGIC_VECTOR (32 downto 0);
    signal aip1E_uid141_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid141_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid142_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid144_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid147_vecRotateTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal twoToMiSiYip_uid148_vecRotateTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal cstArcTan2Mi_6_uid149_vecRotateTest_q : STD_LOGIC_VECTOR (21 downto 0);
    signal xip1E_7NA_uid152_vecRotateTest_q : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1E_7sumAHighB_uid153_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_7sumAHighB_uid153_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_7sumAHighB_uid153_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_7sumAHighB_uid153_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_7sumAHighB_uid153_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_7NA_uid155_vecRotateTest_q : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1E_7sumAHighB_uid156_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_7sumAHighB_uid156_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_7sumAHighB_uid156_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_7sumAHighB_uid156_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_7sumAHighB_uid156_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal aip1E_7_uid158_vecRotateTest_a : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_7_uid158_vecRotateTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_7_uid158_vecRotateTest_o : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_7_uid158_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_7_uid158_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_7_uid159_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_7_uid159_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_7_uid160_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_7_uid160_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid161_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid161_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid162_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid164_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid167_vecRotateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal twoToMiSiYip_uid168_vecRotateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal cstArcTan2Mi_7_uid169_vecRotateTest_q : STD_LOGIC_VECTOR (20 downto 0);
    signal xip1E_8_uid171_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_8_uid171_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_8_uid171_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_8_uid171_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_8_uid171_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_8_uid172_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_8_uid172_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_8_uid172_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_8_uid172_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_8_uid172_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal aip1E_8_uid174_vecRotateTest_a : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_8_uid174_vecRotateTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_8_uid174_vecRotateTest_o : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_8_uid174_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_8_uid174_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_8_uid175_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_8_uid175_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_8_uid176_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_8_uid176_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid177_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid177_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid178_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid180_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid183_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal twoToMiSiYip_uid184_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal cstArcTan2Mi_8_uid185_vecRotateTest_q : STD_LOGIC_VECTOR (19 downto 0);
    signal xip1E_9_uid187_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_9_uid187_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_9_uid187_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_9_uid187_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_9_uid187_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_9_uid188_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_9_uid188_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_9_uid188_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_9_uid188_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_9_uid188_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal aip1E_9_uid190_vecRotateTest_a : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_9_uid190_vecRotateTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_9_uid190_vecRotateTest_o : STD_LOGIC_VECTOR (30 downto 0);
    signal aip1E_9_uid190_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_9_uid190_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_9_uid191_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_9_uid191_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_9_uid192_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_9_uid192_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid193_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid193_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid194_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid196_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid199_vecRotateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal twoToMiSiYip_uid200_vecRotateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal cstArcTan2Mi_9_uid201_vecRotateTest_q : STD_LOGIC_VECTOR (18 downto 0);
    signal xip1E_10_uid203_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_10_uid203_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_10_uid203_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_10_uid203_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_10_uid203_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_10_uid204_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_10_uid204_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_10_uid204_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_10_uid204_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_10_uid204_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal lowRangeA_uid206_vecRotateTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid206_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid207_vecRotateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal aip1E_10high_uid208_vecRotateTest_a : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_10high_uid208_vecRotateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_10high_uid208_vecRotateTest_o : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_10high_uid208_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_10high_uid208_vecRotateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_10_uid209_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_10_uid210_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_10_uid210_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_10_uid211_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_10_uid211_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid212_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid212_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid213_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid215_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid218_vecRotateTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal twoToMiSiYip_uid219_vecRotateTest_b : STD_LOGIC_VECTOR (26 downto 0);
    signal cstArcTan2Mi_10_uid220_vecRotateTest_q : STD_LOGIC_VECTOR (17 downto 0);
    signal xip1E_11_uid222_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_11_uid222_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_11_uid222_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_11_uid222_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_11_uid222_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_11_uid223_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_11_uid223_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_11_uid223_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_11_uid223_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_11_uid223_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal lowRangeA_uid225_vecRotateTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid225_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid226_vecRotateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal aip1E_11high_uid227_vecRotateTest_a : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_11high_uid227_vecRotateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_11high_uid227_vecRotateTest_o : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_11high_uid227_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_11high_uid227_vecRotateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_11_uid228_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_11_uid229_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_11_uid229_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_11_uid230_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_11_uid230_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid231_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid231_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid232_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid234_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid237_vecRotateTest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal twoToMiSiYip_uid238_vecRotateTest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal cstArcTan2Mi_11_uid239_vecRotateTest_q : STD_LOGIC_VECTOR (16 downto 0);
    signal xip1E_12_uid241_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_12_uid241_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_12_uid241_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_12_uid241_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_12_uid241_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_12_uid242_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_12_uid242_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_12_uid242_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_12_uid242_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_12_uid242_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal lowRangeA_uid244_vecRotateTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid244_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid245_vecRotateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal aip1E_12high_uid246_vecRotateTest_a : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_12high_uid246_vecRotateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_12high_uid246_vecRotateTest_o : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_12high_uid246_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_12high_uid246_vecRotateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_12_uid247_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_12_uid248_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_12_uid248_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_12_uid249_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_12_uid249_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid250_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid250_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid251_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid253_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid256_vecRotateTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal twoToMiSiYip_uid257_vecRotateTest_b : STD_LOGIC_VECTOR (24 downto 0);
    signal cstArcTan2Mi_12_uid258_vecRotateTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal xip1E_13_uid260_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_13_uid260_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_13_uid260_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_13_uid260_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_13_uid260_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_13_uid261_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_13_uid261_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_13_uid261_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_13_uid261_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_13_uid261_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal lowRangeA_uid263_vecRotateTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid263_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid264_vecRotateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal aip1E_13high_uid265_vecRotateTest_a : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_13high_uid265_vecRotateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_13high_uid265_vecRotateTest_o : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_13high_uid265_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_13high_uid265_vecRotateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_13_uid266_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_13_uid267_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_13_uid267_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_13_uid268_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_13_uid268_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid269_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid269_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid270_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid272_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid275_vecRotateTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal twoToMiSiYip_uid276_vecRotateTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal cstArcTan2Mi_13_uid277_vecRotateTest_q : STD_LOGIC_VECTOR (14 downto 0);
    signal xip1E_14_uid279_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_14_uid279_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_14_uid279_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_14_uid279_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_14_uid279_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_14_uid280_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_14_uid280_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_14_uid280_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_14_uid280_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_14_uid280_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal lowRangeA_uid282_vecRotateTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid282_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid283_vecRotateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal aip1E_14high_uid284_vecRotateTest_a : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_14high_uid284_vecRotateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_14high_uid284_vecRotateTest_o : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_14high_uid284_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_14high_uid284_vecRotateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_14_uid285_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_14_uid286_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_14_uid286_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_14_uid287_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_14_uid287_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid288_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid288_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid289_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid291_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid294_vecRotateTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal twoToMiSiYip_uid295_vecRotateTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal cstArcTan2Mi_14_uid296_vecRotateTest_q : STD_LOGIC_VECTOR (13 downto 0);
    signal xip1E_15_uid298_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_15_uid298_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_15_uid298_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_15_uid298_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_15_uid298_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_15_uid299_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_15_uid299_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_15_uid299_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_15_uid299_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_15_uid299_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal lowRangeA_uid301_vecRotateTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid301_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid302_vecRotateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal aip1E_15high_uid303_vecRotateTest_a : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_15high_uid303_vecRotateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_15high_uid303_vecRotateTest_o : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_15high_uid303_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_15high_uid303_vecRotateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_15_uid304_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_15_uid305_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_15_uid305_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_15_uid306_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_15_uid306_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid307_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid307_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid308_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid310_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid313_vecRotateTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal twoToMiSiYip_uid314_vecRotateTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal cstArcTan2Mi_15_uid315_vecRotateTest_q : STD_LOGIC_VECTOR (12 downto 0);
    signal xip1E_16_uid317_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_16_uid317_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_16_uid317_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_16_uid317_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_16_uid317_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_16_uid318_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_16_uid318_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_16_uid318_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_16_uid318_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_16_uid318_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal lowRangeA_uid320_vecRotateTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid320_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid321_vecRotateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal aip1E_16high_uid322_vecRotateTest_a : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_16high_uid322_vecRotateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_16high_uid322_vecRotateTest_o : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_16high_uid322_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_16high_uid322_vecRotateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_16_uid323_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_16_uid324_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_16_uid324_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_16_uid325_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_16_uid325_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid326_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid326_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid327_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid329_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid332_vecRotateTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal twoToMiSiYip_uid333_vecRotateTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal cstArcTan2Mi_16_uid334_vecRotateTest_q : STD_LOGIC_VECTOR (11 downto 0);
    signal xip1E_17_uid336_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_17_uid336_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_17_uid336_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_17_uid336_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_17_uid336_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_17_uid337_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_17_uid337_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_17_uid337_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_17_uid337_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_17_uid337_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal lowRangeA_uid339_vecRotateTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid339_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid340_vecRotateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal aip1E_17high_uid341_vecRotateTest_a : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_17high_uid341_vecRotateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_17high_uid341_vecRotateTest_o : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_17high_uid341_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_17high_uid341_vecRotateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_17_uid342_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_17_uid343_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_17_uid343_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_17_uid344_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_17_uid344_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid345_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid345_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid346_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid348_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid351_vecRotateTest_b : STD_LOGIC_VECTOR (19 downto 0);
    signal twoToMiSiYip_uid352_vecRotateTest_b : STD_LOGIC_VECTOR (19 downto 0);
    signal cstArcTan2Mi_17_uid353_vecRotateTest_q : STD_LOGIC_VECTOR (10 downto 0);
    signal xip1E_18_uid355_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_18_uid355_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_18_uid355_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_18_uid355_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_18_uid355_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_18_uid356_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_18_uid356_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_18_uid356_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_18_uid356_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_18_uid356_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal lowRangeA_uid358_vecRotateTest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeA_uid358_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highABits_uid359_vecRotateTest_b : STD_LOGIC_VECTOR (27 downto 0);
    signal aip1E_18high_uid360_vecRotateTest_a : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_18high_uid360_vecRotateTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_18high_uid360_vecRotateTest_o : STD_LOGIC_VECTOR (29 downto 0);
    signal aip1E_18high_uid360_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aip1E_18high_uid360_vecRotateTest_q : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_18_uid361_vecRotateTest_q : STD_LOGIC_VECTOR (29 downto 0);
    signal xip1_18_uid362_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_18_uid362_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_18_uid363_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_18_uid363_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal aip1E_uid364_vecRotateTest_in : STD_LOGIC_VECTOR (28 downto 0);
    signal aip1E_uid364_vecRotateTest_b : STD_LOGIC_VECTOR (28 downto 0);
    signal xMSB_uid365_vecRotateTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signOfSelectionSignal_uid367_vecRotateTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal twoToMiSiXip_uid370_vecRotateTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal twoToMiSiYip_uid371_vecRotateTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal xip1E_19_uid374_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_19_uid374_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_19_uid374_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal xip1E_19_uid374_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xip1E_19_uid374_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal yip1E_19_uid375_vecRotateTest_a : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_19_uid375_vecRotateTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_19_uid375_vecRotateTest_o : STD_LOGIC_VECTOR (38 downto 0);
    signal yip1E_19_uid375_vecRotateTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal yip1E_19_uid375_vecRotateTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal xip1_19_uid381_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal xip1_19_uid381_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_19_uid382_vecRotateTest_in : STD_LOGIC_VECTOR (36 downto 0);
    signal yip1_19_uid382_vecRotateTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal xSumPreRnd_uid384_vecRotateTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal xSumPostRnd_uid387_vecRotateTest_a : STD_LOGIC_VECTOR (19 downto 0);
    signal xSumPostRnd_uid387_vecRotateTest_b : STD_LOGIC_VECTOR (19 downto 0);
    signal xSumPostRnd_uid387_vecRotateTest_o : STD_LOGIC_VECTOR (19 downto 0);
    signal xSumPostRnd_uid387_vecRotateTest_q : STD_LOGIC_VECTOR (19 downto 0);
    signal ySumPreRnd_uid388_vecRotateTest_b : STD_LOGIC_VECTOR (18 downto 0);
    signal ySumPostRnd_uid391_vecRotateTest_a : STD_LOGIC_VECTOR (19 downto 0);
    signal ySumPostRnd_uid391_vecRotateTest_b : STD_LOGIC_VECTOR (19 downto 0);
    signal ySumPostRnd_uid391_vecRotateTest_o : STD_LOGIC_VECTOR (19 downto 0);
    signal ySumPostRnd_uid391_vecRotateTest_q : STD_LOGIC_VECTOR (19 downto 0);
    signal xPostExc_uid392_vecRotateTest_in : STD_LOGIC_VECTOR (18 downto 0);
    signal xPostExc_uid392_vecRotateTest_b : STD_LOGIC_VECTOR (17 downto 0);
    signal yPostExc_uid393_vecRotateTest_in : STD_LOGIC_VECTOR (18 downto 0);
    signal yPostExc_uid393_vecRotateTest_b : STD_LOGIC_VECTOR (17 downto 0);
    signal signA_uid7_vecRotateTest_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signA_uid7_vecRotateTest_merged_bit_select_c : STD_LOGIC_VECTOR (16 downto 0);
    signal msbUAbsAE_uid12_vecRotateTest_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal msbUAbsAE_uid12_vecRotateTest_merged_bit_select_c : STD_LOGIC_VECTOR (24 downto 0);
    signal redist0_msbUAbsAE_uid12_vecRotateTest_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_msbUAbsAE_uid12_vecRotateTest_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (24 downto 0);
    signal redist2_signA_uid7_vecRotateTest_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_signA_uid7_vecRotateTest_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (16 downto 0);
    signal redist4_ySumPreRnd_uid388_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist5_xSumPreRnd_uid384_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist6_xMSB_uid365_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_yip1_18_uid363_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist8_xip1_18_uid362_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist9_aip1E_uid345_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist10_yip1_17_uid344_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist11_xip1_17_uid343_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist12_aip1E_uid326_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist13_yip1_16_uid325_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist14_xip1_16_uid324_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist15_aip1E_uid307_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist16_yip1_15_uid306_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist17_xip1_15_uid305_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist18_aip1E_uid288_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist19_yip1_14_uid287_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist20_xip1_14_uid286_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist21_aip1E_uid269_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist22_yip1_13_uid268_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist23_xip1_13_uid267_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist24_aip1E_uid250_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist25_yip1_12_uid249_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist26_xip1_12_uid248_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist27_aip1E_uid231_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist28_yip1_11_uid230_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist29_xip1_11_uid229_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist30_aip1E_uid212_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist31_yip1_10_uid211_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist32_xip1_10_uid210_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist33_aip1E_uid193_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist34_yip1_9_uid192_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist35_xip1_9_uid191_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist36_aip1E_uid177_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist37_yip1_8_uid176_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist38_xip1_8_uid175_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist39_aip1E_uid161_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist40_yip1_7_uid160_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist41_xip1_7_uid159_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (36 downto 0);
    signal redist42_aip1E_uid141_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist43_yip1_6_uid140_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist44_xip1_6_uid139_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist45_aip1E_uid123_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist46_yip1_5_uid122_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist47_xip1_5_uid121_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist48_aip1E_uid105_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist49_yip1_4_uid104_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist50_xip1_4_uid103_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist51_aip1E_uid87_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist52_yip1_3_uid86_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (20 downto 0);
    signal redist53_xip1_3_uid85_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (20 downto 0);
    signal redist54_aip1E_uid69_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist55_yip1_2_uid68_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist56_xip1_2_uid67_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist57_aip1E_uid51_vecRotateTest_b_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal redist58_xIn_x_1_q : STD_LOGIC_VECTOR (16 downto 0);
    signal redist59_xIn_y_1_q : STD_LOGIC_VECTOR (16 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- xMSB_uid178_vecRotateTest(BITSELECT,177)@10
    xMSB_uid178_vecRotateTest_b <= STD_LOGIC_VECTOR(redist36_aip1E_uid177_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_8_uid185_vecRotateTest(CONSTANT,184)
    cstArcTan2Mi_8_uid185_vecRotateTest_q <= "01111111111111111101";

    -- xMSB_uid162_vecRotateTest(BITSELECT,161)@9
    xMSB_uid162_vecRotateTest_b <= STD_LOGIC_VECTOR(redist39_aip1E_uid161_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_7_uid169_vecRotateTest(CONSTANT,168)
    cstArcTan2Mi_7_uid169_vecRotateTest_q <= "011111111111111101011";

    -- xMSB_uid142_vecRotateTest(BITSELECT,141)@8
    xMSB_uid142_vecRotateTest_b <= STD_LOGIC_VECTOR(redist42_aip1E_uid141_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_6_uid149_vecRotateTest(CONSTANT,148)
    cstArcTan2Mi_6_uid149_vecRotateTest_q <= "0111111111111101010101";

    -- xMSB_uid124_vecRotateTest(BITSELECT,123)@7
    xMSB_uid124_vecRotateTest_b <= STD_LOGIC_VECTOR(redist45_aip1E_uid123_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_5_uid129_vecRotateTest(CONSTANT,128)
    cstArcTan2Mi_5_uid129_vecRotateTest_q <= "01111111111101010101011";

    -- xMSB_uid106_vecRotateTest(BITSELECT,105)@6
    xMSB_uid106_vecRotateTest_b <= STD_LOGIC_VECTOR(redist48_aip1E_uid105_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_4_uid111_vecRotateTest(CONSTANT,110)
    cstArcTan2Mi_4_uid111_vecRotateTest_q <= "011111111101010101101111";

    -- xMSB_uid88_vecRotateTest(BITSELECT,87)@5
    xMSB_uid88_vecRotateTest_b <= STD_LOGIC_VECTOR(redist51_aip1E_uid87_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_3_uid93_vecRotateTest(CONSTANT,92)
    cstArcTan2Mi_3_uid93_vecRotateTest_q <= "0111111101010110111010101";

    -- xMSB_uid70_vecRotateTest(BITSELECT,69)@4
    xMSB_uid70_vecRotateTest_b <= STD_LOGIC_VECTOR(redist54_aip1E_uid69_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_2_uid75_vecRotateTest(CONSTANT,74)
    cstArcTan2Mi_2_uid75_vecRotateTest_q <= "01111101011011011101100000";

    -- xMSB_uid52_vecRotateTest(BITSELECT,51)@3
    xMSB_uid52_vecRotateTest_b <= STD_LOGIC_VECTOR(redist57_aip1E_uid51_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_1_uid57_vecRotateTest(CONSTANT,56)
    cstArcTan2Mi_1_uid57_vecRotateTest_q <= "011101101011000110011100001";

    -- signA_uid7_vecRotateTest_merged_bit_select(BITSELECT,395)@0
    signA_uid7_vecRotateTest_merged_bit_select_b <= STD_LOGIC_VECTOR(a(17 downto 17));
    signA_uid7_vecRotateTest_merged_bit_select_c <= STD_LOGIC_VECTOR(a(16 downto 0));

    -- redist3_signA_uid7_vecRotateTest_merged_bit_select_c_1(DELAY,400)
    redist3_signA_uid7_vecRotateTest_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 17, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signA_uid7_vecRotateTest_merged_bit_select_c, xout => redist3_signA_uid7_vecRotateTest_merged_bit_select_c_1_q, clk => clk, aclr => areset );

    -- absAECostZeroPaddingA_uid9_vecRotateTest(CONSTANT,8)
    absAECostZeroPaddingA_uid9_vecRotateTest_q <= "00000000";

    -- aInFirstQuadrant_mergedSignalTM_uid20_vecRotateTest(BITJOIN,19)@1
    aInFirstQuadrant_mergedSignalTM_uid20_vecRotateTest_q <= redist3_signA_uid7_vecRotateTest_merged_bit_select_c_1_q & absAECostZeroPaddingA_uid9_vecRotateTest_q;

    -- cstPiO2_uid8_vecRotateTest(CONSTANT,7)
    cstPiO2_uid8_vecRotateTest_q <= "110010010000111111011011";

    -- absAENA_uid10_vecRotateTest(BITJOIN,9)@0
    absAENA_uid10_vecRotateTest_q <= a & absAECostZeroPaddingA_uid9_vecRotateTest_q;

    -- absAEsumAHighB_uid11_vecRotateTest(ADDSUB,10)@0
    absAEsumAHighB_uid11_vecRotateTest_s <= signA_uid7_vecRotateTest_merged_bit_select_b;
    absAEsumAHighB_uid11_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 26 => absAENA_uid10_vecRotateTest_q(25)) & absAENA_uid10_vecRotateTest_q));
    absAEsumAHighB_uid11_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & cstPiO2_uid8_vecRotateTest_q));
    absAEsumAHighB_uid11_vecRotateTest_combproc: PROCESS (absAEsumAHighB_uid11_vecRotateTest_a, absAEsumAHighB_uid11_vecRotateTest_b, absAEsumAHighB_uid11_vecRotateTest_s)
    BEGIN
        IF (absAEsumAHighB_uid11_vecRotateTest_s = "1") THEN
            absAEsumAHighB_uid11_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(absAEsumAHighB_uid11_vecRotateTest_a) + SIGNED(absAEsumAHighB_uid11_vecRotateTest_b));
        ELSE
            absAEsumAHighB_uid11_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(absAEsumAHighB_uid11_vecRotateTest_a) - SIGNED(absAEsumAHighB_uid11_vecRotateTest_b));
        END IF;
    END PROCESS;
    absAEsumAHighB_uid11_vecRotateTest_q <= absAEsumAHighB_uid11_vecRotateTest_o(26 downto 0);

    -- msbUAbsAE_uid12_vecRotateTest_merged_bit_select(BITSELECT,396)@0
    msbUAbsAE_uid12_vecRotateTest_merged_bit_select_b <= STD_LOGIC_VECTOR(absAEsumAHighB_uid11_vecRotateTest_q(26 downto 26));
    msbUAbsAE_uid12_vecRotateTest_merged_bit_select_c <= STD_LOGIC_VECTOR(absAEsumAHighB_uid11_vecRotateTest_q(24 downto 0));

    -- redist1_msbUAbsAE_uid12_vecRotateTest_merged_bit_select_c_1(DELAY,398)
    redist1_msbUAbsAE_uid12_vecRotateTest_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 25, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => msbUAbsAE_uid12_vecRotateTest_merged_bit_select_c, xout => redist1_msbUAbsAE_uid12_vecRotateTest_merged_bit_select_c_1_q, clk => clk, aclr => areset );

    -- redist0_msbUAbsAE_uid12_vecRotateTest_merged_bit_select_b_1(DELAY,397)
    redist0_msbUAbsAE_uid12_vecRotateTest_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => msbUAbsAE_uid12_vecRotateTest_merged_bit_select_b, xout => redist0_msbUAbsAE_uid12_vecRotateTest_merged_bit_select_b_1_q, clk => clk, aclr => areset );

    -- invMsbuAbsAE_uid13_vecRotateTest(LOGICAL,12)@1
    invMsbuAbsAE_uid13_vecRotateTest_q <= not (redist0_msbUAbsAE_uid12_vecRotateTest_merged_bit_select_b_1_q);

    -- redist2_signA_uid7_vecRotateTest_merged_bit_select_b_1(DELAY,399)
    redist2_signA_uid7_vecRotateTest_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signA_uid7_vecRotateTest_merged_bit_select_b, xout => redist2_signA_uid7_vecRotateTest_merged_bit_select_b_1_q, clk => clk, aclr => areset );

    -- firstQuadrantCond1_uid14_vecRotateTest(LOGICAL,13)@1
    firstQuadrantCond1_uid14_vecRotateTest_q <= redist2_signA_uid7_vecRotateTest_merged_bit_select_b_1_q and invMsbuAbsAE_uid13_vecRotateTest_q;

    -- invSignA_uid15_vecRotateTest(LOGICAL,14)@1
    invSignA_uid15_vecRotateTest_q <= not (redist2_signA_uid7_vecRotateTest_merged_bit_select_b_1_q);

    -- firstQuadrantCond0_uid16_vecRotateTest(LOGICAL,15)@1
    firstQuadrantCond0_uid16_vecRotateTest_q <= invSignA_uid15_vecRotateTest_q and redist0_msbUAbsAE_uid12_vecRotateTest_merged_bit_select_b_1_q;

    -- firstQuadrant_uid17_vecRotateTest(LOGICAL,16)@1
    firstQuadrant_uid17_vecRotateTest_q <= firstQuadrantCond0_uid16_vecRotateTest_q or firstQuadrantCond1_uid14_vecRotateTest_q;

    -- absA_uid23_vecRotateTest(MUX,22)@1 + 1
    absA_uid23_vecRotateTest_s <= firstQuadrant_uid17_vecRotateTest_q;
    absA_uid23_vecRotateTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            absA_uid23_vecRotateTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (absA_uid23_vecRotateTest_s) IS
                WHEN "0" => absA_uid23_vecRotateTest_q <= redist1_msbUAbsAE_uid12_vecRotateTest_merged_bit_select_c_1_q;
                WHEN "1" => absA_uid23_vecRotateTest_q <= aInFirstQuadrant_mergedSignalTM_uid20_vecRotateTest_q;
                WHEN OTHERS => absA_uid23_vecRotateTest_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- xMSB_uid36_vecRotateTest(BITSELECT,35)@2
    xMSB_uid36_vecRotateTest_b <= STD_LOGIC_VECTOR(absA_uid23_vecRotateTest_q(24 downto 24));

    -- cstArcTan2Mi_0_uid41_vecRotateTest(CONSTANT,40)
    cstArcTan2Mi_0_uid41_vecRotateTest_q <= "0110010010000111111011010101";

    -- aip1E_1CostZeroPaddingA_uid46_vecRotateTest(CONSTANT,45)
    aip1E_1CostZeroPaddingA_uid46_vecRotateTest_q <= "0000";

    -- aip1E_1NA_uid47_vecRotateTest(BITJOIN,46)@2
    aip1E_1NA_uid47_vecRotateTest_q <= absA_uid23_vecRotateTest_q & aip1E_1CostZeroPaddingA_uid46_vecRotateTest_q;

    -- aip1E_1sumAHighB_uid48_vecRotateTest(ADDSUB,47)@2
    aip1E_1sumAHighB_uid48_vecRotateTest_s <= xMSB_uid36_vecRotateTest_b;
    aip1E_1sumAHighB_uid48_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 29 => aip1E_1NA_uid47_vecRotateTest_q(28)) & aip1E_1NA_uid47_vecRotateTest_q));
    aip1E_1sumAHighB_uid48_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 28 => cstArcTan2Mi_0_uid41_vecRotateTest_q(27)) & cstArcTan2Mi_0_uid41_vecRotateTest_q));
    aip1E_1sumAHighB_uid48_vecRotateTest_combproc: PROCESS (aip1E_1sumAHighB_uid48_vecRotateTest_a, aip1E_1sumAHighB_uid48_vecRotateTest_b, aip1E_1sumAHighB_uid48_vecRotateTest_s)
    BEGIN
        IF (aip1E_1sumAHighB_uid48_vecRotateTest_s = "1") THEN
            aip1E_1sumAHighB_uid48_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_1sumAHighB_uid48_vecRotateTest_a) + SIGNED(aip1E_1sumAHighB_uid48_vecRotateTest_b));
        ELSE
            aip1E_1sumAHighB_uid48_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_1sumAHighB_uid48_vecRotateTest_a) - SIGNED(aip1E_1sumAHighB_uid48_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_1sumAHighB_uid48_vecRotateTest_q <= aip1E_1sumAHighB_uid48_vecRotateTest_o(29 downto 0);

    -- aip1E_uid51_vecRotateTest(BITSELECT,50)@2
    aip1E_uid51_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_1sumAHighB_uid48_vecRotateTest_q(28 downto 0));
    aip1E_uid51_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid51_vecRotateTest_in(28 downto 0));

    -- redist57_aip1E_uid51_vecRotateTest_b_1(DELAY,454)
    redist57_aip1E_uid51_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid51_vecRotateTest_b, xout => redist57_aip1E_uid51_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- aip1E_2_uid66_vecRotateTest(ADDSUB,65)@3
    aip1E_2_uid66_vecRotateTest_s <= xMSB_uid52_vecRotateTest_b;
    aip1E_2_uid66_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 29 => redist57_aip1E_uid51_vecRotateTest_b_1_q(28)) & redist57_aip1E_uid51_vecRotateTest_b_1_q));
    aip1E_2_uid66_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 27 => cstArcTan2Mi_1_uid57_vecRotateTest_q(26)) & cstArcTan2Mi_1_uid57_vecRotateTest_q));
    aip1E_2_uid66_vecRotateTest_combproc: PROCESS (aip1E_2_uid66_vecRotateTest_a, aip1E_2_uid66_vecRotateTest_b, aip1E_2_uid66_vecRotateTest_s)
    BEGIN
        IF (aip1E_2_uid66_vecRotateTest_s = "1") THEN
            aip1E_2_uid66_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_2_uid66_vecRotateTest_a) + SIGNED(aip1E_2_uid66_vecRotateTest_b));
        ELSE
            aip1E_2_uid66_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_2_uid66_vecRotateTest_a) - SIGNED(aip1E_2_uid66_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_2_uid66_vecRotateTest_q <= aip1E_2_uid66_vecRotateTest_o(29 downto 0);

    -- aip1E_uid69_vecRotateTest(BITSELECT,68)@3
    aip1E_uid69_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_2_uid66_vecRotateTest_q(28 downto 0));
    aip1E_uid69_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid69_vecRotateTest_in(28 downto 0));

    -- redist54_aip1E_uid69_vecRotateTest_b_1(DELAY,451)
    redist54_aip1E_uid69_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid69_vecRotateTest_b, xout => redist54_aip1E_uid69_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- aip1E_3_uid84_vecRotateTest(ADDSUB,83)@4
    aip1E_3_uid84_vecRotateTest_s <= xMSB_uid70_vecRotateTest_b;
    aip1E_3_uid84_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 29 => redist54_aip1E_uid69_vecRotateTest_b_1_q(28)) & redist54_aip1E_uid69_vecRotateTest_b_1_q));
    aip1E_3_uid84_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 26 => cstArcTan2Mi_2_uid75_vecRotateTest_q(25)) & cstArcTan2Mi_2_uid75_vecRotateTest_q));
    aip1E_3_uid84_vecRotateTest_combproc: PROCESS (aip1E_3_uid84_vecRotateTest_a, aip1E_3_uid84_vecRotateTest_b, aip1E_3_uid84_vecRotateTest_s)
    BEGIN
        IF (aip1E_3_uid84_vecRotateTest_s = "1") THEN
            aip1E_3_uid84_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_3_uid84_vecRotateTest_a) + SIGNED(aip1E_3_uid84_vecRotateTest_b));
        ELSE
            aip1E_3_uid84_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_3_uid84_vecRotateTest_a) - SIGNED(aip1E_3_uid84_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_3_uid84_vecRotateTest_q <= aip1E_3_uid84_vecRotateTest_o(29 downto 0);

    -- aip1E_uid87_vecRotateTest(BITSELECT,86)@4
    aip1E_uid87_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_3_uid84_vecRotateTest_q(28 downto 0));
    aip1E_uid87_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid87_vecRotateTest_in(28 downto 0));

    -- redist51_aip1E_uid87_vecRotateTest_b_1(DELAY,448)
    redist51_aip1E_uid87_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid87_vecRotateTest_b, xout => redist51_aip1E_uid87_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- aip1E_4_uid102_vecRotateTest(ADDSUB,101)@5
    aip1E_4_uid102_vecRotateTest_s <= xMSB_uid88_vecRotateTest_b;
    aip1E_4_uid102_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 29 => redist51_aip1E_uid87_vecRotateTest_b_1_q(28)) & redist51_aip1E_uid87_vecRotateTest_b_1_q));
    aip1E_4_uid102_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 25 => cstArcTan2Mi_3_uid93_vecRotateTest_q(24)) & cstArcTan2Mi_3_uid93_vecRotateTest_q));
    aip1E_4_uid102_vecRotateTest_combproc: PROCESS (aip1E_4_uid102_vecRotateTest_a, aip1E_4_uid102_vecRotateTest_b, aip1E_4_uid102_vecRotateTest_s)
    BEGIN
        IF (aip1E_4_uid102_vecRotateTest_s = "1") THEN
            aip1E_4_uid102_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_4_uid102_vecRotateTest_a) + SIGNED(aip1E_4_uid102_vecRotateTest_b));
        ELSE
            aip1E_4_uid102_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_4_uid102_vecRotateTest_a) - SIGNED(aip1E_4_uid102_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_4_uid102_vecRotateTest_q <= aip1E_4_uid102_vecRotateTest_o(29 downto 0);

    -- aip1E_uid105_vecRotateTest(BITSELECT,104)@5
    aip1E_uid105_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_4_uid102_vecRotateTest_q(28 downto 0));
    aip1E_uid105_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid105_vecRotateTest_in(28 downto 0));

    -- redist48_aip1E_uid105_vecRotateTest_b_1(DELAY,445)
    redist48_aip1E_uid105_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid105_vecRotateTest_b, xout => redist48_aip1E_uid105_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- aip1E_5_uid120_vecRotateTest(ADDSUB,119)@6
    aip1E_5_uid120_vecRotateTest_s <= xMSB_uid106_vecRotateTest_b;
    aip1E_5_uid120_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 29 => redist48_aip1E_uid105_vecRotateTest_b_1_q(28)) & redist48_aip1E_uid105_vecRotateTest_b_1_q));
    aip1E_5_uid120_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 24 => cstArcTan2Mi_4_uid111_vecRotateTest_q(23)) & cstArcTan2Mi_4_uid111_vecRotateTest_q));
    aip1E_5_uid120_vecRotateTest_combproc: PROCESS (aip1E_5_uid120_vecRotateTest_a, aip1E_5_uid120_vecRotateTest_b, aip1E_5_uid120_vecRotateTest_s)
    BEGIN
        IF (aip1E_5_uid120_vecRotateTest_s = "1") THEN
            aip1E_5_uid120_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_5_uid120_vecRotateTest_a) + SIGNED(aip1E_5_uid120_vecRotateTest_b));
        ELSE
            aip1E_5_uid120_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_5_uid120_vecRotateTest_a) - SIGNED(aip1E_5_uid120_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_5_uid120_vecRotateTest_q <= aip1E_5_uid120_vecRotateTest_o(29 downto 0);

    -- aip1E_uid123_vecRotateTest(BITSELECT,122)@6
    aip1E_uid123_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_5_uid120_vecRotateTest_q(28 downto 0));
    aip1E_uid123_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid123_vecRotateTest_in(28 downto 0));

    -- redist45_aip1E_uid123_vecRotateTest_b_1(DELAY,442)
    redist45_aip1E_uid123_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid123_vecRotateTest_b, xout => redist45_aip1E_uid123_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- aip1E_6_uid138_vecRotateTest(ADDSUB,137)@7
    aip1E_6_uid138_vecRotateTest_s <= xMSB_uid124_vecRotateTest_b;
    aip1E_6_uid138_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 29 => redist45_aip1E_uid123_vecRotateTest_b_1_q(28)) & redist45_aip1E_uid123_vecRotateTest_b_1_q));
    aip1E_6_uid138_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 23 => cstArcTan2Mi_5_uid129_vecRotateTest_q(22)) & cstArcTan2Mi_5_uid129_vecRotateTest_q));
    aip1E_6_uid138_vecRotateTest_combproc: PROCESS (aip1E_6_uid138_vecRotateTest_a, aip1E_6_uid138_vecRotateTest_b, aip1E_6_uid138_vecRotateTest_s)
    BEGIN
        IF (aip1E_6_uid138_vecRotateTest_s = "1") THEN
            aip1E_6_uid138_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_6_uid138_vecRotateTest_a) + SIGNED(aip1E_6_uid138_vecRotateTest_b));
        ELSE
            aip1E_6_uid138_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_6_uid138_vecRotateTest_a) - SIGNED(aip1E_6_uid138_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_6_uid138_vecRotateTest_q <= aip1E_6_uid138_vecRotateTest_o(29 downto 0);

    -- aip1E_uid141_vecRotateTest(BITSELECT,140)@7
    aip1E_uid141_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_6_uid138_vecRotateTest_q(28 downto 0));
    aip1E_uid141_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid141_vecRotateTest_in(28 downto 0));

    -- redist42_aip1E_uid141_vecRotateTest_b_1(DELAY,439)
    redist42_aip1E_uid141_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid141_vecRotateTest_b, xout => redist42_aip1E_uid141_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- aip1E_7_uid158_vecRotateTest(ADDSUB,157)@8
    aip1E_7_uid158_vecRotateTest_s <= xMSB_uid142_vecRotateTest_b;
    aip1E_7_uid158_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 29 => redist42_aip1E_uid141_vecRotateTest_b_1_q(28)) & redist42_aip1E_uid141_vecRotateTest_b_1_q));
    aip1E_7_uid158_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 22 => cstArcTan2Mi_6_uid149_vecRotateTest_q(21)) & cstArcTan2Mi_6_uid149_vecRotateTest_q));
    aip1E_7_uid158_vecRotateTest_combproc: PROCESS (aip1E_7_uid158_vecRotateTest_a, aip1E_7_uid158_vecRotateTest_b, aip1E_7_uid158_vecRotateTest_s)
    BEGIN
        IF (aip1E_7_uid158_vecRotateTest_s = "1") THEN
            aip1E_7_uid158_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_7_uid158_vecRotateTest_a) + SIGNED(aip1E_7_uid158_vecRotateTest_b));
        ELSE
            aip1E_7_uid158_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_7_uid158_vecRotateTest_a) - SIGNED(aip1E_7_uid158_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_7_uid158_vecRotateTest_q <= aip1E_7_uid158_vecRotateTest_o(29 downto 0);

    -- aip1E_uid161_vecRotateTest(BITSELECT,160)@8
    aip1E_uid161_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_7_uid158_vecRotateTest_q(28 downto 0));
    aip1E_uid161_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid161_vecRotateTest_in(28 downto 0));

    -- redist39_aip1E_uid161_vecRotateTest_b_1(DELAY,436)
    redist39_aip1E_uid161_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid161_vecRotateTest_b, xout => redist39_aip1E_uid161_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- aip1E_8_uid174_vecRotateTest(ADDSUB,173)@9
    aip1E_8_uid174_vecRotateTest_s <= xMSB_uid162_vecRotateTest_b;
    aip1E_8_uid174_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 29 => redist39_aip1E_uid161_vecRotateTest_b_1_q(28)) & redist39_aip1E_uid161_vecRotateTest_b_1_q));
    aip1E_8_uid174_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 21 => cstArcTan2Mi_7_uid169_vecRotateTest_q(20)) & cstArcTan2Mi_7_uid169_vecRotateTest_q));
    aip1E_8_uid174_vecRotateTest_combproc: PROCESS (aip1E_8_uid174_vecRotateTest_a, aip1E_8_uid174_vecRotateTest_b, aip1E_8_uid174_vecRotateTest_s)
    BEGIN
        IF (aip1E_8_uid174_vecRotateTest_s = "1") THEN
            aip1E_8_uid174_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_8_uid174_vecRotateTest_a) + SIGNED(aip1E_8_uid174_vecRotateTest_b));
        ELSE
            aip1E_8_uid174_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_8_uid174_vecRotateTest_a) - SIGNED(aip1E_8_uid174_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_8_uid174_vecRotateTest_q <= aip1E_8_uid174_vecRotateTest_o(29 downto 0);

    -- aip1E_uid177_vecRotateTest(BITSELECT,176)@9
    aip1E_uid177_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_8_uid174_vecRotateTest_q(28 downto 0));
    aip1E_uid177_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid177_vecRotateTest_in(28 downto 0));

    -- redist36_aip1E_uid177_vecRotateTest_b_1(DELAY,433)
    redist36_aip1E_uid177_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid177_vecRotateTest_b, xout => redist36_aip1E_uid177_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- aip1E_9_uid190_vecRotateTest(ADDSUB,189)@10
    aip1E_9_uid190_vecRotateTest_s <= xMSB_uid178_vecRotateTest_b;
    aip1E_9_uid190_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 29 => redist36_aip1E_uid177_vecRotateTest_b_1_q(28)) & redist36_aip1E_uid177_vecRotateTest_b_1_q));
    aip1E_9_uid190_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 20 => cstArcTan2Mi_8_uid185_vecRotateTest_q(19)) & cstArcTan2Mi_8_uid185_vecRotateTest_q));
    aip1E_9_uid190_vecRotateTest_combproc: PROCESS (aip1E_9_uid190_vecRotateTest_a, aip1E_9_uid190_vecRotateTest_b, aip1E_9_uid190_vecRotateTest_s)
    BEGIN
        IF (aip1E_9_uid190_vecRotateTest_s = "1") THEN
            aip1E_9_uid190_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_9_uid190_vecRotateTest_a) + SIGNED(aip1E_9_uid190_vecRotateTest_b));
        ELSE
            aip1E_9_uid190_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_9_uid190_vecRotateTest_a) - SIGNED(aip1E_9_uid190_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_9_uid190_vecRotateTest_q <= aip1E_9_uid190_vecRotateTest_o(29 downto 0);

    -- aip1E_uid193_vecRotateTest(BITSELECT,192)@10
    aip1E_uid193_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_9_uid190_vecRotateTest_q(28 downto 0));
    aip1E_uid193_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid193_vecRotateTest_in(28 downto 0));

    -- redist33_aip1E_uid193_vecRotateTest_b_1(DELAY,430)
    redist33_aip1E_uid193_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid193_vecRotateTest_b, xout => redist33_aip1E_uid193_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid194_vecRotateTest(BITSELECT,193)@11
    xMSB_uid194_vecRotateTest_b <= STD_LOGIC_VECTOR(redist33_aip1E_uid193_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_9_uid201_vecRotateTest(CONSTANT,200)
    cstArcTan2Mi_9_uid201_vecRotateTest_q <= "0100000000000000000";

    -- highABits_uid207_vecRotateTest(BITSELECT,206)@11
    highABits_uid207_vecRotateTest_b <= STD_LOGIC_VECTOR(redist33_aip1E_uid193_vecRotateTest_b_1_q(28 downto 1));

    -- aip1E_10high_uid208_vecRotateTest(ADDSUB,207)@11
    aip1E_10high_uid208_vecRotateTest_s <= xMSB_uid194_vecRotateTest_b;
    aip1E_10high_uid208_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 28 => highABits_uid207_vecRotateTest_b(27)) & highABits_uid207_vecRotateTest_b));
    aip1E_10high_uid208_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 19 => cstArcTan2Mi_9_uid201_vecRotateTest_q(18)) & cstArcTan2Mi_9_uid201_vecRotateTest_q));
    aip1E_10high_uid208_vecRotateTest_combproc: PROCESS (aip1E_10high_uid208_vecRotateTest_a, aip1E_10high_uid208_vecRotateTest_b, aip1E_10high_uid208_vecRotateTest_s)
    BEGIN
        IF (aip1E_10high_uid208_vecRotateTest_s = "1") THEN
            aip1E_10high_uid208_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_10high_uid208_vecRotateTest_a) + SIGNED(aip1E_10high_uid208_vecRotateTest_b));
        ELSE
            aip1E_10high_uid208_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_10high_uid208_vecRotateTest_a) - SIGNED(aip1E_10high_uid208_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_10high_uid208_vecRotateTest_q <= aip1E_10high_uid208_vecRotateTest_o(28 downto 0);

    -- lowRangeA_uid206_vecRotateTest(BITSELECT,205)@11
    lowRangeA_uid206_vecRotateTest_in <= redist33_aip1E_uid193_vecRotateTest_b_1_q(0 downto 0);
    lowRangeA_uid206_vecRotateTest_b <= lowRangeA_uid206_vecRotateTest_in(0 downto 0);

    -- aip1E_10_uid209_vecRotateTest(BITJOIN,208)@11
    aip1E_10_uid209_vecRotateTest_q <= aip1E_10high_uid208_vecRotateTest_q & lowRangeA_uid206_vecRotateTest_b;

    -- aip1E_uid212_vecRotateTest(BITSELECT,211)@11
    aip1E_uid212_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_10_uid209_vecRotateTest_q(28 downto 0));
    aip1E_uid212_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid212_vecRotateTest_in(28 downto 0));

    -- redist30_aip1E_uid212_vecRotateTest_b_1(DELAY,427)
    redist30_aip1E_uid212_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid212_vecRotateTest_b, xout => redist30_aip1E_uid212_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid213_vecRotateTest(BITSELECT,212)@12
    xMSB_uid213_vecRotateTest_b <= STD_LOGIC_VECTOR(redist30_aip1E_uid212_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_10_uid220_vecRotateTest(CONSTANT,219)
    cstArcTan2Mi_10_uid220_vecRotateTest_q <= "010000000000000000";

    -- highABits_uid226_vecRotateTest(BITSELECT,225)@12
    highABits_uid226_vecRotateTest_b <= STD_LOGIC_VECTOR(redist30_aip1E_uid212_vecRotateTest_b_1_q(28 downto 1));

    -- aip1E_11high_uid227_vecRotateTest(ADDSUB,226)@12
    aip1E_11high_uid227_vecRotateTest_s <= xMSB_uid213_vecRotateTest_b;
    aip1E_11high_uid227_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 28 => highABits_uid226_vecRotateTest_b(27)) & highABits_uid226_vecRotateTest_b));
    aip1E_11high_uid227_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 18 => cstArcTan2Mi_10_uid220_vecRotateTest_q(17)) & cstArcTan2Mi_10_uid220_vecRotateTest_q));
    aip1E_11high_uid227_vecRotateTest_combproc: PROCESS (aip1E_11high_uid227_vecRotateTest_a, aip1E_11high_uid227_vecRotateTest_b, aip1E_11high_uid227_vecRotateTest_s)
    BEGIN
        IF (aip1E_11high_uid227_vecRotateTest_s = "1") THEN
            aip1E_11high_uid227_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_11high_uid227_vecRotateTest_a) + SIGNED(aip1E_11high_uid227_vecRotateTest_b));
        ELSE
            aip1E_11high_uid227_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_11high_uid227_vecRotateTest_a) - SIGNED(aip1E_11high_uid227_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_11high_uid227_vecRotateTest_q <= aip1E_11high_uid227_vecRotateTest_o(28 downto 0);

    -- lowRangeA_uid225_vecRotateTest(BITSELECT,224)@12
    lowRangeA_uid225_vecRotateTest_in <= redist30_aip1E_uid212_vecRotateTest_b_1_q(0 downto 0);
    lowRangeA_uid225_vecRotateTest_b <= lowRangeA_uid225_vecRotateTest_in(0 downto 0);

    -- aip1E_11_uid228_vecRotateTest(BITJOIN,227)@12
    aip1E_11_uid228_vecRotateTest_q <= aip1E_11high_uid227_vecRotateTest_q & lowRangeA_uid225_vecRotateTest_b;

    -- aip1E_uid231_vecRotateTest(BITSELECT,230)@12
    aip1E_uid231_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_11_uid228_vecRotateTest_q(28 downto 0));
    aip1E_uid231_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid231_vecRotateTest_in(28 downto 0));

    -- redist27_aip1E_uid231_vecRotateTest_b_1(DELAY,424)
    redist27_aip1E_uid231_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid231_vecRotateTest_b, xout => redist27_aip1E_uid231_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid232_vecRotateTest(BITSELECT,231)@13
    xMSB_uid232_vecRotateTest_b <= STD_LOGIC_VECTOR(redist27_aip1E_uid231_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_11_uid239_vecRotateTest(CONSTANT,238)
    cstArcTan2Mi_11_uid239_vecRotateTest_q <= "01000000000000000";

    -- highABits_uid245_vecRotateTest(BITSELECT,244)@13
    highABits_uid245_vecRotateTest_b <= STD_LOGIC_VECTOR(redist27_aip1E_uid231_vecRotateTest_b_1_q(28 downto 1));

    -- aip1E_12high_uid246_vecRotateTest(ADDSUB,245)@13
    aip1E_12high_uid246_vecRotateTest_s <= xMSB_uid232_vecRotateTest_b;
    aip1E_12high_uid246_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 28 => highABits_uid245_vecRotateTest_b(27)) & highABits_uid245_vecRotateTest_b));
    aip1E_12high_uid246_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 17 => cstArcTan2Mi_11_uid239_vecRotateTest_q(16)) & cstArcTan2Mi_11_uid239_vecRotateTest_q));
    aip1E_12high_uid246_vecRotateTest_combproc: PROCESS (aip1E_12high_uid246_vecRotateTest_a, aip1E_12high_uid246_vecRotateTest_b, aip1E_12high_uid246_vecRotateTest_s)
    BEGIN
        IF (aip1E_12high_uid246_vecRotateTest_s = "1") THEN
            aip1E_12high_uid246_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_12high_uid246_vecRotateTest_a) + SIGNED(aip1E_12high_uid246_vecRotateTest_b));
        ELSE
            aip1E_12high_uid246_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_12high_uid246_vecRotateTest_a) - SIGNED(aip1E_12high_uid246_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_12high_uid246_vecRotateTest_q <= aip1E_12high_uid246_vecRotateTest_o(28 downto 0);

    -- lowRangeA_uid244_vecRotateTest(BITSELECT,243)@13
    lowRangeA_uid244_vecRotateTest_in <= redist27_aip1E_uid231_vecRotateTest_b_1_q(0 downto 0);
    lowRangeA_uid244_vecRotateTest_b <= lowRangeA_uid244_vecRotateTest_in(0 downto 0);

    -- aip1E_12_uid247_vecRotateTest(BITJOIN,246)@13
    aip1E_12_uid247_vecRotateTest_q <= aip1E_12high_uid246_vecRotateTest_q & lowRangeA_uid244_vecRotateTest_b;

    -- aip1E_uid250_vecRotateTest(BITSELECT,249)@13
    aip1E_uid250_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_12_uid247_vecRotateTest_q(28 downto 0));
    aip1E_uid250_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid250_vecRotateTest_in(28 downto 0));

    -- redist24_aip1E_uid250_vecRotateTest_b_1(DELAY,421)
    redist24_aip1E_uid250_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid250_vecRotateTest_b, xout => redist24_aip1E_uid250_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid251_vecRotateTest(BITSELECT,250)@14
    xMSB_uid251_vecRotateTest_b <= STD_LOGIC_VECTOR(redist24_aip1E_uid250_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_12_uid258_vecRotateTest(CONSTANT,257)
    cstArcTan2Mi_12_uid258_vecRotateTest_q <= "0100000000000000";

    -- highABits_uid264_vecRotateTest(BITSELECT,263)@14
    highABits_uid264_vecRotateTest_b <= STD_LOGIC_VECTOR(redist24_aip1E_uid250_vecRotateTest_b_1_q(28 downto 1));

    -- aip1E_13high_uid265_vecRotateTest(ADDSUB,264)@14
    aip1E_13high_uid265_vecRotateTest_s <= xMSB_uid251_vecRotateTest_b;
    aip1E_13high_uid265_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 28 => highABits_uid264_vecRotateTest_b(27)) & highABits_uid264_vecRotateTest_b));
    aip1E_13high_uid265_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 16 => cstArcTan2Mi_12_uid258_vecRotateTest_q(15)) & cstArcTan2Mi_12_uid258_vecRotateTest_q));
    aip1E_13high_uid265_vecRotateTest_combproc: PROCESS (aip1E_13high_uid265_vecRotateTest_a, aip1E_13high_uid265_vecRotateTest_b, aip1E_13high_uid265_vecRotateTest_s)
    BEGIN
        IF (aip1E_13high_uid265_vecRotateTest_s = "1") THEN
            aip1E_13high_uid265_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_13high_uid265_vecRotateTest_a) + SIGNED(aip1E_13high_uid265_vecRotateTest_b));
        ELSE
            aip1E_13high_uid265_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_13high_uid265_vecRotateTest_a) - SIGNED(aip1E_13high_uid265_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_13high_uid265_vecRotateTest_q <= aip1E_13high_uid265_vecRotateTest_o(28 downto 0);

    -- lowRangeA_uid263_vecRotateTest(BITSELECT,262)@14
    lowRangeA_uid263_vecRotateTest_in <= redist24_aip1E_uid250_vecRotateTest_b_1_q(0 downto 0);
    lowRangeA_uid263_vecRotateTest_b <= lowRangeA_uid263_vecRotateTest_in(0 downto 0);

    -- aip1E_13_uid266_vecRotateTest(BITJOIN,265)@14
    aip1E_13_uid266_vecRotateTest_q <= aip1E_13high_uid265_vecRotateTest_q & lowRangeA_uid263_vecRotateTest_b;

    -- aip1E_uid269_vecRotateTest(BITSELECT,268)@14
    aip1E_uid269_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_13_uid266_vecRotateTest_q(28 downto 0));
    aip1E_uid269_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid269_vecRotateTest_in(28 downto 0));

    -- redist21_aip1E_uid269_vecRotateTest_b_1(DELAY,418)
    redist21_aip1E_uid269_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid269_vecRotateTest_b, xout => redist21_aip1E_uid269_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid270_vecRotateTest(BITSELECT,269)@15
    xMSB_uid270_vecRotateTest_b <= STD_LOGIC_VECTOR(redist21_aip1E_uid269_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_13_uid277_vecRotateTest(CONSTANT,276)
    cstArcTan2Mi_13_uid277_vecRotateTest_q <= "010000000000000";

    -- highABits_uid283_vecRotateTest(BITSELECT,282)@15
    highABits_uid283_vecRotateTest_b <= STD_LOGIC_VECTOR(redist21_aip1E_uid269_vecRotateTest_b_1_q(28 downto 1));

    -- aip1E_14high_uid284_vecRotateTest(ADDSUB,283)@15
    aip1E_14high_uid284_vecRotateTest_s <= xMSB_uid270_vecRotateTest_b;
    aip1E_14high_uid284_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 28 => highABits_uid283_vecRotateTest_b(27)) & highABits_uid283_vecRotateTest_b));
    aip1E_14high_uid284_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 15 => cstArcTan2Mi_13_uid277_vecRotateTest_q(14)) & cstArcTan2Mi_13_uid277_vecRotateTest_q));
    aip1E_14high_uid284_vecRotateTest_combproc: PROCESS (aip1E_14high_uid284_vecRotateTest_a, aip1E_14high_uid284_vecRotateTest_b, aip1E_14high_uid284_vecRotateTest_s)
    BEGIN
        IF (aip1E_14high_uid284_vecRotateTest_s = "1") THEN
            aip1E_14high_uid284_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_14high_uid284_vecRotateTest_a) + SIGNED(aip1E_14high_uid284_vecRotateTest_b));
        ELSE
            aip1E_14high_uid284_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_14high_uid284_vecRotateTest_a) - SIGNED(aip1E_14high_uid284_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_14high_uid284_vecRotateTest_q <= aip1E_14high_uid284_vecRotateTest_o(28 downto 0);

    -- lowRangeA_uid282_vecRotateTest(BITSELECT,281)@15
    lowRangeA_uid282_vecRotateTest_in <= redist21_aip1E_uid269_vecRotateTest_b_1_q(0 downto 0);
    lowRangeA_uid282_vecRotateTest_b <= lowRangeA_uid282_vecRotateTest_in(0 downto 0);

    -- aip1E_14_uid285_vecRotateTest(BITJOIN,284)@15
    aip1E_14_uid285_vecRotateTest_q <= aip1E_14high_uid284_vecRotateTest_q & lowRangeA_uid282_vecRotateTest_b;

    -- aip1E_uid288_vecRotateTest(BITSELECT,287)@15
    aip1E_uid288_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_14_uid285_vecRotateTest_q(28 downto 0));
    aip1E_uid288_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid288_vecRotateTest_in(28 downto 0));

    -- redist18_aip1E_uid288_vecRotateTest_b_1(DELAY,415)
    redist18_aip1E_uid288_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid288_vecRotateTest_b, xout => redist18_aip1E_uid288_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid289_vecRotateTest(BITSELECT,288)@16
    xMSB_uid289_vecRotateTest_b <= STD_LOGIC_VECTOR(redist18_aip1E_uid288_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_14_uid296_vecRotateTest(CONSTANT,295)
    cstArcTan2Mi_14_uid296_vecRotateTest_q <= "01000000000000";

    -- highABits_uid302_vecRotateTest(BITSELECT,301)@16
    highABits_uid302_vecRotateTest_b <= STD_LOGIC_VECTOR(redist18_aip1E_uid288_vecRotateTest_b_1_q(28 downto 1));

    -- aip1E_15high_uid303_vecRotateTest(ADDSUB,302)@16
    aip1E_15high_uid303_vecRotateTest_s <= xMSB_uid289_vecRotateTest_b;
    aip1E_15high_uid303_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 28 => highABits_uid302_vecRotateTest_b(27)) & highABits_uid302_vecRotateTest_b));
    aip1E_15high_uid303_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 14 => cstArcTan2Mi_14_uid296_vecRotateTest_q(13)) & cstArcTan2Mi_14_uid296_vecRotateTest_q));
    aip1E_15high_uid303_vecRotateTest_combproc: PROCESS (aip1E_15high_uid303_vecRotateTest_a, aip1E_15high_uid303_vecRotateTest_b, aip1E_15high_uid303_vecRotateTest_s)
    BEGIN
        IF (aip1E_15high_uid303_vecRotateTest_s = "1") THEN
            aip1E_15high_uid303_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_15high_uid303_vecRotateTest_a) + SIGNED(aip1E_15high_uid303_vecRotateTest_b));
        ELSE
            aip1E_15high_uid303_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_15high_uid303_vecRotateTest_a) - SIGNED(aip1E_15high_uid303_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_15high_uid303_vecRotateTest_q <= aip1E_15high_uid303_vecRotateTest_o(28 downto 0);

    -- lowRangeA_uid301_vecRotateTest(BITSELECT,300)@16
    lowRangeA_uid301_vecRotateTest_in <= redist18_aip1E_uid288_vecRotateTest_b_1_q(0 downto 0);
    lowRangeA_uid301_vecRotateTest_b <= lowRangeA_uid301_vecRotateTest_in(0 downto 0);

    -- aip1E_15_uid304_vecRotateTest(BITJOIN,303)@16
    aip1E_15_uid304_vecRotateTest_q <= aip1E_15high_uid303_vecRotateTest_q & lowRangeA_uid301_vecRotateTest_b;

    -- aip1E_uid307_vecRotateTest(BITSELECT,306)@16
    aip1E_uid307_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_15_uid304_vecRotateTest_q(28 downto 0));
    aip1E_uid307_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid307_vecRotateTest_in(28 downto 0));

    -- redist15_aip1E_uid307_vecRotateTest_b_1(DELAY,412)
    redist15_aip1E_uid307_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid307_vecRotateTest_b, xout => redist15_aip1E_uid307_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid308_vecRotateTest(BITSELECT,307)@17
    xMSB_uid308_vecRotateTest_b <= STD_LOGIC_VECTOR(redist15_aip1E_uid307_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_15_uid315_vecRotateTest(CONSTANT,314)
    cstArcTan2Mi_15_uid315_vecRotateTest_q <= "0100000000000";

    -- highABits_uid321_vecRotateTest(BITSELECT,320)@17
    highABits_uid321_vecRotateTest_b <= STD_LOGIC_VECTOR(redist15_aip1E_uid307_vecRotateTest_b_1_q(28 downto 1));

    -- aip1E_16high_uid322_vecRotateTest(ADDSUB,321)@17
    aip1E_16high_uid322_vecRotateTest_s <= xMSB_uid308_vecRotateTest_b;
    aip1E_16high_uid322_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 28 => highABits_uid321_vecRotateTest_b(27)) & highABits_uid321_vecRotateTest_b));
    aip1E_16high_uid322_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 13 => cstArcTan2Mi_15_uid315_vecRotateTest_q(12)) & cstArcTan2Mi_15_uid315_vecRotateTest_q));
    aip1E_16high_uid322_vecRotateTest_combproc: PROCESS (aip1E_16high_uid322_vecRotateTest_a, aip1E_16high_uid322_vecRotateTest_b, aip1E_16high_uid322_vecRotateTest_s)
    BEGIN
        IF (aip1E_16high_uid322_vecRotateTest_s = "1") THEN
            aip1E_16high_uid322_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_16high_uid322_vecRotateTest_a) + SIGNED(aip1E_16high_uid322_vecRotateTest_b));
        ELSE
            aip1E_16high_uid322_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_16high_uid322_vecRotateTest_a) - SIGNED(aip1E_16high_uid322_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_16high_uid322_vecRotateTest_q <= aip1E_16high_uid322_vecRotateTest_o(28 downto 0);

    -- lowRangeA_uid320_vecRotateTest(BITSELECT,319)@17
    lowRangeA_uid320_vecRotateTest_in <= redist15_aip1E_uid307_vecRotateTest_b_1_q(0 downto 0);
    lowRangeA_uid320_vecRotateTest_b <= lowRangeA_uid320_vecRotateTest_in(0 downto 0);

    -- aip1E_16_uid323_vecRotateTest(BITJOIN,322)@17
    aip1E_16_uid323_vecRotateTest_q <= aip1E_16high_uid322_vecRotateTest_q & lowRangeA_uid320_vecRotateTest_b;

    -- aip1E_uid326_vecRotateTest(BITSELECT,325)@17
    aip1E_uid326_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_16_uid323_vecRotateTest_q(28 downto 0));
    aip1E_uid326_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid326_vecRotateTest_in(28 downto 0));

    -- redist12_aip1E_uid326_vecRotateTest_b_1(DELAY,409)
    redist12_aip1E_uid326_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid326_vecRotateTest_b, xout => redist12_aip1E_uid326_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid327_vecRotateTest(BITSELECT,326)@18
    xMSB_uid327_vecRotateTest_b <= STD_LOGIC_VECTOR(redist12_aip1E_uid326_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_16_uid334_vecRotateTest(CONSTANT,333)
    cstArcTan2Mi_16_uid334_vecRotateTest_q <= "010000000000";

    -- highABits_uid340_vecRotateTest(BITSELECT,339)@18
    highABits_uid340_vecRotateTest_b <= STD_LOGIC_VECTOR(redist12_aip1E_uid326_vecRotateTest_b_1_q(28 downto 1));

    -- aip1E_17high_uid341_vecRotateTest(ADDSUB,340)@18
    aip1E_17high_uid341_vecRotateTest_s <= xMSB_uid327_vecRotateTest_b;
    aip1E_17high_uid341_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 28 => highABits_uid340_vecRotateTest_b(27)) & highABits_uid340_vecRotateTest_b));
    aip1E_17high_uid341_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 12 => cstArcTan2Mi_16_uid334_vecRotateTest_q(11)) & cstArcTan2Mi_16_uid334_vecRotateTest_q));
    aip1E_17high_uid341_vecRotateTest_combproc: PROCESS (aip1E_17high_uid341_vecRotateTest_a, aip1E_17high_uid341_vecRotateTest_b, aip1E_17high_uid341_vecRotateTest_s)
    BEGIN
        IF (aip1E_17high_uid341_vecRotateTest_s = "1") THEN
            aip1E_17high_uid341_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_17high_uid341_vecRotateTest_a) + SIGNED(aip1E_17high_uid341_vecRotateTest_b));
        ELSE
            aip1E_17high_uid341_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_17high_uid341_vecRotateTest_a) - SIGNED(aip1E_17high_uid341_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_17high_uid341_vecRotateTest_q <= aip1E_17high_uid341_vecRotateTest_o(28 downto 0);

    -- lowRangeA_uid339_vecRotateTest(BITSELECT,338)@18
    lowRangeA_uid339_vecRotateTest_in <= redist12_aip1E_uid326_vecRotateTest_b_1_q(0 downto 0);
    lowRangeA_uid339_vecRotateTest_b <= lowRangeA_uid339_vecRotateTest_in(0 downto 0);

    -- aip1E_17_uid342_vecRotateTest(BITJOIN,341)@18
    aip1E_17_uid342_vecRotateTest_q <= aip1E_17high_uid341_vecRotateTest_q & lowRangeA_uid339_vecRotateTest_b;

    -- aip1E_uid345_vecRotateTest(BITSELECT,344)@18
    aip1E_uid345_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_17_uid342_vecRotateTest_q(28 downto 0));
    aip1E_uid345_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid345_vecRotateTest_in(28 downto 0));

    -- redist9_aip1E_uid345_vecRotateTest_b_1(DELAY,406)
    redist9_aip1E_uid345_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 29, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => aip1E_uid345_vecRotateTest_b, xout => redist9_aip1E_uid345_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xMSB_uid346_vecRotateTest(BITSELECT,345)@19
    xMSB_uid346_vecRotateTest_b <= STD_LOGIC_VECTOR(redist9_aip1E_uid345_vecRotateTest_b_1_q(28 downto 28));

    -- cstArcTan2Mi_17_uid353_vecRotateTest(CONSTANT,352)
    cstArcTan2Mi_17_uid353_vecRotateTest_q <= "01000000000";

    -- highABits_uid359_vecRotateTest(BITSELECT,358)@19
    highABits_uid359_vecRotateTest_b <= STD_LOGIC_VECTOR(redist9_aip1E_uid345_vecRotateTest_b_1_q(28 downto 1));

    -- aip1E_18high_uid360_vecRotateTest(ADDSUB,359)@19
    aip1E_18high_uid360_vecRotateTest_s <= xMSB_uid346_vecRotateTest_b;
    aip1E_18high_uid360_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 28 => highABits_uid359_vecRotateTest_b(27)) & highABits_uid359_vecRotateTest_b));
    aip1E_18high_uid360_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 11 => cstArcTan2Mi_17_uid353_vecRotateTest_q(10)) & cstArcTan2Mi_17_uid353_vecRotateTest_q));
    aip1E_18high_uid360_vecRotateTest_combproc: PROCESS (aip1E_18high_uid360_vecRotateTest_a, aip1E_18high_uid360_vecRotateTest_b, aip1E_18high_uid360_vecRotateTest_s)
    BEGIN
        IF (aip1E_18high_uid360_vecRotateTest_s = "1") THEN
            aip1E_18high_uid360_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_18high_uid360_vecRotateTest_a) + SIGNED(aip1E_18high_uid360_vecRotateTest_b));
        ELSE
            aip1E_18high_uid360_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(aip1E_18high_uid360_vecRotateTest_a) - SIGNED(aip1E_18high_uid360_vecRotateTest_b));
        END IF;
    END PROCESS;
    aip1E_18high_uid360_vecRotateTest_q <= aip1E_18high_uid360_vecRotateTest_o(28 downto 0);

    -- lowRangeA_uid358_vecRotateTest(BITSELECT,357)@19
    lowRangeA_uid358_vecRotateTest_in <= redist9_aip1E_uid345_vecRotateTest_b_1_q(0 downto 0);
    lowRangeA_uid358_vecRotateTest_b <= lowRangeA_uid358_vecRotateTest_in(0 downto 0);

    -- aip1E_18_uid361_vecRotateTest(BITJOIN,360)@19
    aip1E_18_uid361_vecRotateTest_q <= aip1E_18high_uid360_vecRotateTest_q & lowRangeA_uid358_vecRotateTest_b;

    -- aip1E_uid364_vecRotateTest(BITSELECT,363)@19
    aip1E_uid364_vecRotateTest_in <= STD_LOGIC_VECTOR(aip1E_18_uid361_vecRotateTest_q(28 downto 0));
    aip1E_uid364_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid364_vecRotateTest_in(28 downto 0));

    -- xMSB_uid365_vecRotateTest(BITSELECT,364)@19
    xMSB_uid365_vecRotateTest_b <= STD_LOGIC_VECTOR(aip1E_uid364_vecRotateTest_b(28 downto 28));

    -- redist6_xMSB_uid365_vecRotateTest_b_1(DELAY,403)
    redist6_xMSB_uid365_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xMSB_uid365_vecRotateTest_b, xout => redist6_xMSB_uid365_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid367_vecRotateTest(LOGICAL,366)@20
    signOfSelectionSignal_uid367_vecRotateTest_q <= not (redist6_xMSB_uid365_vecRotateTest_b_1_q);

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- signOfSelectionSignal_uid329_vecRotateTest(LOGICAL,328)@18
    signOfSelectionSignal_uid329_vecRotateTest_q <= not (xMSB_uid327_vecRotateTest_b);

    -- signOfSelectionSignal_uid291_vecRotateTest(LOGICAL,290)@16
    signOfSelectionSignal_uid291_vecRotateTest_q <= not (xMSB_uid289_vecRotateTest_b);

    -- signOfSelectionSignal_uid253_vecRotateTest(LOGICAL,252)@14
    signOfSelectionSignal_uid253_vecRotateTest_q <= not (xMSB_uid251_vecRotateTest_b);

    -- signOfSelectionSignal_uid215_vecRotateTest(LOGICAL,214)@12
    signOfSelectionSignal_uid215_vecRotateTest_q <= not (xMSB_uid213_vecRotateTest_b);

    -- signOfSelectionSignal_uid180_vecRotateTest(LOGICAL,179)@10
    signOfSelectionSignal_uid180_vecRotateTest_q <= not (xMSB_uid178_vecRotateTest_b);

    -- signOfSelectionSignal_uid144_vecRotateTest(LOGICAL,143)@8
    signOfSelectionSignal_uid144_vecRotateTest_q <= not (xMSB_uid142_vecRotateTest_b);

    -- signOfSelectionSignal_uid108_vecRotateTest(LOGICAL,107)@6
    signOfSelectionSignal_uid108_vecRotateTest_q <= not (xMSB_uid106_vecRotateTest_b);

    -- signOfSelectionSignal_uid72_vecRotateTest(LOGICAL,71)@4
    signOfSelectionSignal_uid72_vecRotateTest_q <= not (xMSB_uid70_vecRotateTest_b);

    -- signOfSelectionSignal_uid38_vecRotateTest(LOGICAL,37)@2
    signOfSelectionSignal_uid38_vecRotateTest_q <= not (xMSB_uid36_vecRotateTest_b);

    -- redist59_xIn_y_1(DELAY,456)
    redist59_xIn_y_1 : dspba_delay
    GENERIC MAP ( width => 17, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => y, xout => redist59_xIn_y_1_q, clk => clk, aclr => areset );

    -- redist58_xIn_x_1(DELAY,455)
    redist58_xIn_x_1 : dspba_delay
    GENERIC MAP ( width => 17, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => x, xout => redist58_xIn_x_1_q, clk => clk, aclr => areset );

    -- padACst_uid24_vecRotateTest(CONSTANT,23)
    padACst_uid24_vecRotateTest_q <= "000000000000000";

    -- aPostPad_uid25_vecRotateTest(BITJOIN,24)@1
    aPostPad_uid25_vecRotateTest_q <= GND_q & padACst_uid24_vecRotateTest_q;

    -- my_uid30_vecRotateTest(SUB,29)@1
    my_uid30_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & aPostPad_uid25_vecRotateTest_q));
    my_uid30_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 17 => redist59_xIn_y_1_q(16)) & redist59_xIn_y_1_q));
    my_uid30_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(my_uid30_vecRotateTest_a) - SIGNED(my_uid30_vecRotateTest_b));
    my_uid30_vecRotateTest_q <= my_uid30_vecRotateTest_o(17 downto 0);

    -- myR_uid31_vecRotateTest(BITSELECT,30)@1
    myR_uid31_vecRotateTest_in <= STD_LOGIC_VECTOR(my_uid30_vecRotateTest_q(16 downto 0));
    myR_uid31_vecRotateTest_b <= STD_LOGIC_VECTOR(myR_uid31_vecRotateTest_in(16 downto 0));

    -- concSignAFirstQuadrant_uid32_vecRotateTest(BITJOIN,31)@1
    concSignAFirstQuadrant_uid32_vecRotateTest_q <= redist2_signA_uid7_vecRotateTest_merged_bit_select_b_1_q & firstQuadrant_uid17_vecRotateTest_q;

    -- absX_uid33_vecRotateTest(MUX,32)@1 + 1
    absX_uid33_vecRotateTest_s <= concSignAFirstQuadrant_uid32_vecRotateTest_q;
    absX_uid33_vecRotateTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            absX_uid33_vecRotateTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (absX_uid33_vecRotateTest_s) IS
                WHEN "00" => absX_uid33_vecRotateTest_q <= myR_uid31_vecRotateTest_b;
                WHEN "01" => absX_uid33_vecRotateTest_q <= redist58_xIn_x_1_q;
                WHEN "10" => absX_uid33_vecRotateTest_q <= redist59_xIn_y_1_q;
                WHEN "11" => absX_uid33_vecRotateTest_q <= redist58_xIn_x_1_q;
                WHEN OTHERS => absX_uid33_vecRotateTest_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- mx_uid26_vecRotateTest(SUB,25)@1
    mx_uid26_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & aPostPad_uid25_vecRotateTest_q));
    mx_uid26_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 17 => redist58_xIn_x_1_q(16)) & redist58_xIn_x_1_q));
    mx_uid26_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(mx_uid26_vecRotateTest_a) - SIGNED(mx_uid26_vecRotateTest_b));
    mx_uid26_vecRotateTest_q <= mx_uid26_vecRotateTest_o(17 downto 0);

    -- mxR_uid27_vecRotateTest(BITSELECT,26)@1
    mxR_uid27_vecRotateTest_in <= STD_LOGIC_VECTOR(mx_uid26_vecRotateTest_q(16 downto 0));
    mxR_uid27_vecRotateTest_b <= STD_LOGIC_VECTOR(mxR_uid27_vecRotateTest_in(16 downto 0));

    -- absY_uid34_vecRotateTest(MUX,33)@1 + 1
    absY_uid34_vecRotateTest_s <= concSignAFirstQuadrant_uid32_vecRotateTest_q;
    absY_uid34_vecRotateTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            absY_uid34_vecRotateTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (absY_uid34_vecRotateTest_s) IS
                WHEN "00" => absY_uid34_vecRotateTest_q <= redist58_xIn_x_1_q;
                WHEN "01" => absY_uid34_vecRotateTest_q <= redist59_xIn_y_1_q;
                WHEN "10" => absY_uid34_vecRotateTest_q <= mxR_uid27_vecRotateTest_b;
                WHEN "11" => absY_uid34_vecRotateTest_q <= redist59_xIn_y_1_q;
                WHEN OTHERS => absY_uid34_vecRotateTest_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- yip1E_1_uid44_vecRotateTest(ADDSUB,43)@2 + 1
    yip1E_1_uid44_vecRotateTest_s <= signOfSelectionSignal_uid38_vecRotateTest_q;
    yip1E_1_uid44_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 17 => absY_uid34_vecRotateTest_q(16)) & absY_uid34_vecRotateTest_q));
    yip1E_1_uid44_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 17 => absX_uid33_vecRotateTest_q(16)) & absX_uid33_vecRotateTest_q));
    yip1E_1_uid44_vecRotateTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            yip1E_1_uid44_vecRotateTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (yip1E_1_uid44_vecRotateTest_s = "1") THEN
                yip1E_1_uid44_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_1_uid44_vecRotateTest_a) + SIGNED(yip1E_1_uid44_vecRotateTest_b));
            ELSE
                yip1E_1_uid44_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_1_uid44_vecRotateTest_a) - SIGNED(yip1E_1_uid44_vecRotateTest_b));
            END IF;
        END IF;
    END PROCESS;
    yip1E_1_uid44_vecRotateTest_q <= yip1E_1_uid44_vecRotateTest_o(17 downto 0);

    -- xip1E_1_uid43_vecRotateTest(ADDSUB,42)@2 + 1
    xip1E_1_uid43_vecRotateTest_s <= xMSB_uid36_vecRotateTest_b;
    xip1E_1_uid43_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 17 => absX_uid33_vecRotateTest_q(16)) & absX_uid33_vecRotateTest_q));
    xip1E_1_uid43_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 17 => absY_uid34_vecRotateTest_q(16)) & absY_uid34_vecRotateTest_q));
    xip1E_1_uid43_vecRotateTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            xip1E_1_uid43_vecRotateTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (xip1E_1_uid43_vecRotateTest_s = "1") THEN
                xip1E_1_uid43_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_1_uid43_vecRotateTest_a) + SIGNED(xip1E_1_uid43_vecRotateTest_b));
            ELSE
                xip1E_1_uid43_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_1_uid43_vecRotateTest_a) - SIGNED(xip1E_1_uid43_vecRotateTest_b));
            END IF;
        END IF;
    END PROCESS;
    xip1E_1_uid43_vecRotateTest_q <= xip1E_1_uid43_vecRotateTest_o(17 downto 0);

    -- xip1E_2NA_uid60_vecRotateTest(BITJOIN,59)@3
    xip1E_2NA_uid60_vecRotateTest_q <= xip1E_1_uid43_vecRotateTest_q & GND_q;

    -- xip1E_2sumAHighB_uid61_vecRotateTest(ADDSUB,60)@3
    xip1E_2sumAHighB_uid61_vecRotateTest_s <= xMSB_uid52_vecRotateTest_b;
    xip1E_2sumAHighB_uid61_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 19 => xip1E_2NA_uid60_vecRotateTest_q(18)) & xip1E_2NA_uid60_vecRotateTest_q));
    xip1E_2sumAHighB_uid61_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 18 => yip1E_1_uid44_vecRotateTest_q(17)) & yip1E_1_uid44_vecRotateTest_q));
    xip1E_2sumAHighB_uid61_vecRotateTest_combproc: PROCESS (xip1E_2sumAHighB_uid61_vecRotateTest_a, xip1E_2sumAHighB_uid61_vecRotateTest_b, xip1E_2sumAHighB_uid61_vecRotateTest_s)
    BEGIN
        IF (xip1E_2sumAHighB_uid61_vecRotateTest_s = "1") THEN
            xip1E_2sumAHighB_uid61_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_2sumAHighB_uid61_vecRotateTest_a) + SIGNED(xip1E_2sumAHighB_uid61_vecRotateTest_b));
        ELSE
            xip1E_2sumAHighB_uid61_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_2sumAHighB_uid61_vecRotateTest_a) - SIGNED(xip1E_2sumAHighB_uid61_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_2sumAHighB_uid61_vecRotateTest_q <= xip1E_2sumAHighB_uid61_vecRotateTest_o(19 downto 0);

    -- xip1_2_uid67_vecRotateTest(BITSELECT,66)@3
    xip1_2_uid67_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_2sumAHighB_uid61_vecRotateTest_q(18 downto 0));
    xip1_2_uid67_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_2_uid67_vecRotateTest_in(18 downto 0));

    -- redist56_xip1_2_uid67_vecRotateTest_b_1(DELAY,453)
    redist56_xip1_2_uid67_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 19, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_2_uid67_vecRotateTest_b, xout => redist56_xip1_2_uid67_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid54_vecRotateTest(LOGICAL,53)@3
    signOfSelectionSignal_uid54_vecRotateTest_q <= not (xMSB_uid52_vecRotateTest_b);

    -- yip1E_2NA_uid63_vecRotateTest(BITJOIN,62)@3
    yip1E_2NA_uid63_vecRotateTest_q <= yip1E_1_uid44_vecRotateTest_q & GND_q;

    -- yip1E_2sumAHighB_uid64_vecRotateTest(ADDSUB,63)@3
    yip1E_2sumAHighB_uid64_vecRotateTest_s <= signOfSelectionSignal_uid54_vecRotateTest_q;
    yip1E_2sumAHighB_uid64_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 19 => yip1E_2NA_uid63_vecRotateTest_q(18)) & yip1E_2NA_uid63_vecRotateTest_q));
    yip1E_2sumAHighB_uid64_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 18 => xip1E_1_uid43_vecRotateTest_q(17)) & xip1E_1_uid43_vecRotateTest_q));
    yip1E_2sumAHighB_uid64_vecRotateTest_combproc: PROCESS (yip1E_2sumAHighB_uid64_vecRotateTest_a, yip1E_2sumAHighB_uid64_vecRotateTest_b, yip1E_2sumAHighB_uid64_vecRotateTest_s)
    BEGIN
        IF (yip1E_2sumAHighB_uid64_vecRotateTest_s = "1") THEN
            yip1E_2sumAHighB_uid64_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_2sumAHighB_uid64_vecRotateTest_a) + SIGNED(yip1E_2sumAHighB_uid64_vecRotateTest_b));
        ELSE
            yip1E_2sumAHighB_uid64_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_2sumAHighB_uid64_vecRotateTest_a) - SIGNED(yip1E_2sumAHighB_uid64_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_2sumAHighB_uid64_vecRotateTest_q <= yip1E_2sumAHighB_uid64_vecRotateTest_o(19 downto 0);

    -- yip1_2_uid68_vecRotateTest(BITSELECT,67)@3
    yip1_2_uid68_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_2sumAHighB_uid64_vecRotateTest_q(18 downto 0));
    yip1_2_uid68_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_2_uid68_vecRotateTest_in(18 downto 0));

    -- redist55_yip1_2_uid68_vecRotateTest_b_1(DELAY,452)
    redist55_yip1_2_uid68_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 19, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_2_uid68_vecRotateTest_b, xout => redist55_yip1_2_uid68_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_3CostZeroPaddingA_uid77_vecRotateTest(CONSTANT,76)
    xip1E_3CostZeroPaddingA_uid77_vecRotateTest_q <= "00";

    -- yip1E_3NA_uid81_vecRotateTest(BITJOIN,80)@4
    yip1E_3NA_uid81_vecRotateTest_q <= redist55_yip1_2_uid68_vecRotateTest_b_1_q & xip1E_3CostZeroPaddingA_uid77_vecRotateTest_q;

    -- yip1E_3sumAHighB_uid82_vecRotateTest(ADDSUB,81)@4
    yip1E_3sumAHighB_uid82_vecRotateTest_s <= signOfSelectionSignal_uid72_vecRotateTest_q;
    yip1E_3sumAHighB_uid82_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 21 => yip1E_3NA_uid81_vecRotateTest_q(20)) & yip1E_3NA_uid81_vecRotateTest_q));
    yip1E_3sumAHighB_uid82_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 19 => redist56_xip1_2_uid67_vecRotateTest_b_1_q(18)) & redist56_xip1_2_uid67_vecRotateTest_b_1_q));
    yip1E_3sumAHighB_uid82_vecRotateTest_combproc: PROCESS (yip1E_3sumAHighB_uid82_vecRotateTest_a, yip1E_3sumAHighB_uid82_vecRotateTest_b, yip1E_3sumAHighB_uid82_vecRotateTest_s)
    BEGIN
        IF (yip1E_3sumAHighB_uid82_vecRotateTest_s = "1") THEN
            yip1E_3sumAHighB_uid82_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_3sumAHighB_uid82_vecRotateTest_a) + SIGNED(yip1E_3sumAHighB_uid82_vecRotateTest_b));
        ELSE
            yip1E_3sumAHighB_uid82_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_3sumAHighB_uid82_vecRotateTest_a) - SIGNED(yip1E_3sumAHighB_uid82_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_3sumAHighB_uid82_vecRotateTest_q <= yip1E_3sumAHighB_uid82_vecRotateTest_o(21 downto 0);

    -- yip1_3_uid86_vecRotateTest(BITSELECT,85)@4
    yip1_3_uid86_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_3sumAHighB_uid82_vecRotateTest_q(20 downto 0));
    yip1_3_uid86_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_3_uid86_vecRotateTest_in(20 downto 0));

    -- redist52_yip1_3_uid86_vecRotateTest_b_1(DELAY,449)
    redist52_yip1_3_uid86_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 21, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_3_uid86_vecRotateTest_b, xout => redist52_yip1_3_uid86_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_3NA_uid78_vecRotateTest(BITJOIN,77)@4
    xip1E_3NA_uid78_vecRotateTest_q <= redist56_xip1_2_uid67_vecRotateTest_b_1_q & xip1E_3CostZeroPaddingA_uid77_vecRotateTest_q;

    -- xip1E_3sumAHighB_uid79_vecRotateTest(ADDSUB,78)@4
    xip1E_3sumAHighB_uid79_vecRotateTest_s <= xMSB_uid70_vecRotateTest_b;
    xip1E_3sumAHighB_uid79_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 21 => xip1E_3NA_uid78_vecRotateTest_q(20)) & xip1E_3NA_uid78_vecRotateTest_q));
    xip1E_3sumAHighB_uid79_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 19 => redist55_yip1_2_uid68_vecRotateTest_b_1_q(18)) & redist55_yip1_2_uid68_vecRotateTest_b_1_q));
    xip1E_3sumAHighB_uid79_vecRotateTest_combproc: PROCESS (xip1E_3sumAHighB_uid79_vecRotateTest_a, xip1E_3sumAHighB_uid79_vecRotateTest_b, xip1E_3sumAHighB_uid79_vecRotateTest_s)
    BEGIN
        IF (xip1E_3sumAHighB_uid79_vecRotateTest_s = "1") THEN
            xip1E_3sumAHighB_uid79_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_3sumAHighB_uid79_vecRotateTest_a) + SIGNED(xip1E_3sumAHighB_uid79_vecRotateTest_b));
        ELSE
            xip1E_3sumAHighB_uid79_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_3sumAHighB_uid79_vecRotateTest_a) - SIGNED(xip1E_3sumAHighB_uid79_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_3sumAHighB_uid79_vecRotateTest_q <= xip1E_3sumAHighB_uid79_vecRotateTest_o(21 downto 0);

    -- xip1_3_uid85_vecRotateTest(BITSELECT,84)@4
    xip1_3_uid85_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_3sumAHighB_uid79_vecRotateTest_q(20 downto 0));
    xip1_3_uid85_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_3_uid85_vecRotateTest_in(20 downto 0));

    -- redist53_xip1_3_uid85_vecRotateTest_b_1(DELAY,450)
    redist53_xip1_3_uid85_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 21, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_3_uid85_vecRotateTest_b, xout => redist53_xip1_3_uid85_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_4CostZeroPaddingA_uid95_vecRotateTest(CONSTANT,94)
    xip1E_4CostZeroPaddingA_uid95_vecRotateTest_q <= "000";

    -- xip1E_4NA_uid96_vecRotateTest(BITJOIN,95)@5
    xip1E_4NA_uid96_vecRotateTest_q <= redist53_xip1_3_uid85_vecRotateTest_b_1_q & xip1E_4CostZeroPaddingA_uid95_vecRotateTest_q;

    -- xip1E_4sumAHighB_uid97_vecRotateTest(ADDSUB,96)@5
    xip1E_4sumAHighB_uid97_vecRotateTest_s <= xMSB_uid88_vecRotateTest_b;
    xip1E_4sumAHighB_uid97_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 24 => xip1E_4NA_uid96_vecRotateTest_q(23)) & xip1E_4NA_uid96_vecRotateTest_q));
    xip1E_4sumAHighB_uid97_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 21 => redist52_yip1_3_uid86_vecRotateTest_b_1_q(20)) & redist52_yip1_3_uid86_vecRotateTest_b_1_q));
    xip1E_4sumAHighB_uid97_vecRotateTest_combproc: PROCESS (xip1E_4sumAHighB_uid97_vecRotateTest_a, xip1E_4sumAHighB_uid97_vecRotateTest_b, xip1E_4sumAHighB_uid97_vecRotateTest_s)
    BEGIN
        IF (xip1E_4sumAHighB_uid97_vecRotateTest_s = "1") THEN
            xip1E_4sumAHighB_uid97_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_4sumAHighB_uid97_vecRotateTest_a) + SIGNED(xip1E_4sumAHighB_uid97_vecRotateTest_b));
        ELSE
            xip1E_4sumAHighB_uid97_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_4sumAHighB_uid97_vecRotateTest_a) - SIGNED(xip1E_4sumAHighB_uid97_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_4sumAHighB_uid97_vecRotateTest_q <= xip1E_4sumAHighB_uid97_vecRotateTest_o(24 downto 0);

    -- xip1_4_uid103_vecRotateTest(BITSELECT,102)@5
    xip1_4_uid103_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_4sumAHighB_uid97_vecRotateTest_q(23 downto 0));
    xip1_4_uid103_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_4_uid103_vecRotateTest_in(23 downto 0));

    -- redist50_xip1_4_uid103_vecRotateTest_b_1(DELAY,447)
    redist50_xip1_4_uid103_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_4_uid103_vecRotateTest_b, xout => redist50_xip1_4_uid103_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- signOfSelectionSignal_uid90_vecRotateTest(LOGICAL,89)@5
    signOfSelectionSignal_uid90_vecRotateTest_q <= not (xMSB_uid88_vecRotateTest_b);

    -- yip1E_4NA_uid99_vecRotateTest(BITJOIN,98)@5
    yip1E_4NA_uid99_vecRotateTest_q <= redist52_yip1_3_uid86_vecRotateTest_b_1_q & xip1E_4CostZeroPaddingA_uid95_vecRotateTest_q;

    -- yip1E_4sumAHighB_uid100_vecRotateTest(ADDSUB,99)@5
    yip1E_4sumAHighB_uid100_vecRotateTest_s <= signOfSelectionSignal_uid90_vecRotateTest_q;
    yip1E_4sumAHighB_uid100_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 24 => yip1E_4NA_uid99_vecRotateTest_q(23)) & yip1E_4NA_uid99_vecRotateTest_q));
    yip1E_4sumAHighB_uid100_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 21 => redist53_xip1_3_uid85_vecRotateTest_b_1_q(20)) & redist53_xip1_3_uid85_vecRotateTest_b_1_q));
    yip1E_4sumAHighB_uid100_vecRotateTest_combproc: PROCESS (yip1E_4sumAHighB_uid100_vecRotateTest_a, yip1E_4sumAHighB_uid100_vecRotateTest_b, yip1E_4sumAHighB_uid100_vecRotateTest_s)
    BEGIN
        IF (yip1E_4sumAHighB_uid100_vecRotateTest_s = "1") THEN
            yip1E_4sumAHighB_uid100_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_4sumAHighB_uid100_vecRotateTest_a) + SIGNED(yip1E_4sumAHighB_uid100_vecRotateTest_b));
        ELSE
            yip1E_4sumAHighB_uid100_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_4sumAHighB_uid100_vecRotateTest_a) - SIGNED(yip1E_4sumAHighB_uid100_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_4sumAHighB_uid100_vecRotateTest_q <= yip1E_4sumAHighB_uid100_vecRotateTest_o(24 downto 0);

    -- yip1_4_uid104_vecRotateTest(BITSELECT,103)@5
    yip1_4_uid104_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_4sumAHighB_uid100_vecRotateTest_q(23 downto 0));
    yip1_4_uid104_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_4_uid104_vecRotateTest_in(23 downto 0));

    -- redist49_yip1_4_uid104_vecRotateTest_b_1(DELAY,446)
    redist49_yip1_4_uid104_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_4_uid104_vecRotateTest_b, xout => redist49_yip1_4_uid104_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_5NA_uid117_vecRotateTest(BITJOIN,116)@6
    yip1E_5NA_uid117_vecRotateTest_q <= redist49_yip1_4_uid104_vecRotateTest_b_1_q & aip1E_1CostZeroPaddingA_uid46_vecRotateTest_q;

    -- yip1E_5sumAHighB_uid118_vecRotateTest(ADDSUB,117)@6
    yip1E_5sumAHighB_uid118_vecRotateTest_s <= signOfSelectionSignal_uid108_vecRotateTest_q;
    yip1E_5sumAHighB_uid118_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 28 => yip1E_5NA_uid117_vecRotateTest_q(27)) & yip1E_5NA_uid117_vecRotateTest_q));
    yip1E_5sumAHighB_uid118_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 24 => redist50_xip1_4_uid103_vecRotateTest_b_1_q(23)) & redist50_xip1_4_uid103_vecRotateTest_b_1_q));
    yip1E_5sumAHighB_uid118_vecRotateTest_combproc: PROCESS (yip1E_5sumAHighB_uid118_vecRotateTest_a, yip1E_5sumAHighB_uid118_vecRotateTest_b, yip1E_5sumAHighB_uid118_vecRotateTest_s)
    BEGIN
        IF (yip1E_5sumAHighB_uid118_vecRotateTest_s = "1") THEN
            yip1E_5sumAHighB_uid118_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_5sumAHighB_uid118_vecRotateTest_a) + SIGNED(yip1E_5sumAHighB_uid118_vecRotateTest_b));
        ELSE
            yip1E_5sumAHighB_uid118_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_5sumAHighB_uid118_vecRotateTest_a) - SIGNED(yip1E_5sumAHighB_uid118_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_5sumAHighB_uid118_vecRotateTest_q <= yip1E_5sumAHighB_uid118_vecRotateTest_o(28 downto 0);

    -- yip1_5_uid122_vecRotateTest(BITSELECT,121)@6
    yip1_5_uid122_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_5sumAHighB_uid118_vecRotateTest_q(27 downto 0));
    yip1_5_uid122_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_5_uid122_vecRotateTest_in(27 downto 0));

    -- redist46_yip1_5_uid122_vecRotateTest_b_1(DELAY,443)
    redist46_yip1_5_uid122_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_5_uid122_vecRotateTest_b, xout => redist46_yip1_5_uid122_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_5NA_uid114_vecRotateTest(BITJOIN,113)@6
    xip1E_5NA_uid114_vecRotateTest_q <= redist50_xip1_4_uid103_vecRotateTest_b_1_q & aip1E_1CostZeroPaddingA_uid46_vecRotateTest_q;

    -- xip1E_5sumAHighB_uid115_vecRotateTest(ADDSUB,114)@6
    xip1E_5sumAHighB_uid115_vecRotateTest_s <= xMSB_uid106_vecRotateTest_b;
    xip1E_5sumAHighB_uid115_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 28 => xip1E_5NA_uid114_vecRotateTest_q(27)) & xip1E_5NA_uid114_vecRotateTest_q));
    xip1E_5sumAHighB_uid115_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 24 => redist49_yip1_4_uid104_vecRotateTest_b_1_q(23)) & redist49_yip1_4_uid104_vecRotateTest_b_1_q));
    xip1E_5sumAHighB_uid115_vecRotateTest_combproc: PROCESS (xip1E_5sumAHighB_uid115_vecRotateTest_a, xip1E_5sumAHighB_uid115_vecRotateTest_b, xip1E_5sumAHighB_uid115_vecRotateTest_s)
    BEGIN
        IF (xip1E_5sumAHighB_uid115_vecRotateTest_s = "1") THEN
            xip1E_5sumAHighB_uid115_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_5sumAHighB_uid115_vecRotateTest_a) + SIGNED(xip1E_5sumAHighB_uid115_vecRotateTest_b));
        ELSE
            xip1E_5sumAHighB_uid115_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_5sumAHighB_uid115_vecRotateTest_a) - SIGNED(xip1E_5sumAHighB_uid115_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_5sumAHighB_uid115_vecRotateTest_q <= xip1E_5sumAHighB_uid115_vecRotateTest_o(28 downto 0);

    -- xip1_5_uid121_vecRotateTest(BITSELECT,120)@6
    xip1_5_uid121_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_5sumAHighB_uid115_vecRotateTest_q(27 downto 0));
    xip1_5_uid121_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_5_uid121_vecRotateTest_in(27 downto 0));

    -- redist47_xip1_5_uid121_vecRotateTest_b_1(DELAY,444)
    redist47_xip1_5_uid121_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_5_uid121_vecRotateTest_b, xout => redist47_xip1_5_uid121_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_6CostZeroPaddingA_uid131_vecRotateTest(CONSTANT,130)
    xip1E_6CostZeroPaddingA_uid131_vecRotateTest_q <= "00000";

    -- xip1E_6NA_uid132_vecRotateTest(BITJOIN,131)@7
    xip1E_6NA_uid132_vecRotateTest_q <= redist47_xip1_5_uid121_vecRotateTest_b_1_q & xip1E_6CostZeroPaddingA_uid131_vecRotateTest_q;

    -- xip1E_6sumAHighB_uid133_vecRotateTest(ADDSUB,132)@7
    xip1E_6sumAHighB_uid133_vecRotateTest_s <= xMSB_uid124_vecRotateTest_b;
    xip1E_6sumAHighB_uid133_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 33 => xip1E_6NA_uid132_vecRotateTest_q(32)) & xip1E_6NA_uid132_vecRotateTest_q));
    xip1E_6sumAHighB_uid133_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 28 => redist46_yip1_5_uid122_vecRotateTest_b_1_q(27)) & redist46_yip1_5_uid122_vecRotateTest_b_1_q));
    xip1E_6sumAHighB_uid133_vecRotateTest_combproc: PROCESS (xip1E_6sumAHighB_uid133_vecRotateTest_a, xip1E_6sumAHighB_uid133_vecRotateTest_b, xip1E_6sumAHighB_uid133_vecRotateTest_s)
    BEGIN
        IF (xip1E_6sumAHighB_uid133_vecRotateTest_s = "1") THEN
            xip1E_6sumAHighB_uid133_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_6sumAHighB_uid133_vecRotateTest_a) + SIGNED(xip1E_6sumAHighB_uid133_vecRotateTest_b));
        ELSE
            xip1E_6sumAHighB_uid133_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_6sumAHighB_uid133_vecRotateTest_a) - SIGNED(xip1E_6sumAHighB_uid133_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_6sumAHighB_uid133_vecRotateTest_q <= xip1E_6sumAHighB_uid133_vecRotateTest_o(33 downto 0);

    -- xip1_6_uid139_vecRotateTest(BITSELECT,138)@7
    xip1_6_uid139_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_6sumAHighB_uid133_vecRotateTest_q(32 downto 0));
    xip1_6_uid139_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_6_uid139_vecRotateTest_in(32 downto 0));

    -- redist44_xip1_6_uid139_vecRotateTest_b_1(DELAY,441)
    redist44_xip1_6_uid139_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_6_uid139_vecRotateTest_b, xout => redist44_xip1_6_uid139_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid147_vecRotateTest(BITSELECT,146)@8
    twoToMiSiXip_uid147_vecRotateTest_b <= STD_LOGIC_VECTOR(redist44_xip1_6_uid139_vecRotateTest_b_1_q(32 downto 2));

    -- signOfSelectionSignal_uid126_vecRotateTest(LOGICAL,125)@7
    signOfSelectionSignal_uid126_vecRotateTest_q <= not (xMSB_uid124_vecRotateTest_b);

    -- yip1E_6NA_uid135_vecRotateTest(BITJOIN,134)@7
    yip1E_6NA_uid135_vecRotateTest_q <= redist46_yip1_5_uid122_vecRotateTest_b_1_q & xip1E_6CostZeroPaddingA_uid131_vecRotateTest_q;

    -- yip1E_6sumAHighB_uid136_vecRotateTest(ADDSUB,135)@7
    yip1E_6sumAHighB_uid136_vecRotateTest_s <= signOfSelectionSignal_uid126_vecRotateTest_q;
    yip1E_6sumAHighB_uid136_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 33 => yip1E_6NA_uid135_vecRotateTest_q(32)) & yip1E_6NA_uid135_vecRotateTest_q));
    yip1E_6sumAHighB_uid136_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 28 => redist47_xip1_5_uid121_vecRotateTest_b_1_q(27)) & redist47_xip1_5_uid121_vecRotateTest_b_1_q));
    yip1E_6sumAHighB_uid136_vecRotateTest_combproc: PROCESS (yip1E_6sumAHighB_uid136_vecRotateTest_a, yip1E_6sumAHighB_uid136_vecRotateTest_b, yip1E_6sumAHighB_uid136_vecRotateTest_s)
    BEGIN
        IF (yip1E_6sumAHighB_uid136_vecRotateTest_s = "1") THEN
            yip1E_6sumAHighB_uid136_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_6sumAHighB_uid136_vecRotateTest_a) + SIGNED(yip1E_6sumAHighB_uid136_vecRotateTest_b));
        ELSE
            yip1E_6sumAHighB_uid136_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_6sumAHighB_uid136_vecRotateTest_a) - SIGNED(yip1E_6sumAHighB_uid136_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_6sumAHighB_uid136_vecRotateTest_q <= yip1E_6sumAHighB_uid136_vecRotateTest_o(33 downto 0);

    -- yip1_6_uid140_vecRotateTest(BITSELECT,139)@7
    yip1_6_uid140_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_6sumAHighB_uid136_vecRotateTest_q(32 downto 0));
    yip1_6_uid140_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_6_uid140_vecRotateTest_in(32 downto 0));

    -- redist43_yip1_6_uid140_vecRotateTest_b_1(DELAY,440)
    redist43_yip1_6_uid140_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 33, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_6_uid140_vecRotateTest_b, xout => redist43_yip1_6_uid140_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_7NA_uid155_vecRotateTest(BITJOIN,154)@8
    yip1E_7NA_uid155_vecRotateTest_q <= redist43_yip1_6_uid140_vecRotateTest_b_1_q & aip1E_1CostZeroPaddingA_uid46_vecRotateTest_q;

    -- yip1E_7sumAHighB_uid156_vecRotateTest(ADDSUB,155)@8
    yip1E_7sumAHighB_uid156_vecRotateTest_s <= signOfSelectionSignal_uid144_vecRotateTest_q;
    yip1E_7sumAHighB_uid156_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => yip1E_7NA_uid155_vecRotateTest_q(36)) & yip1E_7NA_uid155_vecRotateTest_q));
    yip1E_7sumAHighB_uid156_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 31 => twoToMiSiXip_uid147_vecRotateTest_b(30)) & twoToMiSiXip_uid147_vecRotateTest_b));
    yip1E_7sumAHighB_uid156_vecRotateTest_combproc: PROCESS (yip1E_7sumAHighB_uid156_vecRotateTest_a, yip1E_7sumAHighB_uid156_vecRotateTest_b, yip1E_7sumAHighB_uid156_vecRotateTest_s)
    BEGIN
        IF (yip1E_7sumAHighB_uid156_vecRotateTest_s = "1") THEN
            yip1E_7sumAHighB_uid156_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_7sumAHighB_uid156_vecRotateTest_a) + SIGNED(yip1E_7sumAHighB_uid156_vecRotateTest_b));
        ELSE
            yip1E_7sumAHighB_uid156_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_7sumAHighB_uid156_vecRotateTest_a) - SIGNED(yip1E_7sumAHighB_uid156_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_7sumAHighB_uid156_vecRotateTest_q <= yip1E_7sumAHighB_uid156_vecRotateTest_o(37 downto 0);

    -- yip1_7_uid160_vecRotateTest(BITSELECT,159)@8
    yip1_7_uid160_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_7sumAHighB_uid156_vecRotateTest_q(36 downto 0));
    yip1_7_uid160_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_7_uid160_vecRotateTest_in(36 downto 0));

    -- redist40_yip1_7_uid160_vecRotateTest_b_1(DELAY,437)
    redist40_yip1_7_uid160_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_7_uid160_vecRotateTest_b, xout => redist40_yip1_7_uid160_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid168_vecRotateTest(BITSELECT,167)@9
    twoToMiSiYip_uid168_vecRotateTest_b <= STD_LOGIC_VECTOR(redist40_yip1_7_uid160_vecRotateTest_b_1_q(36 downto 7));

    -- twoToMiSiYip_uid148_vecRotateTest(BITSELECT,147)@8
    twoToMiSiYip_uid148_vecRotateTest_b <= STD_LOGIC_VECTOR(redist43_yip1_6_uid140_vecRotateTest_b_1_q(32 downto 2));

    -- xip1E_7NA_uid152_vecRotateTest(BITJOIN,151)@8
    xip1E_7NA_uid152_vecRotateTest_q <= redist44_xip1_6_uid139_vecRotateTest_b_1_q & aip1E_1CostZeroPaddingA_uid46_vecRotateTest_q;

    -- xip1E_7sumAHighB_uid153_vecRotateTest(ADDSUB,152)@8
    xip1E_7sumAHighB_uid153_vecRotateTest_s <= xMSB_uid142_vecRotateTest_b;
    xip1E_7sumAHighB_uid153_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => xip1E_7NA_uid152_vecRotateTest_q(36)) & xip1E_7NA_uid152_vecRotateTest_q));
    xip1E_7sumAHighB_uid153_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 31 => twoToMiSiYip_uid148_vecRotateTest_b(30)) & twoToMiSiYip_uid148_vecRotateTest_b));
    xip1E_7sumAHighB_uid153_vecRotateTest_combproc: PROCESS (xip1E_7sumAHighB_uid153_vecRotateTest_a, xip1E_7sumAHighB_uid153_vecRotateTest_b, xip1E_7sumAHighB_uid153_vecRotateTest_s)
    BEGIN
        IF (xip1E_7sumAHighB_uid153_vecRotateTest_s = "1") THEN
            xip1E_7sumAHighB_uid153_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_7sumAHighB_uid153_vecRotateTest_a) + SIGNED(xip1E_7sumAHighB_uid153_vecRotateTest_b));
        ELSE
            xip1E_7sumAHighB_uid153_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_7sumAHighB_uid153_vecRotateTest_a) - SIGNED(xip1E_7sumAHighB_uid153_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_7sumAHighB_uid153_vecRotateTest_q <= xip1E_7sumAHighB_uid153_vecRotateTest_o(37 downto 0);

    -- xip1_7_uid159_vecRotateTest(BITSELECT,158)@8
    xip1_7_uid159_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_7sumAHighB_uid153_vecRotateTest_q(36 downto 0));
    xip1_7_uid159_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_7_uid159_vecRotateTest_in(36 downto 0));

    -- redist41_xip1_7_uid159_vecRotateTest_b_1(DELAY,438)
    redist41_xip1_7_uid159_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_7_uid159_vecRotateTest_b, xout => redist41_xip1_7_uid159_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_8_uid171_vecRotateTest(ADDSUB,170)@9
    xip1E_8_uid171_vecRotateTest_s <= xMSB_uid162_vecRotateTest_b;
    xip1E_8_uid171_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist41_xip1_7_uid159_vecRotateTest_b_1_q(36)) & redist41_xip1_7_uid159_vecRotateTest_b_1_q));
    xip1E_8_uid171_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 30 => twoToMiSiYip_uid168_vecRotateTest_b(29)) & twoToMiSiYip_uid168_vecRotateTest_b));
    xip1E_8_uid171_vecRotateTest_combproc: PROCESS (xip1E_8_uid171_vecRotateTest_a, xip1E_8_uid171_vecRotateTest_b, xip1E_8_uid171_vecRotateTest_s)
    BEGIN
        IF (xip1E_8_uid171_vecRotateTest_s = "1") THEN
            xip1E_8_uid171_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_8_uid171_vecRotateTest_a) + SIGNED(xip1E_8_uid171_vecRotateTest_b));
        ELSE
            xip1E_8_uid171_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_8_uid171_vecRotateTest_a) - SIGNED(xip1E_8_uid171_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_8_uid171_vecRotateTest_q <= xip1E_8_uid171_vecRotateTest_o(37 downto 0);

    -- xip1_8_uid175_vecRotateTest(BITSELECT,174)@9
    xip1_8_uid175_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_8_uid171_vecRotateTest_q(36 downto 0));
    xip1_8_uid175_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_8_uid175_vecRotateTest_in(36 downto 0));

    -- redist38_xip1_8_uid175_vecRotateTest_b_1(DELAY,435)
    redist38_xip1_8_uid175_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_8_uid175_vecRotateTest_b, xout => redist38_xip1_8_uid175_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid183_vecRotateTest(BITSELECT,182)@10
    twoToMiSiXip_uid183_vecRotateTest_b <= STD_LOGIC_VECTOR(redist38_xip1_8_uid175_vecRotateTest_b_1_q(36 downto 8));

    -- signOfSelectionSignal_uid164_vecRotateTest(LOGICAL,163)@9
    signOfSelectionSignal_uid164_vecRotateTest_q <= not (xMSB_uid162_vecRotateTest_b);

    -- twoToMiSiXip_uid167_vecRotateTest(BITSELECT,166)@9
    twoToMiSiXip_uid167_vecRotateTest_b <= STD_LOGIC_VECTOR(redist41_xip1_7_uid159_vecRotateTest_b_1_q(36 downto 7));

    -- yip1E_8_uid172_vecRotateTest(ADDSUB,171)@9
    yip1E_8_uid172_vecRotateTest_s <= signOfSelectionSignal_uid164_vecRotateTest_q;
    yip1E_8_uid172_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist40_yip1_7_uid160_vecRotateTest_b_1_q(36)) & redist40_yip1_7_uid160_vecRotateTest_b_1_q));
    yip1E_8_uid172_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 30 => twoToMiSiXip_uid167_vecRotateTest_b(29)) & twoToMiSiXip_uid167_vecRotateTest_b));
    yip1E_8_uid172_vecRotateTest_combproc: PROCESS (yip1E_8_uid172_vecRotateTest_a, yip1E_8_uid172_vecRotateTest_b, yip1E_8_uid172_vecRotateTest_s)
    BEGIN
        IF (yip1E_8_uid172_vecRotateTest_s = "1") THEN
            yip1E_8_uid172_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_8_uid172_vecRotateTest_a) + SIGNED(yip1E_8_uid172_vecRotateTest_b));
        ELSE
            yip1E_8_uid172_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_8_uid172_vecRotateTest_a) - SIGNED(yip1E_8_uid172_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_8_uid172_vecRotateTest_q <= yip1E_8_uid172_vecRotateTest_o(37 downto 0);

    -- yip1_8_uid176_vecRotateTest(BITSELECT,175)@9
    yip1_8_uid176_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_8_uid172_vecRotateTest_q(36 downto 0));
    yip1_8_uid176_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_8_uid176_vecRotateTest_in(36 downto 0));

    -- redist37_yip1_8_uid176_vecRotateTest_b_1(DELAY,434)
    redist37_yip1_8_uid176_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_8_uid176_vecRotateTest_b, xout => redist37_yip1_8_uid176_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_9_uid188_vecRotateTest(ADDSUB,187)@10
    yip1E_9_uid188_vecRotateTest_s <= signOfSelectionSignal_uid180_vecRotateTest_q;
    yip1E_9_uid188_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist37_yip1_8_uid176_vecRotateTest_b_1_q(36)) & redist37_yip1_8_uid176_vecRotateTest_b_1_q));
    yip1E_9_uid188_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 29 => twoToMiSiXip_uid183_vecRotateTest_b(28)) & twoToMiSiXip_uid183_vecRotateTest_b));
    yip1E_9_uid188_vecRotateTest_combproc: PROCESS (yip1E_9_uid188_vecRotateTest_a, yip1E_9_uid188_vecRotateTest_b, yip1E_9_uid188_vecRotateTest_s)
    BEGIN
        IF (yip1E_9_uid188_vecRotateTest_s = "1") THEN
            yip1E_9_uid188_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_9_uid188_vecRotateTest_a) + SIGNED(yip1E_9_uid188_vecRotateTest_b));
        ELSE
            yip1E_9_uid188_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_9_uid188_vecRotateTest_a) - SIGNED(yip1E_9_uid188_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_9_uid188_vecRotateTest_q <= yip1E_9_uid188_vecRotateTest_o(37 downto 0);

    -- yip1_9_uid192_vecRotateTest(BITSELECT,191)@10
    yip1_9_uid192_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_9_uid188_vecRotateTest_q(36 downto 0));
    yip1_9_uid192_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_9_uid192_vecRotateTest_in(36 downto 0));

    -- redist34_yip1_9_uid192_vecRotateTest_b_1(DELAY,431)
    redist34_yip1_9_uid192_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_9_uid192_vecRotateTest_b, xout => redist34_yip1_9_uid192_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid200_vecRotateTest(BITSELECT,199)@11
    twoToMiSiYip_uid200_vecRotateTest_b <= STD_LOGIC_VECTOR(redist34_yip1_9_uid192_vecRotateTest_b_1_q(36 downto 9));

    -- twoToMiSiYip_uid184_vecRotateTest(BITSELECT,183)@10
    twoToMiSiYip_uid184_vecRotateTest_b <= STD_LOGIC_VECTOR(redist37_yip1_8_uid176_vecRotateTest_b_1_q(36 downto 8));

    -- xip1E_9_uid187_vecRotateTest(ADDSUB,186)@10
    xip1E_9_uid187_vecRotateTest_s <= xMSB_uid178_vecRotateTest_b;
    xip1E_9_uid187_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist38_xip1_8_uid175_vecRotateTest_b_1_q(36)) & redist38_xip1_8_uid175_vecRotateTest_b_1_q));
    xip1E_9_uid187_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 29 => twoToMiSiYip_uid184_vecRotateTest_b(28)) & twoToMiSiYip_uid184_vecRotateTest_b));
    xip1E_9_uid187_vecRotateTest_combproc: PROCESS (xip1E_9_uid187_vecRotateTest_a, xip1E_9_uid187_vecRotateTest_b, xip1E_9_uid187_vecRotateTest_s)
    BEGIN
        IF (xip1E_9_uid187_vecRotateTest_s = "1") THEN
            xip1E_9_uid187_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_9_uid187_vecRotateTest_a) + SIGNED(xip1E_9_uid187_vecRotateTest_b));
        ELSE
            xip1E_9_uid187_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_9_uid187_vecRotateTest_a) - SIGNED(xip1E_9_uid187_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_9_uid187_vecRotateTest_q <= xip1E_9_uid187_vecRotateTest_o(37 downto 0);

    -- xip1_9_uid191_vecRotateTest(BITSELECT,190)@10
    xip1_9_uid191_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_9_uid187_vecRotateTest_q(36 downto 0));
    xip1_9_uid191_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_9_uid191_vecRotateTest_in(36 downto 0));

    -- redist35_xip1_9_uid191_vecRotateTest_b_1(DELAY,432)
    redist35_xip1_9_uid191_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_9_uid191_vecRotateTest_b, xout => redist35_xip1_9_uid191_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_10_uid203_vecRotateTest(ADDSUB,202)@11
    xip1E_10_uid203_vecRotateTest_s <= xMSB_uid194_vecRotateTest_b;
    xip1E_10_uid203_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist35_xip1_9_uid191_vecRotateTest_b_1_q(36)) & redist35_xip1_9_uid191_vecRotateTest_b_1_q));
    xip1E_10_uid203_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 28 => twoToMiSiYip_uid200_vecRotateTest_b(27)) & twoToMiSiYip_uid200_vecRotateTest_b));
    xip1E_10_uid203_vecRotateTest_combproc: PROCESS (xip1E_10_uid203_vecRotateTest_a, xip1E_10_uid203_vecRotateTest_b, xip1E_10_uid203_vecRotateTest_s)
    BEGIN
        IF (xip1E_10_uid203_vecRotateTest_s = "1") THEN
            xip1E_10_uid203_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_10_uid203_vecRotateTest_a) + SIGNED(xip1E_10_uid203_vecRotateTest_b));
        ELSE
            xip1E_10_uid203_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_10_uid203_vecRotateTest_a) - SIGNED(xip1E_10_uid203_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_10_uid203_vecRotateTest_q <= xip1E_10_uid203_vecRotateTest_o(37 downto 0);

    -- xip1_10_uid210_vecRotateTest(BITSELECT,209)@11
    xip1_10_uid210_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_10_uid203_vecRotateTest_q(36 downto 0));
    xip1_10_uid210_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_10_uid210_vecRotateTest_in(36 downto 0));

    -- redist32_xip1_10_uid210_vecRotateTest_b_1(DELAY,429)
    redist32_xip1_10_uid210_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_10_uid210_vecRotateTest_b, xout => redist32_xip1_10_uid210_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid218_vecRotateTest(BITSELECT,217)@12
    twoToMiSiXip_uid218_vecRotateTest_b <= STD_LOGIC_VECTOR(redist32_xip1_10_uid210_vecRotateTest_b_1_q(36 downto 10));

    -- signOfSelectionSignal_uid196_vecRotateTest(LOGICAL,195)@11
    signOfSelectionSignal_uid196_vecRotateTest_q <= not (xMSB_uid194_vecRotateTest_b);

    -- twoToMiSiXip_uid199_vecRotateTest(BITSELECT,198)@11
    twoToMiSiXip_uid199_vecRotateTest_b <= STD_LOGIC_VECTOR(redist35_xip1_9_uid191_vecRotateTest_b_1_q(36 downto 9));

    -- yip1E_10_uid204_vecRotateTest(ADDSUB,203)@11
    yip1E_10_uid204_vecRotateTest_s <= signOfSelectionSignal_uid196_vecRotateTest_q;
    yip1E_10_uid204_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist34_yip1_9_uid192_vecRotateTest_b_1_q(36)) & redist34_yip1_9_uid192_vecRotateTest_b_1_q));
    yip1E_10_uid204_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 28 => twoToMiSiXip_uid199_vecRotateTest_b(27)) & twoToMiSiXip_uid199_vecRotateTest_b));
    yip1E_10_uid204_vecRotateTest_combproc: PROCESS (yip1E_10_uid204_vecRotateTest_a, yip1E_10_uid204_vecRotateTest_b, yip1E_10_uid204_vecRotateTest_s)
    BEGIN
        IF (yip1E_10_uid204_vecRotateTest_s = "1") THEN
            yip1E_10_uid204_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_10_uid204_vecRotateTest_a) + SIGNED(yip1E_10_uid204_vecRotateTest_b));
        ELSE
            yip1E_10_uid204_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_10_uid204_vecRotateTest_a) - SIGNED(yip1E_10_uid204_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_10_uid204_vecRotateTest_q <= yip1E_10_uid204_vecRotateTest_o(37 downto 0);

    -- yip1_10_uid211_vecRotateTest(BITSELECT,210)@11
    yip1_10_uid211_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_10_uid204_vecRotateTest_q(36 downto 0));
    yip1_10_uid211_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_10_uid211_vecRotateTest_in(36 downto 0));

    -- redist31_yip1_10_uid211_vecRotateTest_b_1(DELAY,428)
    redist31_yip1_10_uid211_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_10_uid211_vecRotateTest_b, xout => redist31_yip1_10_uid211_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_11_uid223_vecRotateTest(ADDSUB,222)@12
    yip1E_11_uid223_vecRotateTest_s <= signOfSelectionSignal_uid215_vecRotateTest_q;
    yip1E_11_uid223_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist31_yip1_10_uid211_vecRotateTest_b_1_q(36)) & redist31_yip1_10_uid211_vecRotateTest_b_1_q));
    yip1E_11_uid223_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 27 => twoToMiSiXip_uid218_vecRotateTest_b(26)) & twoToMiSiXip_uid218_vecRotateTest_b));
    yip1E_11_uid223_vecRotateTest_combproc: PROCESS (yip1E_11_uid223_vecRotateTest_a, yip1E_11_uid223_vecRotateTest_b, yip1E_11_uid223_vecRotateTest_s)
    BEGIN
        IF (yip1E_11_uid223_vecRotateTest_s = "1") THEN
            yip1E_11_uid223_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_11_uid223_vecRotateTest_a) + SIGNED(yip1E_11_uid223_vecRotateTest_b));
        ELSE
            yip1E_11_uid223_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_11_uid223_vecRotateTest_a) - SIGNED(yip1E_11_uid223_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_11_uid223_vecRotateTest_q <= yip1E_11_uid223_vecRotateTest_o(37 downto 0);

    -- yip1_11_uid230_vecRotateTest(BITSELECT,229)@12
    yip1_11_uid230_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_11_uid223_vecRotateTest_q(36 downto 0));
    yip1_11_uid230_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_11_uid230_vecRotateTest_in(36 downto 0));

    -- redist28_yip1_11_uid230_vecRotateTest_b_1(DELAY,425)
    redist28_yip1_11_uid230_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_11_uid230_vecRotateTest_b, xout => redist28_yip1_11_uid230_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid238_vecRotateTest(BITSELECT,237)@13
    twoToMiSiYip_uid238_vecRotateTest_b <= STD_LOGIC_VECTOR(redist28_yip1_11_uid230_vecRotateTest_b_1_q(36 downto 11));

    -- twoToMiSiYip_uid219_vecRotateTest(BITSELECT,218)@12
    twoToMiSiYip_uid219_vecRotateTest_b <= STD_LOGIC_VECTOR(redist31_yip1_10_uid211_vecRotateTest_b_1_q(36 downto 10));

    -- xip1E_11_uid222_vecRotateTest(ADDSUB,221)@12
    xip1E_11_uid222_vecRotateTest_s <= xMSB_uid213_vecRotateTest_b;
    xip1E_11_uid222_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist32_xip1_10_uid210_vecRotateTest_b_1_q(36)) & redist32_xip1_10_uid210_vecRotateTest_b_1_q));
    xip1E_11_uid222_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 27 => twoToMiSiYip_uid219_vecRotateTest_b(26)) & twoToMiSiYip_uid219_vecRotateTest_b));
    xip1E_11_uid222_vecRotateTest_combproc: PROCESS (xip1E_11_uid222_vecRotateTest_a, xip1E_11_uid222_vecRotateTest_b, xip1E_11_uid222_vecRotateTest_s)
    BEGIN
        IF (xip1E_11_uid222_vecRotateTest_s = "1") THEN
            xip1E_11_uid222_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_11_uid222_vecRotateTest_a) + SIGNED(xip1E_11_uid222_vecRotateTest_b));
        ELSE
            xip1E_11_uid222_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_11_uid222_vecRotateTest_a) - SIGNED(xip1E_11_uid222_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_11_uid222_vecRotateTest_q <= xip1E_11_uid222_vecRotateTest_o(37 downto 0);

    -- xip1_11_uid229_vecRotateTest(BITSELECT,228)@12
    xip1_11_uid229_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_11_uid222_vecRotateTest_q(36 downto 0));
    xip1_11_uid229_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_11_uid229_vecRotateTest_in(36 downto 0));

    -- redist29_xip1_11_uid229_vecRotateTest_b_1(DELAY,426)
    redist29_xip1_11_uid229_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_11_uid229_vecRotateTest_b, xout => redist29_xip1_11_uid229_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_12_uid241_vecRotateTest(ADDSUB,240)@13
    xip1E_12_uid241_vecRotateTest_s <= xMSB_uid232_vecRotateTest_b;
    xip1E_12_uid241_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist29_xip1_11_uid229_vecRotateTest_b_1_q(36)) & redist29_xip1_11_uid229_vecRotateTest_b_1_q));
    xip1E_12_uid241_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 26 => twoToMiSiYip_uid238_vecRotateTest_b(25)) & twoToMiSiYip_uid238_vecRotateTest_b));
    xip1E_12_uid241_vecRotateTest_combproc: PROCESS (xip1E_12_uid241_vecRotateTest_a, xip1E_12_uid241_vecRotateTest_b, xip1E_12_uid241_vecRotateTest_s)
    BEGIN
        IF (xip1E_12_uid241_vecRotateTest_s = "1") THEN
            xip1E_12_uid241_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_12_uid241_vecRotateTest_a) + SIGNED(xip1E_12_uid241_vecRotateTest_b));
        ELSE
            xip1E_12_uid241_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_12_uid241_vecRotateTest_a) - SIGNED(xip1E_12_uid241_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_12_uid241_vecRotateTest_q <= xip1E_12_uid241_vecRotateTest_o(37 downto 0);

    -- xip1_12_uid248_vecRotateTest(BITSELECT,247)@13
    xip1_12_uid248_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_12_uid241_vecRotateTest_q(36 downto 0));
    xip1_12_uid248_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_12_uid248_vecRotateTest_in(36 downto 0));

    -- redist26_xip1_12_uid248_vecRotateTest_b_1(DELAY,423)
    redist26_xip1_12_uid248_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_12_uid248_vecRotateTest_b, xout => redist26_xip1_12_uid248_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid256_vecRotateTest(BITSELECT,255)@14
    twoToMiSiXip_uid256_vecRotateTest_b <= STD_LOGIC_VECTOR(redist26_xip1_12_uid248_vecRotateTest_b_1_q(36 downto 12));

    -- signOfSelectionSignal_uid234_vecRotateTest(LOGICAL,233)@13
    signOfSelectionSignal_uid234_vecRotateTest_q <= not (xMSB_uid232_vecRotateTest_b);

    -- twoToMiSiXip_uid237_vecRotateTest(BITSELECT,236)@13
    twoToMiSiXip_uid237_vecRotateTest_b <= STD_LOGIC_VECTOR(redist29_xip1_11_uid229_vecRotateTest_b_1_q(36 downto 11));

    -- yip1E_12_uid242_vecRotateTest(ADDSUB,241)@13
    yip1E_12_uid242_vecRotateTest_s <= signOfSelectionSignal_uid234_vecRotateTest_q;
    yip1E_12_uid242_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist28_yip1_11_uid230_vecRotateTest_b_1_q(36)) & redist28_yip1_11_uid230_vecRotateTest_b_1_q));
    yip1E_12_uid242_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 26 => twoToMiSiXip_uid237_vecRotateTest_b(25)) & twoToMiSiXip_uid237_vecRotateTest_b));
    yip1E_12_uid242_vecRotateTest_combproc: PROCESS (yip1E_12_uid242_vecRotateTest_a, yip1E_12_uid242_vecRotateTest_b, yip1E_12_uid242_vecRotateTest_s)
    BEGIN
        IF (yip1E_12_uid242_vecRotateTest_s = "1") THEN
            yip1E_12_uid242_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_12_uid242_vecRotateTest_a) + SIGNED(yip1E_12_uid242_vecRotateTest_b));
        ELSE
            yip1E_12_uid242_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_12_uid242_vecRotateTest_a) - SIGNED(yip1E_12_uid242_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_12_uid242_vecRotateTest_q <= yip1E_12_uid242_vecRotateTest_o(37 downto 0);

    -- yip1_12_uid249_vecRotateTest(BITSELECT,248)@13
    yip1_12_uid249_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_12_uid242_vecRotateTest_q(36 downto 0));
    yip1_12_uid249_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_12_uid249_vecRotateTest_in(36 downto 0));

    -- redist25_yip1_12_uid249_vecRotateTest_b_1(DELAY,422)
    redist25_yip1_12_uid249_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_12_uid249_vecRotateTest_b, xout => redist25_yip1_12_uid249_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_13_uid261_vecRotateTest(ADDSUB,260)@14
    yip1E_13_uid261_vecRotateTest_s <= signOfSelectionSignal_uid253_vecRotateTest_q;
    yip1E_13_uid261_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist25_yip1_12_uid249_vecRotateTest_b_1_q(36)) & redist25_yip1_12_uid249_vecRotateTest_b_1_q));
    yip1E_13_uid261_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 25 => twoToMiSiXip_uid256_vecRotateTest_b(24)) & twoToMiSiXip_uid256_vecRotateTest_b));
    yip1E_13_uid261_vecRotateTest_combproc: PROCESS (yip1E_13_uid261_vecRotateTest_a, yip1E_13_uid261_vecRotateTest_b, yip1E_13_uid261_vecRotateTest_s)
    BEGIN
        IF (yip1E_13_uid261_vecRotateTest_s = "1") THEN
            yip1E_13_uid261_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_13_uid261_vecRotateTest_a) + SIGNED(yip1E_13_uid261_vecRotateTest_b));
        ELSE
            yip1E_13_uid261_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_13_uid261_vecRotateTest_a) - SIGNED(yip1E_13_uid261_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_13_uid261_vecRotateTest_q <= yip1E_13_uid261_vecRotateTest_o(37 downto 0);

    -- yip1_13_uid268_vecRotateTest(BITSELECT,267)@14
    yip1_13_uid268_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_13_uid261_vecRotateTest_q(36 downto 0));
    yip1_13_uid268_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_13_uid268_vecRotateTest_in(36 downto 0));

    -- redist22_yip1_13_uid268_vecRotateTest_b_1(DELAY,419)
    redist22_yip1_13_uid268_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_13_uid268_vecRotateTest_b, xout => redist22_yip1_13_uid268_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid276_vecRotateTest(BITSELECT,275)@15
    twoToMiSiYip_uid276_vecRotateTest_b <= STD_LOGIC_VECTOR(redist22_yip1_13_uid268_vecRotateTest_b_1_q(36 downto 13));

    -- twoToMiSiYip_uid257_vecRotateTest(BITSELECT,256)@14
    twoToMiSiYip_uid257_vecRotateTest_b <= STD_LOGIC_VECTOR(redist25_yip1_12_uid249_vecRotateTest_b_1_q(36 downto 12));

    -- xip1E_13_uid260_vecRotateTest(ADDSUB,259)@14
    xip1E_13_uid260_vecRotateTest_s <= xMSB_uid251_vecRotateTest_b;
    xip1E_13_uid260_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist26_xip1_12_uid248_vecRotateTest_b_1_q(36)) & redist26_xip1_12_uid248_vecRotateTest_b_1_q));
    xip1E_13_uid260_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 25 => twoToMiSiYip_uid257_vecRotateTest_b(24)) & twoToMiSiYip_uid257_vecRotateTest_b));
    xip1E_13_uid260_vecRotateTest_combproc: PROCESS (xip1E_13_uid260_vecRotateTest_a, xip1E_13_uid260_vecRotateTest_b, xip1E_13_uid260_vecRotateTest_s)
    BEGIN
        IF (xip1E_13_uid260_vecRotateTest_s = "1") THEN
            xip1E_13_uid260_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_13_uid260_vecRotateTest_a) + SIGNED(xip1E_13_uid260_vecRotateTest_b));
        ELSE
            xip1E_13_uid260_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_13_uid260_vecRotateTest_a) - SIGNED(xip1E_13_uid260_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_13_uid260_vecRotateTest_q <= xip1E_13_uid260_vecRotateTest_o(37 downto 0);

    -- xip1_13_uid267_vecRotateTest(BITSELECT,266)@14
    xip1_13_uid267_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_13_uid260_vecRotateTest_q(36 downto 0));
    xip1_13_uid267_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_13_uid267_vecRotateTest_in(36 downto 0));

    -- redist23_xip1_13_uid267_vecRotateTest_b_1(DELAY,420)
    redist23_xip1_13_uid267_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_13_uid267_vecRotateTest_b, xout => redist23_xip1_13_uid267_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_14_uid279_vecRotateTest(ADDSUB,278)@15
    xip1E_14_uid279_vecRotateTest_s <= xMSB_uid270_vecRotateTest_b;
    xip1E_14_uid279_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist23_xip1_13_uid267_vecRotateTest_b_1_q(36)) & redist23_xip1_13_uid267_vecRotateTest_b_1_q));
    xip1E_14_uid279_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 24 => twoToMiSiYip_uid276_vecRotateTest_b(23)) & twoToMiSiYip_uid276_vecRotateTest_b));
    xip1E_14_uid279_vecRotateTest_combproc: PROCESS (xip1E_14_uid279_vecRotateTest_a, xip1E_14_uid279_vecRotateTest_b, xip1E_14_uid279_vecRotateTest_s)
    BEGIN
        IF (xip1E_14_uid279_vecRotateTest_s = "1") THEN
            xip1E_14_uid279_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_14_uid279_vecRotateTest_a) + SIGNED(xip1E_14_uid279_vecRotateTest_b));
        ELSE
            xip1E_14_uid279_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_14_uid279_vecRotateTest_a) - SIGNED(xip1E_14_uid279_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_14_uid279_vecRotateTest_q <= xip1E_14_uid279_vecRotateTest_o(37 downto 0);

    -- xip1_14_uid286_vecRotateTest(BITSELECT,285)@15
    xip1_14_uid286_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_14_uid279_vecRotateTest_q(36 downto 0));
    xip1_14_uid286_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_14_uid286_vecRotateTest_in(36 downto 0));

    -- redist20_xip1_14_uid286_vecRotateTest_b_1(DELAY,417)
    redist20_xip1_14_uid286_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_14_uid286_vecRotateTest_b, xout => redist20_xip1_14_uid286_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid294_vecRotateTest(BITSELECT,293)@16
    twoToMiSiXip_uid294_vecRotateTest_b <= STD_LOGIC_VECTOR(redist20_xip1_14_uid286_vecRotateTest_b_1_q(36 downto 14));

    -- signOfSelectionSignal_uid272_vecRotateTest(LOGICAL,271)@15
    signOfSelectionSignal_uid272_vecRotateTest_q <= not (xMSB_uid270_vecRotateTest_b);

    -- twoToMiSiXip_uid275_vecRotateTest(BITSELECT,274)@15
    twoToMiSiXip_uid275_vecRotateTest_b <= STD_LOGIC_VECTOR(redist23_xip1_13_uid267_vecRotateTest_b_1_q(36 downto 13));

    -- yip1E_14_uid280_vecRotateTest(ADDSUB,279)@15
    yip1E_14_uid280_vecRotateTest_s <= signOfSelectionSignal_uid272_vecRotateTest_q;
    yip1E_14_uid280_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist22_yip1_13_uid268_vecRotateTest_b_1_q(36)) & redist22_yip1_13_uid268_vecRotateTest_b_1_q));
    yip1E_14_uid280_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 24 => twoToMiSiXip_uid275_vecRotateTest_b(23)) & twoToMiSiXip_uid275_vecRotateTest_b));
    yip1E_14_uid280_vecRotateTest_combproc: PROCESS (yip1E_14_uid280_vecRotateTest_a, yip1E_14_uid280_vecRotateTest_b, yip1E_14_uid280_vecRotateTest_s)
    BEGIN
        IF (yip1E_14_uid280_vecRotateTest_s = "1") THEN
            yip1E_14_uid280_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_14_uid280_vecRotateTest_a) + SIGNED(yip1E_14_uid280_vecRotateTest_b));
        ELSE
            yip1E_14_uid280_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_14_uid280_vecRotateTest_a) - SIGNED(yip1E_14_uid280_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_14_uid280_vecRotateTest_q <= yip1E_14_uid280_vecRotateTest_o(37 downto 0);

    -- yip1_14_uid287_vecRotateTest(BITSELECT,286)@15
    yip1_14_uid287_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_14_uid280_vecRotateTest_q(36 downto 0));
    yip1_14_uid287_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_14_uid287_vecRotateTest_in(36 downto 0));

    -- redist19_yip1_14_uid287_vecRotateTest_b_1(DELAY,416)
    redist19_yip1_14_uid287_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_14_uid287_vecRotateTest_b, xout => redist19_yip1_14_uid287_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_15_uid299_vecRotateTest(ADDSUB,298)@16
    yip1E_15_uid299_vecRotateTest_s <= signOfSelectionSignal_uid291_vecRotateTest_q;
    yip1E_15_uid299_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist19_yip1_14_uid287_vecRotateTest_b_1_q(36)) & redist19_yip1_14_uid287_vecRotateTest_b_1_q));
    yip1E_15_uid299_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 23 => twoToMiSiXip_uid294_vecRotateTest_b(22)) & twoToMiSiXip_uid294_vecRotateTest_b));
    yip1E_15_uid299_vecRotateTest_combproc: PROCESS (yip1E_15_uid299_vecRotateTest_a, yip1E_15_uid299_vecRotateTest_b, yip1E_15_uid299_vecRotateTest_s)
    BEGIN
        IF (yip1E_15_uid299_vecRotateTest_s = "1") THEN
            yip1E_15_uid299_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_15_uid299_vecRotateTest_a) + SIGNED(yip1E_15_uid299_vecRotateTest_b));
        ELSE
            yip1E_15_uid299_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_15_uid299_vecRotateTest_a) - SIGNED(yip1E_15_uid299_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_15_uid299_vecRotateTest_q <= yip1E_15_uid299_vecRotateTest_o(37 downto 0);

    -- yip1_15_uid306_vecRotateTest(BITSELECT,305)@16
    yip1_15_uid306_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_15_uid299_vecRotateTest_q(36 downto 0));
    yip1_15_uid306_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_15_uid306_vecRotateTest_in(36 downto 0));

    -- redist16_yip1_15_uid306_vecRotateTest_b_1(DELAY,413)
    redist16_yip1_15_uid306_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_15_uid306_vecRotateTest_b, xout => redist16_yip1_15_uid306_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid314_vecRotateTest(BITSELECT,313)@17
    twoToMiSiYip_uid314_vecRotateTest_b <= STD_LOGIC_VECTOR(redist16_yip1_15_uid306_vecRotateTest_b_1_q(36 downto 15));

    -- twoToMiSiYip_uid295_vecRotateTest(BITSELECT,294)@16
    twoToMiSiYip_uid295_vecRotateTest_b <= STD_LOGIC_VECTOR(redist19_yip1_14_uid287_vecRotateTest_b_1_q(36 downto 14));

    -- xip1E_15_uid298_vecRotateTest(ADDSUB,297)@16
    xip1E_15_uid298_vecRotateTest_s <= xMSB_uid289_vecRotateTest_b;
    xip1E_15_uid298_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist20_xip1_14_uid286_vecRotateTest_b_1_q(36)) & redist20_xip1_14_uid286_vecRotateTest_b_1_q));
    xip1E_15_uid298_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 23 => twoToMiSiYip_uid295_vecRotateTest_b(22)) & twoToMiSiYip_uid295_vecRotateTest_b));
    xip1E_15_uid298_vecRotateTest_combproc: PROCESS (xip1E_15_uid298_vecRotateTest_a, xip1E_15_uid298_vecRotateTest_b, xip1E_15_uid298_vecRotateTest_s)
    BEGIN
        IF (xip1E_15_uid298_vecRotateTest_s = "1") THEN
            xip1E_15_uid298_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_15_uid298_vecRotateTest_a) + SIGNED(xip1E_15_uid298_vecRotateTest_b));
        ELSE
            xip1E_15_uid298_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_15_uid298_vecRotateTest_a) - SIGNED(xip1E_15_uid298_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_15_uid298_vecRotateTest_q <= xip1E_15_uid298_vecRotateTest_o(37 downto 0);

    -- xip1_15_uid305_vecRotateTest(BITSELECT,304)@16
    xip1_15_uid305_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_15_uid298_vecRotateTest_q(36 downto 0));
    xip1_15_uid305_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_15_uid305_vecRotateTest_in(36 downto 0));

    -- redist17_xip1_15_uid305_vecRotateTest_b_1(DELAY,414)
    redist17_xip1_15_uid305_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_15_uid305_vecRotateTest_b, xout => redist17_xip1_15_uid305_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_16_uid317_vecRotateTest(ADDSUB,316)@17
    xip1E_16_uid317_vecRotateTest_s <= xMSB_uid308_vecRotateTest_b;
    xip1E_16_uid317_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist17_xip1_15_uid305_vecRotateTest_b_1_q(36)) & redist17_xip1_15_uid305_vecRotateTest_b_1_q));
    xip1E_16_uid317_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 22 => twoToMiSiYip_uid314_vecRotateTest_b(21)) & twoToMiSiYip_uid314_vecRotateTest_b));
    xip1E_16_uid317_vecRotateTest_combproc: PROCESS (xip1E_16_uid317_vecRotateTest_a, xip1E_16_uid317_vecRotateTest_b, xip1E_16_uid317_vecRotateTest_s)
    BEGIN
        IF (xip1E_16_uid317_vecRotateTest_s = "1") THEN
            xip1E_16_uid317_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_16_uid317_vecRotateTest_a) + SIGNED(xip1E_16_uid317_vecRotateTest_b));
        ELSE
            xip1E_16_uid317_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_16_uid317_vecRotateTest_a) - SIGNED(xip1E_16_uid317_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_16_uid317_vecRotateTest_q <= xip1E_16_uid317_vecRotateTest_o(37 downto 0);

    -- xip1_16_uid324_vecRotateTest(BITSELECT,323)@17
    xip1_16_uid324_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_16_uid317_vecRotateTest_q(36 downto 0));
    xip1_16_uid324_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_16_uid324_vecRotateTest_in(36 downto 0));

    -- redist14_xip1_16_uid324_vecRotateTest_b_1(DELAY,411)
    redist14_xip1_16_uid324_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_16_uid324_vecRotateTest_b, xout => redist14_xip1_16_uid324_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid332_vecRotateTest(BITSELECT,331)@18
    twoToMiSiXip_uid332_vecRotateTest_b <= STD_LOGIC_VECTOR(redist14_xip1_16_uid324_vecRotateTest_b_1_q(36 downto 16));

    -- signOfSelectionSignal_uid310_vecRotateTest(LOGICAL,309)@17
    signOfSelectionSignal_uid310_vecRotateTest_q <= not (xMSB_uid308_vecRotateTest_b);

    -- twoToMiSiXip_uid313_vecRotateTest(BITSELECT,312)@17
    twoToMiSiXip_uid313_vecRotateTest_b <= STD_LOGIC_VECTOR(redist17_xip1_15_uid305_vecRotateTest_b_1_q(36 downto 15));

    -- yip1E_16_uid318_vecRotateTest(ADDSUB,317)@17
    yip1E_16_uid318_vecRotateTest_s <= signOfSelectionSignal_uid310_vecRotateTest_q;
    yip1E_16_uid318_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist16_yip1_15_uid306_vecRotateTest_b_1_q(36)) & redist16_yip1_15_uid306_vecRotateTest_b_1_q));
    yip1E_16_uid318_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 22 => twoToMiSiXip_uid313_vecRotateTest_b(21)) & twoToMiSiXip_uid313_vecRotateTest_b));
    yip1E_16_uid318_vecRotateTest_combproc: PROCESS (yip1E_16_uid318_vecRotateTest_a, yip1E_16_uid318_vecRotateTest_b, yip1E_16_uid318_vecRotateTest_s)
    BEGIN
        IF (yip1E_16_uid318_vecRotateTest_s = "1") THEN
            yip1E_16_uid318_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_16_uid318_vecRotateTest_a) + SIGNED(yip1E_16_uid318_vecRotateTest_b));
        ELSE
            yip1E_16_uid318_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_16_uid318_vecRotateTest_a) - SIGNED(yip1E_16_uid318_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_16_uid318_vecRotateTest_q <= yip1E_16_uid318_vecRotateTest_o(37 downto 0);

    -- yip1_16_uid325_vecRotateTest(BITSELECT,324)@17
    yip1_16_uid325_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_16_uid318_vecRotateTest_q(36 downto 0));
    yip1_16_uid325_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_16_uid325_vecRotateTest_in(36 downto 0));

    -- redist13_yip1_16_uid325_vecRotateTest_b_1(DELAY,410)
    redist13_yip1_16_uid325_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_16_uid325_vecRotateTest_b, xout => redist13_yip1_16_uid325_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_17_uid337_vecRotateTest(ADDSUB,336)@18
    yip1E_17_uid337_vecRotateTest_s <= signOfSelectionSignal_uid329_vecRotateTest_q;
    yip1E_17_uid337_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist13_yip1_16_uid325_vecRotateTest_b_1_q(36)) & redist13_yip1_16_uid325_vecRotateTest_b_1_q));
    yip1E_17_uid337_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 21 => twoToMiSiXip_uid332_vecRotateTest_b(20)) & twoToMiSiXip_uid332_vecRotateTest_b));
    yip1E_17_uid337_vecRotateTest_combproc: PROCESS (yip1E_17_uid337_vecRotateTest_a, yip1E_17_uid337_vecRotateTest_b, yip1E_17_uid337_vecRotateTest_s)
    BEGIN
        IF (yip1E_17_uid337_vecRotateTest_s = "1") THEN
            yip1E_17_uid337_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_17_uid337_vecRotateTest_a) + SIGNED(yip1E_17_uid337_vecRotateTest_b));
        ELSE
            yip1E_17_uid337_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_17_uid337_vecRotateTest_a) - SIGNED(yip1E_17_uid337_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_17_uid337_vecRotateTest_q <= yip1E_17_uid337_vecRotateTest_o(37 downto 0);

    -- yip1_17_uid344_vecRotateTest(BITSELECT,343)@18
    yip1_17_uid344_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_17_uid337_vecRotateTest_q(36 downto 0));
    yip1_17_uid344_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_17_uid344_vecRotateTest_in(36 downto 0));

    -- redist10_yip1_17_uid344_vecRotateTest_b_1(DELAY,407)
    redist10_yip1_17_uid344_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_17_uid344_vecRotateTest_b, xout => redist10_yip1_17_uid344_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiYip_uid352_vecRotateTest(BITSELECT,351)@19
    twoToMiSiYip_uid352_vecRotateTest_b <= STD_LOGIC_VECTOR(redist10_yip1_17_uid344_vecRotateTest_b_1_q(36 downto 17));

    -- twoToMiSiYip_uid333_vecRotateTest(BITSELECT,332)@18
    twoToMiSiYip_uid333_vecRotateTest_b <= STD_LOGIC_VECTOR(redist13_yip1_16_uid325_vecRotateTest_b_1_q(36 downto 16));

    -- xip1E_17_uid336_vecRotateTest(ADDSUB,335)@18
    xip1E_17_uid336_vecRotateTest_s <= xMSB_uid327_vecRotateTest_b;
    xip1E_17_uid336_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist14_xip1_16_uid324_vecRotateTest_b_1_q(36)) & redist14_xip1_16_uid324_vecRotateTest_b_1_q));
    xip1E_17_uid336_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 21 => twoToMiSiYip_uid333_vecRotateTest_b(20)) & twoToMiSiYip_uid333_vecRotateTest_b));
    xip1E_17_uid336_vecRotateTest_combproc: PROCESS (xip1E_17_uid336_vecRotateTest_a, xip1E_17_uid336_vecRotateTest_b, xip1E_17_uid336_vecRotateTest_s)
    BEGIN
        IF (xip1E_17_uid336_vecRotateTest_s = "1") THEN
            xip1E_17_uid336_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_17_uid336_vecRotateTest_a) + SIGNED(xip1E_17_uid336_vecRotateTest_b));
        ELSE
            xip1E_17_uid336_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_17_uid336_vecRotateTest_a) - SIGNED(xip1E_17_uid336_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_17_uid336_vecRotateTest_q <= xip1E_17_uid336_vecRotateTest_o(37 downto 0);

    -- xip1_17_uid343_vecRotateTest(BITSELECT,342)@18
    xip1_17_uid343_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_17_uid336_vecRotateTest_q(36 downto 0));
    xip1_17_uid343_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_17_uid343_vecRotateTest_in(36 downto 0));

    -- redist11_xip1_17_uid343_vecRotateTest_b_1(DELAY,408)
    redist11_xip1_17_uid343_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_17_uid343_vecRotateTest_b, xout => redist11_xip1_17_uid343_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xip1E_18_uid355_vecRotateTest(ADDSUB,354)@19
    xip1E_18_uid355_vecRotateTest_s <= xMSB_uid346_vecRotateTest_b;
    xip1E_18_uid355_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist11_xip1_17_uid343_vecRotateTest_b_1_q(36)) & redist11_xip1_17_uid343_vecRotateTest_b_1_q));
    xip1E_18_uid355_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 20 => twoToMiSiYip_uid352_vecRotateTest_b(19)) & twoToMiSiYip_uid352_vecRotateTest_b));
    xip1E_18_uid355_vecRotateTest_combproc: PROCESS (xip1E_18_uid355_vecRotateTest_a, xip1E_18_uid355_vecRotateTest_b, xip1E_18_uid355_vecRotateTest_s)
    BEGIN
        IF (xip1E_18_uid355_vecRotateTest_s = "1") THEN
            xip1E_18_uid355_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_18_uid355_vecRotateTest_a) + SIGNED(xip1E_18_uid355_vecRotateTest_b));
        ELSE
            xip1E_18_uid355_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_18_uid355_vecRotateTest_a) - SIGNED(xip1E_18_uid355_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_18_uid355_vecRotateTest_q <= xip1E_18_uid355_vecRotateTest_o(37 downto 0);

    -- xip1_18_uid362_vecRotateTest(BITSELECT,361)@19
    xip1_18_uid362_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_18_uid355_vecRotateTest_q(36 downto 0));
    xip1_18_uid362_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_18_uid362_vecRotateTest_in(36 downto 0));

    -- redist8_xip1_18_uid362_vecRotateTest_b_1(DELAY,405)
    redist8_xip1_18_uid362_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xip1_18_uid362_vecRotateTest_b, xout => redist8_xip1_18_uid362_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- twoToMiSiXip_uid370_vecRotateTest(BITSELECT,369)@20
    twoToMiSiXip_uid370_vecRotateTest_b <= STD_LOGIC_VECTOR(redist8_xip1_18_uid362_vecRotateTest_b_1_q(36 downto 18));

    -- signOfSelectionSignal_uid348_vecRotateTest(LOGICAL,347)@19
    signOfSelectionSignal_uid348_vecRotateTest_q <= not (xMSB_uid346_vecRotateTest_b);

    -- twoToMiSiXip_uid351_vecRotateTest(BITSELECT,350)@19
    twoToMiSiXip_uid351_vecRotateTest_b <= STD_LOGIC_VECTOR(redist11_xip1_17_uid343_vecRotateTest_b_1_q(36 downto 17));

    -- yip1E_18_uid356_vecRotateTest(ADDSUB,355)@19
    yip1E_18_uid356_vecRotateTest_s <= signOfSelectionSignal_uid348_vecRotateTest_q;
    yip1E_18_uid356_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist10_yip1_17_uid344_vecRotateTest_b_1_q(36)) & redist10_yip1_17_uid344_vecRotateTest_b_1_q));
    yip1E_18_uid356_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 20 => twoToMiSiXip_uid351_vecRotateTest_b(19)) & twoToMiSiXip_uid351_vecRotateTest_b));
    yip1E_18_uid356_vecRotateTest_combproc: PROCESS (yip1E_18_uid356_vecRotateTest_a, yip1E_18_uid356_vecRotateTest_b, yip1E_18_uid356_vecRotateTest_s)
    BEGIN
        IF (yip1E_18_uid356_vecRotateTest_s = "1") THEN
            yip1E_18_uid356_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_18_uid356_vecRotateTest_a) + SIGNED(yip1E_18_uid356_vecRotateTest_b));
        ELSE
            yip1E_18_uid356_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_18_uid356_vecRotateTest_a) - SIGNED(yip1E_18_uid356_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_18_uid356_vecRotateTest_q <= yip1E_18_uid356_vecRotateTest_o(37 downto 0);

    -- yip1_18_uid363_vecRotateTest(BITSELECT,362)@19
    yip1_18_uid363_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_18_uid356_vecRotateTest_q(36 downto 0));
    yip1_18_uid363_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_18_uid363_vecRotateTest_in(36 downto 0));

    -- redist7_yip1_18_uid363_vecRotateTest_b_1(DELAY,404)
    redist7_yip1_18_uid363_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 37, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => yip1_18_uid363_vecRotateTest_b, xout => redist7_yip1_18_uid363_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- yip1E_19_uid375_vecRotateTest(ADDSUB,374)@20
    yip1E_19_uid375_vecRotateTest_s <= signOfSelectionSignal_uid367_vecRotateTest_q;
    yip1E_19_uid375_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist7_yip1_18_uid363_vecRotateTest_b_1_q(36)) & redist7_yip1_18_uid363_vecRotateTest_b_1_q));
    yip1E_19_uid375_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 19 => twoToMiSiXip_uid370_vecRotateTest_b(18)) & twoToMiSiXip_uid370_vecRotateTest_b));
    yip1E_19_uid375_vecRotateTest_combproc: PROCESS (yip1E_19_uid375_vecRotateTest_a, yip1E_19_uid375_vecRotateTest_b, yip1E_19_uid375_vecRotateTest_s)
    BEGIN
        IF (yip1E_19_uid375_vecRotateTest_s = "1") THEN
            yip1E_19_uid375_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_19_uid375_vecRotateTest_a) + SIGNED(yip1E_19_uid375_vecRotateTest_b));
        ELSE
            yip1E_19_uid375_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(yip1E_19_uid375_vecRotateTest_a) - SIGNED(yip1E_19_uid375_vecRotateTest_b));
        END IF;
    END PROCESS;
    yip1E_19_uid375_vecRotateTest_q <= yip1E_19_uid375_vecRotateTest_o(37 downto 0);

    -- yip1_19_uid382_vecRotateTest(BITSELECT,381)@20
    yip1_19_uid382_vecRotateTest_in <= STD_LOGIC_VECTOR(yip1E_19_uid375_vecRotateTest_q(36 downto 0));
    yip1_19_uid382_vecRotateTest_b <= STD_LOGIC_VECTOR(yip1_19_uid382_vecRotateTest_in(36 downto 0));

    -- ySumPreRnd_uid388_vecRotateTest(BITSELECT,387)@20
    ySumPreRnd_uid388_vecRotateTest_b <= yip1_19_uid382_vecRotateTest_b(36 downto 18);

    -- redist4_ySumPreRnd_uid388_vecRotateTest_b_1(DELAY,401)
    redist4_ySumPreRnd_uid388_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 19, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => ySumPreRnd_uid388_vecRotateTest_b, xout => redist4_ySumPreRnd_uid388_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- ySumPostRnd_uid391_vecRotateTest(ADD,390)@21
    ySumPostRnd_uid391_vecRotateTest_a <= STD_LOGIC_VECTOR("0" & redist4_ySumPreRnd_uid388_vecRotateTest_b_1_q);
    ySumPostRnd_uid391_vecRotateTest_b <= STD_LOGIC_VECTOR("0000000000000000000" & VCC_q);
    ySumPostRnd_uid391_vecRotateTest_o <= STD_LOGIC_VECTOR(UNSIGNED(ySumPostRnd_uid391_vecRotateTest_a) + UNSIGNED(ySumPostRnd_uid391_vecRotateTest_b));
    ySumPostRnd_uid391_vecRotateTest_q <= ySumPostRnd_uid391_vecRotateTest_o(19 downto 0);

    -- yPostExc_uid393_vecRotateTest(BITSELECT,392)@21
    yPostExc_uid393_vecRotateTest_in <= STD_LOGIC_VECTOR(ySumPostRnd_uid391_vecRotateTest_q(18 downto 0));
    yPostExc_uid393_vecRotateTest_b <= STD_LOGIC_VECTOR(yPostExc_uid393_vecRotateTest_in(18 downto 1));

    -- twoToMiSiYip_uid371_vecRotateTest(BITSELECT,370)@20
    twoToMiSiYip_uid371_vecRotateTest_b <= STD_LOGIC_VECTOR(redist7_yip1_18_uid363_vecRotateTest_b_1_q(36 downto 18));

    -- xip1E_19_uid374_vecRotateTest(ADDSUB,373)@20
    xip1E_19_uid374_vecRotateTest_s <= redist6_xMSB_uid365_vecRotateTest_b_1_q;
    xip1E_19_uid374_vecRotateTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 37 => redist8_xip1_18_uid362_vecRotateTest_b_1_q(36)) & redist8_xip1_18_uid362_vecRotateTest_b_1_q));
    xip1E_19_uid374_vecRotateTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 19 => twoToMiSiYip_uid371_vecRotateTest_b(18)) & twoToMiSiYip_uid371_vecRotateTest_b));
    xip1E_19_uid374_vecRotateTest_combproc: PROCESS (xip1E_19_uid374_vecRotateTest_a, xip1E_19_uid374_vecRotateTest_b, xip1E_19_uid374_vecRotateTest_s)
    BEGIN
        IF (xip1E_19_uid374_vecRotateTest_s = "1") THEN
            xip1E_19_uid374_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_19_uid374_vecRotateTest_a) + SIGNED(xip1E_19_uid374_vecRotateTest_b));
        ELSE
            xip1E_19_uid374_vecRotateTest_o <= STD_LOGIC_VECTOR(SIGNED(xip1E_19_uid374_vecRotateTest_a) - SIGNED(xip1E_19_uid374_vecRotateTest_b));
        END IF;
    END PROCESS;
    xip1E_19_uid374_vecRotateTest_q <= xip1E_19_uid374_vecRotateTest_o(37 downto 0);

    -- xip1_19_uid381_vecRotateTest(BITSELECT,380)@20
    xip1_19_uid381_vecRotateTest_in <= STD_LOGIC_VECTOR(xip1E_19_uid374_vecRotateTest_q(36 downto 0));
    xip1_19_uid381_vecRotateTest_b <= STD_LOGIC_VECTOR(xip1_19_uid381_vecRotateTest_in(36 downto 0));

    -- xSumPreRnd_uid384_vecRotateTest(BITSELECT,383)@20
    xSumPreRnd_uid384_vecRotateTest_b <= xip1_19_uid381_vecRotateTest_b(36 downto 18);

    -- redist5_xSumPreRnd_uid384_vecRotateTest_b_1(DELAY,402)
    redist5_xSumPreRnd_uid384_vecRotateTest_b_1 : dspba_delay
    GENERIC MAP ( width => 19, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => xSumPreRnd_uid384_vecRotateTest_b, xout => redist5_xSumPreRnd_uid384_vecRotateTest_b_1_q, clk => clk, aclr => areset );

    -- xSumPostRnd_uid387_vecRotateTest(ADD,386)@21
    xSumPostRnd_uid387_vecRotateTest_a <= STD_LOGIC_VECTOR("0" & redist5_xSumPreRnd_uid384_vecRotateTest_b_1_q);
    xSumPostRnd_uid387_vecRotateTest_b <= STD_LOGIC_VECTOR("0000000000000000000" & VCC_q);
    xSumPostRnd_uid387_vecRotateTest_o <= STD_LOGIC_VECTOR(UNSIGNED(xSumPostRnd_uid387_vecRotateTest_a) + UNSIGNED(xSumPostRnd_uid387_vecRotateTest_b));
    xSumPostRnd_uid387_vecRotateTest_q <= xSumPostRnd_uid387_vecRotateTest_o(19 downto 0);

    -- xPostExc_uid392_vecRotateTest(BITSELECT,391)@21
    xPostExc_uid392_vecRotateTest_in <= STD_LOGIC_VECTOR(xSumPostRnd_uid387_vecRotateTest_q(18 downto 0));
    xPostExc_uid392_vecRotateTest_b <= STD_LOGIC_VECTOR(xPostExc_uid392_vecRotateTest_in(18 downto 1));

    -- xOut(GPOUT,4)@21
    xo <= xPostExc_uid392_vecRotateTest_b;
    yo <= yPostExc_uid393_vecRotateTest_b;

END normal;
