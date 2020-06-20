-------------------------------------------------------------------------------
--! 
--! @file      fifo_pkg.vhd
--!
--! @brief     Fifo constants package for a BCH Block in a SDR
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
-- 1.0      2019-09-24 GSHIMABUKO    Block Created
-- 2.0      2016-10-14 GSHIMABUKO    State transitions fixed


--------------------------------------------------------------------------------
-- Libraries ------------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
--    use work.global_constants_pkg.all;
    
package fifo_cons_pkg is
    -- Constants --------------------------------------------------------------
    constant DEPTH: integer;
    constant DATA_W: integer;
    -- Components -------------------------------------------------------------
end package fifo_cons_pkg;

package body fifo_cons_pkg is
    constant DATA_W: integer := 9;
    constant DEPTH: integer := 72;
end package body fifo_cons_pkg;
    
