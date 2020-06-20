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

	signal s_fifo:      STD_LOGIC_VECTOR(DEPTH-1 downto 0);
	signal s_wrptr:     integer range 0 to DEPTH;
    signal s_rdptr:     integer range 0 to DEPTH;
    signal s_pointer:   integer range 0 to DEPTH;
	signal en:          std_logic_vector(7 downto 0);
	signal dmuxout:     std_logic_vector(8 downto 0);
begin
    FSM_CS_PROC: process (clk, rst)
    begin
        if (rst = '1') then
            s_cstate <= S0_EMPTY;
        elsif (rising_edge(clk)) then
            s_cstate <= s_nstate;
        end if;
    end process FSM_CS_PROC;
    FSM_NS_PROC: process (s_cstate, s_wrptr, s_rdptr)
    begin
        case s_cstate is
        when S0_EMPTY    =>
            if(s_pointer = 0) then
                s_nstate <= S0_EMPTY;
            else
                s_nstate <= S1_RW;
            end if;
        when S2_FULL      =>
            if(s_pointer = DEPTH-DATA_W) then
                s_nstate <= s_nstate;
            else
                s_nstate <= S1_RW;
            end if;
        when S1_RW   =>
            if(s_pointer=DEPTH-DATA_W) then
                s_nstate <= S2_FULL;
            elsif(s_pointer = 0) then
                s_nstate <= S0_EMPTY;
            else
                s_nstate <= S1_RW;
            end if;
        when others =>
            s_nstate <= S1_RW;
        end case;
    end process FSM_NS_PROC;
    FSM_OUT_PROC: process (clk, rst)
    begin
        if rst = '1' then
            DataOut     <= (others => 'Z');
            s_fifo      <= (others => '0');
            s_wrptr     <= 0;
            s_rdptr     <= 0;
            s_pointer   <= 0;
        elsif rising_edge(clk) then
            case s_cstate is
            when S0_EMPTY    =>
                s_rdptr <= 0;
                DataOut <= (others => 'Z');
                if ((WrInc = '1') AND (WrPtrClr = '0') AND (wren = '1')) then
                    s_wrptr     <= DATA_W;
                    s_pointer   <= DATA_W;
                    s_fifo(DATA_W - 1 downto 0) <= DataIn;
                else
                    s_wrptr     <= 0;
                    s_rdptr     <= 0;
                    s_pointer   <= 0;
                    if (wren = '1') then
                        s_fifo(DATA_W - 1 downto 0) <= DataIn;
                    else
                        s_fifo(DATA_W - 1 downto 0) <= s_fifo(DATA_W - 1 downto 0);
                    end if;
                end if;
            when S2_FULL      =>
                if ((RdInc = '1') AND (RdPtrClr = '0') AND (rden = '1') AND (WrPtrClr = '0')) then
                    s_wrptr     <= s_wrptr;
                    s_rdptr     <= s_rdptr + DATA_W;
                    s_pointer   <= s_pointer - DATA_W;
                    DataOut    <= s_fifo(s_rdptr + DATA_W - 1 downto s_rdptr);
                else
                    if (RdPtrClr = '1') then
                        s_rdptr <= 0;
                    elsif RdInc = '1' then
                        s_rdptr <= s_rdptr + DATA_W;
                    else
                        s_rdptr <= s_rdptr;
                    end if;

                    if (WrPtrClr = '1') then
                        s_wrptr <= 0;
                    elsif (WrInc = '1') then
                        s_wrptr <= s_wrptr + DATA_W;
                    else
                        s_wrptr <= s_wrptr;
                    end if;
                    if (rden = '1') then
                        DataOut <= s_fifo(s_rdptr + DATA_W - 1 downto s_rdptr);
                    else
                        DataOut <= (others => 'Z');
                    end if;
                end if;

            when S1_RW   =>
                if ((rden = '0') AND (RdInc = '0') AND (RdPtrClr='0') AND (wren = '0') AND (WrInc = '0') AND (WrPtrClr = '0')) then
                    s_wrptr     <= s_wrptr;
                    s_rdptr     <= s_rdptr;
                    s_pointer   <= s_pointer;
                    DataOut    <= (others => 'Z');
                    s_fifo(s_wrptr + DATA_W - 1 downto s_wrptr) <= s_fifo(s_wrptr + DATA_W - 1 downto s_wrptr);
                elsif ((RdInc = '1') AND (RdPtrClr = '0') AND (rden = '1') AND (WrPtrClr = '0') AND (wren = '0') AND (WrInc = '0')) then
                    s_wrptr     <= s_wrptr;
                    s_rdptr     <= s_rdptr + DATA_W;
                    s_pointer   <= s_pointer - DATA_W;
                    DataOut    <= s_fifo(s_rdptr + DATA_W - 1 downto s_rdptr);
                    s_fifo(s_wrptr + DATA_W - 1 downto s_wrptr) <= s_fifo(s_wrptr + DATA_W - 1 downto s_wrptr);
                elsif ((RdInc = '0') AND (RdPtrClr = '0') AND (rden = '0') AND (WrPtrClr = '0') AND (wren = '1') AND (WrInc = '1')) then
                    s_rdptr     <= s_rdptr;
                    DataOut    <= (others => 'Z');
                    s_fifo(s_wrptr + DATA_W - 1 downto s_wrptr) <= DataIn;
                    if (s_pointer = DEPTH - DATA_W) then
                        if (s_wrptr = DEPTH - DATA_W) then
                            s_wrptr <= 0;
                        else
                            s_wrptr <= s_wrptr + DATA_W;
                        end if;
                        s_pointer   <= s_pointer;
                    elsif (s_wrptr = DEPTH - DATA_W) then
                        s_wrptr     <= 0;
                        s_pointer   <= s_pointer + DATA_W;
                    else
                        s_wrptr     <= s_wrptr + DATA_W;
                        s_pointer   <= s_pointer + DATA_W;
                    end if;
                elsif ((RdInc = '1') AND (RdPtrClr = '0') AND (rden = '1') AND (WrPtrClr = '0') AND (wren = '1') AND (WrInc = '1')) then
                    DataOut <= s_fifo(s_rdptr + DATA_W - 1 downto s_rdptr);
                    s_pointer <= s_pointer;
                    if (s_rdptr = DEPTH - DATA_W) then
                        s_rdptr <= 0;
                    else
                        s_rdptr <= s_rdptr + DATA_W;
                    end if;
                    if (s_wrptr = DEPTH - DATA_W) then
                    else
                        s_wrptr <= s_wrptr + DATA_W;
                    end if;
                else
                    if (RdPtrClr = '1') then
                        s_rdptr <= 0;
                    elsif RdInc = '1' then
                        s_rdptr <= s_rdptr + DATA_W;
                    else
                        s_rdptr <= s_rdptr;
                    end if;

                    if (WrPtrClr = '1') then
                        s_wrptr <= 0;
                    elsif (WrInc = '1') then
                        s_wrptr <= s_wrptr + DATA_W;
                    else
                        s_wrptr <= s_wrptr;
                    end if;
                    if (rden = '1') then
                        DataOut <= s_fifo(s_rdptr + DATA_W - 1 downto s_rdptr);
                    else
                        DataOut <= (others => 'Z');
                    end if;
                end if;
           when others =>
                DataOut <= (others => 'Z');
            end case;
         end if;
     end process FSM_OUT_PROC;
end architecture RTL;
