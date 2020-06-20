--! @file      AAC2M2P1_PKG.vhd
--!
--! @brief     package that defines AAC2M2P1 FSM type and constants
--! @details   Defines FSM_ST_AAC2M2P1
--!
--! @author    Guilherme Shimabuko
--! @author    
--! 
--! @version   1.0
--! @date      2020-03-19
--! 
--! @pre       
--! @pre       
--! @copyright Shima's Digital Hardware
--! 
-------------------------------------------------------------------------------
-- Version History
--
-- Version  Date        Author       Changes
-- 1.0      2020-03-19  GSHIMABUKO   Block Created


--------------------------------------------------------------------------------

-- Libraries ------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;

package AAC2M2P1_PKG is

    -- Types ------------------------------------------------------------------
    
    --! States of FSM_SPEC_MS_DEC at \ref spec_ms_dec.behaviour
    subtype FSM_ST_AAC2M2P1 is std_logic_vector(3 downto 0);    
        constant S0_INIT:   FSM_ST_AAC2M2P1      := "0000";
        constant S1_COUNT:  FSM_ST_AAC2M2P1      := "0001";
        constant S2_COUNT:  FSM_ST_AAC2M2P1      := "0011";
        constant S3_COUNT:  FSM_ST_AAC2M2P1      := "0010";
        constant S4_COUNT:  FSM_ST_AAC2M2P1      := "0110";
        constant S5_COUNT:  FSM_ST_AAC2M2P1      := "0111";
        constant S6_COUNT:  FSM_ST_AAC2M2P1      := "0101";
        constant S7_COUNT:  FSM_ST_AAC2M2P1      := "0100";
        constant S8_COUNT:  FSM_ST_AAC2M2P1      := "1100";
        constant S9_COUNT:  FSM_ST_AAC2M2P1      := "1101";
        constant S10_COUNT: FSM_ST_AAC2M2P1      := "1111";
        constant S11_COUNT: FSM_ST_AAC2M2P1      := "1110";
        constant S12_COUNT: FSM_ST_AAC2M2P1      := "1010";
        constant S13_COUNT: FSM_ST_AAC2M2P1      := "1011";
        constant S14_COUNT: FSM_ST_AAC2M2P1      := "1001";
        constant S15_COUNT: FSM_ST_AAC2M2P1      := "1000";

end package AAC2M2P1_PKG;
package body AAC2M2P1_PKG is
end package body AAC2M2P1_PKG;
