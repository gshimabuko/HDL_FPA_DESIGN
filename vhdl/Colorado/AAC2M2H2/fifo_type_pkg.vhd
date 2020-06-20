-------------------------------------------------------------------------------
--! 
--! @file      fifo_pkg.vhd
--!
--! @brief     Fifo package for a BCH Block in a SDR
--! @details   Package containing constants for a FIFO implementation used in 
--! the BCH error correction block in a DVBS2X decoder
--!
--! @author    Guilherme Shimabuko
--! @author    
--! 
--! @version   2.0
--! @date      2016-08-18
--! @date      2016-10-14
--! 
--! @pre       
-------------------------------------------------------------------------------
--!       COPYRIGHT (C) 2019 AUTOTRAC COMÉRCIO E TELECOMUNICAÇÕES S.A.
--!       All Rights Reserved
--!
--!       All ideas and information disclosed by this document are
--!       confidential and proprietary information of Autotrac S.A. and
--!       all rights therein are expressly reserved.  By accepting this
--!       material recipient agrees that this material and information
--!       will be held in confidence and in trust and will not be used,
--!       copied or reproduced in whole or in part, nor its contents
--!       revealed in any manner to others, except to meet the specific
--!       purpose for which it was delivered.
-------------------------------------------------------------------------------
-- Version History
--
-- Version  Date        Author       Changes
-- 1.0      2016-08-18 GSHIMABUKO    Block Created
-- 2.0      2016-10-14 GSHIMABUKO    State transitions fixed


--------------------------------------------------------------------------------
-- Libraries ------------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use work.fifo_cons_pkg.all;
    
package fifo_type_pkg is
    -- Types ------------------------------------------------------------------
    type FIFO_DATA is array (DEPTH-1 downto 0) of STD_LOGIC_VECTOR(DATA_W-1 downto 0);
    --! States of FIFO_FSM at fifo.behaviour
    subtype ST_FSM_FIFO is std_logic_vector(1 downto 0);
        constant S0_EMPTY:      ST_FSM_FIFO :="00";
        constant S1_RW:     ST_FSM_FIFO :="01";
        constant S2_FULL:      ST_FSM_FIFO :="11";
    component fifo is
    port (
        -- Inputs ---------------------------------------------------
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            data_input : in STD_LOGIC_VECTOR (DATA_W-1 downto 0);
            write_en : in STD_LOGIC;
            read_en : in STD_LOGIC;

        -- Outputs --------------------------------------------------
            data_out : out STD_LOGIC_VECTOR (DATA_W-1 downto 0);
            full : out STD_LOGIC;
            write_ack : out STD_LOGIC;
            empty : out STD_LOGIC
    );
    end component fifo;
        
end package fifo_type_pkg;    
