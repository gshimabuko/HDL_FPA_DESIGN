LIBRARY ieee; 
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.AAC2M2P1_PKG.ALL;

entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 	-- clock
   SR:  in std_logic;  -- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  -- Parallel input
   PE:   in std_logic;  -- Parallel Enable (Load)
   CEP: in std_logic;  -- Count enable parallel input
   CET:  in std_logic; -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);            			
   TC:  out std_logic  -- Terminal Count
);
end AAC2M2P1;
architecture behavioural of AAC2M2P1 is
    signal s_cstate: FSM_ST_AAC2M2P1;
    signal s_nstate: FSM_ST_AAC2M2P1;
    signal s_count: integer;
    begin

        FSM_CS_PROC: process (CP, SR)
        begin
            if (rising_edge(CP)) then
                if (SR = '0') then
                    s_cstate <= S0_INIT;
                else
                    s_cstate <= s_nstate;
                end if;
            end if;
        end process FSM_CS_PROC;

        FSM_NS_PROC: process(s_cstate, PE, CET, CEP)
        begin
            if ((PE = '1') AND (CET = '1') AND (CEP = '1')) then
                case s_cstate is 
                when S0_INIT    =>
                    s_nstate <= S1_COUNT;
                when S1_COUNT    =>
                    s_nstate <= S2_COUNT;
                when S2_COUNT   =>
                    s_nstate <= S3_COUNT;
                when S3_COUNT   =>
                    s_nstate <= S4_COUNT;                  
                when S4_COUNT   =>
                    s_nstate <= S5_COUNT;
                when S5_COUNT   =>
                    s_nstate <= S6_COUNT;
                when S6_COUNT   =>
                    s_nstate <= S7_COUNT;
                when S7_COUNT   =>
                    s_nstate <= S8_COUNT;
                when S8_COUNT   =>
                    s_nstate <= S9_COUNT;
                when S9_COUNT   =>
                    s_nstate <= S10_COUNT;
                when S10_COUNT  =>
                    s_nstate <= S11_COUNT;
                when S11_COUNT  =>
                    s_nstate <= S12_COUNT;
                when S12_COUNT  =>
                    s_nstate <= S13_COUNT;
                when S13_COUNT  =>
                    s_nstate <= S14_COUNT;
                when S14_COUNT  =>
                    s_nstate <= S15_COUNT;
                when S15_COUNT  =>
                    s_nstate <= S0_INIT;
                when others     =>
                    s_nstate <= S0_INIT;
                end case;
            elsif (PE= '0') then
                case P is 
                when "0000" =>
                    s_nstate <= S0_INIT;
                when "0001" =>
                    s_nstate <= S1_COUNT;
                when "0010" =>
                    s_nstate <= S2_COUNT;
                when "0011" =>
                    s_nstate <= S3_COUNT;
                when "0100" =>
                    s_nstate <= S4_COUNT;                  
                when "0101" =>
                    s_nstate <= S5_COUNT;
                when "0110" =>
                    s_nstate <= S6_COUNT;
                when "0111" =>
                    s_nstate <= S7_COUNT;
                when "1000" =>
                    s_nstate <= S8_COUNT;
                when "1001" =>
                    s_nstate <= S9_COUNT;
                when "1010" =>
                    s_nstate <= S10_COUNT;
                when "1011" =>
                    s_nstate <= S11_COUNT;
                when "1100" =>
                    s_nstate <= S12_COUNT;
                when "1101" =>
                    s_nstate <= S13_COUNT;
                when "1110"  =>
                    s_nstate <= S14_COUNT;
                when "1111"  =>
                    s_nstate <= S15_COUNT;
                when others     =>
                    s_nstate <= S0_INIT;
                end case;
            else
                s_nstate <= s_cstate;
            end if;        
        end process FSM_NS_PROC;

        FSM_OUT_PROC: process (s_cstate)
        begin
            if (rising_edge(CP)) then
                case s_cstate is 
                when S0_INIT    =>
                    TC  <= '0';
                    Q   <= (others => '0');
                    s_count <= 0;
                when S1_COUNT    =>
                    s_count <= s_count + 1;
                    TC  <= '0';
                    Q   <= "0001";
                when S2_COUNT   =>
                    TC  <= '0';
                    Q   <= "0010";
                when S3_COUNT   =>
                    s_count <= s_count + 1;
                    TC  <= '0';
                    Q   <= "0011";
                when S4_COUNT   =>
                    s_count <= s_count + 1;
                    TC  <= '0';
                    Q   <= "0100";
                when S5_COUNT   =>
                   s_count <= s_count + 1;
                   TC  <= '0';
                   Q   <= "0101";
                when S6_COUNT   =>
                   s_count <= s_count + 1;
                   TC  <= '0';
                   Q   <= "0110";
                when S7_COUNT   =>
                   s_count <= s_count + 1;
                   TC  <= '0';
                   Q   <= "0111";
                when S8_COUNT   =>
                    s_count <= s_count + 1;
                    TC  <= '0';
                    Q   <= "1000";
                when S9_COUNT   =>
                    s_count <= s_count + 1;
                    TC  <= '0';
                    Q   <= "1001";
                when S10_COUNT  =>
                    s_count <= s_count + 1;
                    TC  <= '0';
                    Q   <= "1010";
                when S11_COUNT  =>
                    s_count <= s_count + 1;
                    TC  <= '0';
                    Q   <= "1011";
                when S12_COUNT  =>
                    s_count <= s_count + 1;
                    TC  <= '0';
                    Q   <= "1100";
                when S13_COUNT  =>
                    s_count <= s_count + 1;
                    TC  <= '0';
                    Q   <= "1101";
                when S14_COUNT  =>
                    s_count <= s_count + 1;
                    TC  <= '0';
                    Q   <= "1110";
                when S15_COUNT  =>
                    s_count <= s_count + 1;
                    TC  <= '1';
                    Q   <= "1111";
                when others     =>
                    s_count <= 0;
                    TC  <= '0';
                    Q   <= (others => '0');                   
                end case;
            end if;
        end process FSM_OUT_PROC;
    end behavioural;
