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

package fsm_pkg is

    -- Types ------------------------------------------------------------------
    
    --! States of FSM_SPEC_MS_DEC at \ref spec_ms_dec.behaviour
    subtype FSM_ST is std_logic_vector(1 downto 0);    
        constant S0_A:  FSM_ST      := "00";
        constant S1_B:  FSM_ST      := "01";
        constant S2_C:  FSM_ST      := "11";
end package fsm_pkg;
package body fsm_pkg is
end package body fsm_pkg;
