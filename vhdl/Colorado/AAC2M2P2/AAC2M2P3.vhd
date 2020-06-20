library ieee;
use ieee.std_logic_1164.all;
use work.fsm_pkg.all;

entity FSM is port (
    In1: in std_logic;
    RST: in std_logic; 
    CLK: in std_logic;
    Out1 : inout std_logic);
end FSM;
architecture behavioural of FSM is
signal s_cstate: FSM_ST;
signal s_nstate: FSM_ST;
begin
    FSM_CS_PROC: process (CLK, RST)
    begin
        if (RST = '1') then
            s_cstate <= S0_A;
        elsif (rising_edge(CLK)) then
            s_cstate <= s_nstate;
        end if;
    end process FSM_CS_PROC;

    FSM_NS_PROC: process (s_cstate, In1)
    begin
        case s_cstate is
        when S0_A   =>
            if (In1 = '0') then
                s_nstate <= S0_A;
            else
                s_nstate <= S1_B;
            end if;
        when S1_B   =>
            if (In1 = '0') then
                s_nstate <= S2_C;
            else
                s_nstate <= S1_B;
            end if;
        when S2_C   =>
            if (In1 = '0') then
                s_nstate <= S2_C;
            else
                s_nstate <= S0_A;
            end if;
        when others =>
            s_nstate <= S0_A;
        end case;
    end process FSM_NS_PROC;

    FSM_OUT_PROC: process (s_cstate)
    begin
        case s_cstate is
        when S0_A   =>
            Out1 <= '0';
        when S1_B   =>
            Out1 <= '1';
        when S2_C   =>
            Out1 <= '0';
        when others =>
            Out1 <= '0';
        end case;
    end process FSM_OUT_PROC;
end behavioural;
