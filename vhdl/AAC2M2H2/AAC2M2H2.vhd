--------------------------------------------------------------------------------
--! 
--! @file      AAC2M2H2.vhd
--!
--! @brief     Fifo for FPGA Hardware Description Languages Assignment Week 2
--! @details   Fifo implemented using FSM allowing simultaneous Read and Write
--! operations, with dynamic Read and Write Pointers
--!
--! @author    Guilherme Shimabuko
--! @author    
--! 
--! @version   1.0
--! @date      2020-03-22
--! @date      2019-10-01
--! 
--! @pre       
--! @pre       
--! @copyright Shima's Digital Hardware
--! 
-------------------------------------------------------------------------------
-- Version History
--
-- Version  Date        Author       Changes
-- 1.0      2020-03-22 GSHIMABUKO    Block Created

--------------------------------------------------------------------------------
-- Libraries ------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.fifo_cons_pkg.all;
use work.fifo_type_pkg.all;

entity FIFO8x9 is
    port(
        clk:        in std_logic;                               --! Clock Signal
        rst:		in std_logic;                               --! Reset Signal
        RdPtrClr:   in std_logic;                               --! Clear Read Pointer
        WrPtrClr:	in std_logic;                               --! Clear Write Pointer
        RdInc:      in std_logic;                               --! Increment Read Pointer Signal
        WrInc:	    in std_logic;                               --! Increment Write Pointer Signal
        DataIn:	    in std_logic_vector(DATA_W - 1 downto 0);   --! Input Data
        rden:       in std_logic;                               --! Read Enable Signal
        wren:       in std_logic;                               --! Write Enable Signal
        DataOut:    out std_logic_vector(DATA_W - 1 downto 0)  --! Output Data
	);
end entity FIFO8x9;

architecture RTL of FIFO8x9 is
	--signal declarations
    signal s_cstate:    ST_FSM_FIFO;
    signal s_nstate:    ST_FSM_FIFO;

	signal s_fifo:      STD_LOGIC_VECTOR(DEPTH-1 downto 0) := (others => 'Z');
	signal s_wrptr:     integer range 0 to DEPTH;
    signal s_rdptr:     integer range 0 to DEPTH;
    signal s_pointer:   integer range 0 to DEPTH;
	signal en:          std_logic;
	signal dmuxout:     std_logic_vector(8 downto 0);
begin
    WRITE: process (clk, rst)
    begin
        if ((rst = '1') OR (WrPtrClr = '1')) then
            s_wrptr <= 0;
            s_fifo <= (others => 'Z');
        elsif ((wren = '1') AND (WrInc = '1') AND (s_wrptr < DEPTH - DATA_W)) then
                s_wrptr <= s_wrptr + DATA_W;
                s_fifo(s_wrptr + DATA_W - 1 downto s_wrptr) <= DataIn;
        elsif ((wren = '1') AND (WrInc = '1') AND (s_wrptr = DEPTH - DATA_W)) then
                s_wrptr <= 0;
                s_fifo(s_wrptr + DATA_W - 1 downto s_wrptr) <= DataIn;	
		elsif ((wren = '1') AND (WrInc = '0')) then
                s_wrptr <= s_wrptr;
                s_fifo(s_wrptr + DATA_W - 1 downto s_wrptr) <= DataIn;	
        elsif (wren = '0') then
        		s_wrptr <= s_wrptr;
                s_fifo(DATA_W - 1 downto 0) <= (others => 'Z');
        else
		    s_wrptr <= s_wrptr;
		    s_fifo <= s_fifo;
        end if;
    end process WRITE;

    READ: process (clk, rst)
    begin
        if ((rst = '1') OR (RdPtrClr = '1')) then
            DataOut <= (others => 'Z');
            s_rdptr <= 0;				
        elsif ((rden = '1') AND (RdInc = '1') AND (s_rdptr < DEPTH - DATA_W)) then
            s_rdptr <= s_rdptr + DATA_W;
            DataOut <= s_fifo(s_rdptr + DATA_W - 1 downto s_rdptr);
        elsif ((rden = '1') AND (RdInc = '1') AND (s_rdptr = DEPTH - DATA_W)) then
            s_rdptr <= 0;
            DataOut <= s_fifo(s_rdptr + DATA_W - 1 downto s_rdptr);
        elsif ((rden = '1') AND (RdInc = '0')) then
            s_rdptr <= s_rdptr;
            DataOut <= s_fifo(s_rdptr + DATA_W - 1 downto s_rdptr);
        elsif (rden = '0') then
		    s_rdptr <= s_rdptr;
    		DataOut <= (others => 'Z');
	    else
            s_rdptr <= s_rdptr;
            DataOut <= (others => 'Z');
        end if;
    end process READ;
end architecture RTL;
