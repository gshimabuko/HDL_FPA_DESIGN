-------------------------------------------------------------------------------
--! 
--! @file      fifo_FSM_PAR.vhd
--!
--! @brief     Fifo for a BCH Block in a SDR
--! @details   Fifo implemented using FSM allowing simultaneous Read and Write
--! operations, with dynamic Read and Write Pointers
--!
--! @author    Guilherme Shimabuko
--! @author    
--! 
--! @version   1.1
--! @date      2019-09-30
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
-- 1.0      2019-09-25 GSHIMABUKO    Block Created
-- 1.1      2019-09-25 GSHIMABUKO    Fixed errors caused by empty Fifo and full 
--                                   Fifo

--------------------------------------------------------------------------------
-- Libraries ------------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use work.fifo_cons_pkg.all;
    use work.fifo_type_pkg.all;
--    use work.global_constants_pkg.all;
    
entity fifo_FSM_PAR is
    port (
        -- Inputs ---------------------------------------------------
            clk : in STD_LOGIC;
            rst_n : in STD_LOGIC;
            data_input : in STD_LOGIC_VECTOR (DATA_W-1 downto 0);
            write_en : in STD_LOGIC;
            read_en : in STD_LOGIC;

        -- Outputs --------------------------------------------------
            data_out : out STD_LOGIC_VECTOR (DATA_W-1 downto 0);
            full : out STD_LOGIC;
            write_ack : out STD_LOGIC;
            empty : out STD_LOGIC
    );
end fifo_FSM_PAR;
architecture behaviour of fifo_FSM_PAR is
    signal s_cstate:        ST_FSM_FIFO;
    signal s_nstate:        ST_FSM_FIFO;
    signal s_data:          STD_LOGIC_VECTOR(DEPTH-1 downto 0);
    signal s_wpointer:      integer range 0 to DEPTH;
    signal s_rpointer:      integer range 0 to DEPTH;
    signal s_pointer:       integer range 0 to DEPTH;
    begin
    FSM_CS_PROC: process(clk, rst_n)
    begin
        if rst_n='0' then
            s_cstate <= S0_EMPTY;
        elsif (rising_edge(clk)) then
            s_cstate <= s_nstate;
        end if;
    end process FSM_CS_PROC;
    
    FSM_NS_PROC: process(s_cstate, s_wpointer, s_rpointer)
    begin
        case s_cstate is
        when S0_EMPTY    =>
            if(s_pointer = 0) then
                s_nstate <= S0_EMPTY;
            else
                s_nstate <= S1_RW;
            end if;
        when S2_FULL      =>
            if(s_pointer=DEPTH-DATA_W) then
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
            s_nstate<=S1_RW;
        end case;
    end process FSM_NS_PROC;
    FSM_OUT_PROC: process(clk, rst_n)
    begin
        if rst_n='0' then
            data_out <= (others => '0');
            write_ack <='0';
            s_data <= (others => '0');
            s_wpointer <= 0;
            s_rpointer<=0;
            s_pointer<=0;
            empty <= '1';
            full <= '0';
        elsif rising_edge(clk) then
            case s_cstate is
            when S0_EMPTY    =>
                empty<='1';
                data_out <= (others => '0');
                if (write_en='0') then
                    s_wpointer <= 0;
                    s_pointer  <= 0;
                    s_rpointer <= 0;
                    s_data <= (others => '0');
                    write_ack <= '0';
                else
                    s_data(DATA_W-1 downto 0) <= data_input;
                    s_wpointer <= DATA_W;
                    s_pointer  <= DATA_W;
                    s_rpointer <= 0;
                    write_ack <= '1';
                end if;
            when S2_FULL      =>
                write_ack <= '0';
                full <= '1';
                if (read_en='0') then
                    s_rpointer <= s_rpointer;
                    s_pointer <= s_pointer;
                    data_out <= (others => '0');
                else
                    data_out<=s_data(s_rpointer+DATA_W-1 downto s_rpointer);
                    s_rpointer<=s_rpointer + DATA_W;
                    s_pointer <= s_pointer - DATA_W;
                                        
                end if;
            when S1_RW   =>
                if (read_en='0') AND (write_en='0') then
                    s_rpointer <= s_rpointer;
                    s_wpointer <= s_wpointer;
                    s_pointer  <= s_pointer;
                    data_out   <= (others => '0');
                    full       <='0';
                    empty      <='0';
                elsif (read_en='1') AND (write_en='0') then
                    data_out<=s_data(s_rpointer+DATA_W-1 downto s_rpointer);
                    s_wpointer <= s_wpointer;
                    if s_pointer = 0 then
                        if s_rpointer=DEPTH-DATA_W then
                            s_rpointer <= 0;    
                        else
                            s_rpointer <= s_rpointer+DATA_W;
                        end if;
                        s_pointer <= s_pointer;
                        empty      <='1';
                        full       <='0';
                    elsif s_rpointer=DEPTH-DATA_W then
                        s_rpointer <= 0;
                        s_pointer  <= s_pointer;
                        empty      <='0';
                        full       <='0';
                    else
                        s_rpointer <= s_rpointer + DATA_W;
                        s_pointer <= s_pointer - DATA_W;
                        empty      <='0';
                        full       <='0';
                    end if;
                elsif (write_en='1') AND (read_en='1') then
                    data_out<=s_data(s_rpointer+DATA_W-1 downto s_rpointer);
                    s_pointer <= s_pointer;
                    empty      <='0';
                    full       <='0';
                    write_ack <= '1';
                    if s_rpointer=DEPTH-DATA_W then
                        s_rpointer <= 0;
                    else
                        s_rpointer<=s_rpointer + DATA_W;
                    end if;
                    if s_wpointer=DEPTH-DATA_W then
                        s_wpointer <= 0;
                    else
                        s_wpointer <= s_wpointer + DATA_W;
                    end if;
                else
                    s_data(s_wpointer+DATA_W-1 downto s_wpointer) <= data_input;                    
                    write_ack <= '1';
                    empty      <='0';
                    if s_pointer = DEPTH-DATA_W then
                        if s_wpointer=DEPTH-DATA_W then
                            s_wpointer <= 0;    
                        else
                            s_wpointer <= s_wpointer+DATA_W;
                        end if;
                        s_pointer <= s_pointer;
                        full       <='1';
                    elsif s_wpointer=DEPTH-DATA_W then
                        s_wpointer <= 0;
                        s_pointer <= s_pointer + DATA_W;
                        full       <='0';
                    else
                        s_wpointer <= s_wpointer + DATA_W;
                        s_pointer <= s_pointer + DATA_W;
                        full       <='0';
                    end if;
               end if;
            when others =>
                write_ack <= '0';
                data_out <= (others => '0');
            end case;
         end if;
    end process FSM_OUT_PROC;
end architecture behaviour;
    
    
