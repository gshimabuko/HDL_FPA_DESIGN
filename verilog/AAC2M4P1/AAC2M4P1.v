module LS161a (D, CLK, CLR_n, LOAD_n, ENP, ENT, Q, RCO);
    input [3:0] D;        // Parallel Input
    input CLK;            // Clock
    input CLR_n;          // Active Low Asynchronous Reset
    input LOAD_n;         // Enable Parallel Input
    input ENP;            // Count Enable Parallel
    input ENT;            // Count Enable Trickle
    output [3:0]Q;        // Parallel Output 	
    output RCO;            // Ripple Carry Output (Terminal Count)

    wire    [3:0]D;
    wire    CLK;
    wire    CLR_n;
    wire    LOAD_n;
    wire    ENP;
    wire    ENT;
    reg     [3:0]Q;
    reg     RCO;

    parameter  SIZE         = 3;
    parameter   S0_INIT     = 4'b0000,
                S1_COUNT    = 4'b0001,
                S2_COUNT    = 4'b0011,
                S3_COUNT    = 4'b0010,
                S4_COUNT    = 4'b0110,
                S5_COUNT    = 4'b0111,
                S6_COUNT    = 4'b0101,
                S7_COUNT    = 4'b0100,
                S8_COUNT    = 4'b1100,
                S9_COUNT    = 4'b1101,
                S10_COUNT   = 4'b1111,
                S11_COUNT   = 4'b1110,
                S12_COUNT   = 4'b1010,
                S13_COUNT   = 4'b1011,
                S14_COUNT   = 4'b1001,
                S15_COUNT   = 4'b1000;
               
    reg     [3:0] c_state;
    wire    [3:0] next_state;

    assign next_state = fsm_function(c_state, ENP, ENT, LOAD_n, D); 
    function [3:0] fsm_function;
        input [3:0] c_state;
        input ENP;
        input ENT;
        input LOAD_n;
	input [3:0]D;

        if ((LOAD_n == 1'b1) & (ENP == 1'b1) & (ENT == 1'b1))
        begin
            case(c_state)
                S0_INIT:
                    fsm_function = S1_COUNT;
                S1_COUNT:
                    fsm_function = S2_COUNT;
                S2_COUNT:
                    fsm_function = S3_COUNT;
                S3_COUNT:
                    fsm_function = S4_COUNT;
                S4_COUNT:
                    fsm_function = S5_COUNT;
                S5_COUNT:
                    fsm_function = S6_COUNT;
                S6_COUNT:
                    fsm_function = S7_COUNT;
                S7_COUNT:
                    fsm_function = S8_COUNT;
                S8_COUNT:
                    fsm_function = S9_COUNT;
                S9_COUNT:
                    fsm_function = S10_COUNT;
                S10_COUNT:
                    fsm_function = S11_COUNT;
                S11_COUNT:
                    fsm_function = S12_COUNT;
                S12_COUNT:
                    fsm_function = S13_COUNT;
                S13_COUNT:
                    fsm_function = S14_COUNT;
                S14_COUNT:
                    fsm_function = S15_COUNT;
                S15_COUNT:
                    fsm_function = S0_INIT;
                default:
                    fsm_function = S0_INIT;
            endcase
        end else if (LOAD_n == 1'b0)
        begin
            case(D) 
                4'b0000:
                    fsm_function = S0_INIT;
                4'b0001:
                    fsm_function = S1_COUNT;
                4'b0010:
                    fsm_function = S2_COUNT;
                4'b0011:
                    fsm_function = S3_COUNT;
                4'b0100:
                    fsm_function = S4_COUNT;
                4'b0101:
                    fsm_function = S5_COUNT;
                4'b0110:
                    fsm_function = S6_COUNT;
                4'b0111:
                    fsm_function = S7_COUNT;
                4'b1000:
                    fsm_function = S8_COUNT;
                4'b1001:
                    fsm_function = S9_COUNT;
                4'b1010:
                    fsm_function = S10_COUNT;
                4'b1011:
                    fsm_function = S11_COUNT;
                4'b1100:
                    fsm_function = S12_COUNT;
                4'b1101:
                    fsm_function = S13_COUNT;
                4'b1110:
                    fsm_function = S14_COUNT;
                4'b1111:
                    fsm_function = S15_COUNT;
                default:
                    fsm_function = S0_INIT;
            endcase
        end else
        begin
            fsm_function = c_state;
        end
    endfunction
    always @ (posedge CLK, CLR_n)
    begin
        if (CLR_n == 1'b0)
        begin
            c_state <= S0_INIT;
        end else
        begin
            c_state <= next_state;
        end
    end
    always @ (c_state)
    begin
        case (c_state)
            S0_INIT: 
            begin
                RCO = 1'b0;
                Q   = 4'd0;
            end
            S1_COUNT: 
            begin
                RCO = 1'b0;
                Q   = 4'd1;
            end
            S2_COUNT   : 
            begin
                RCO = 1'b0;
                Q   = 4'd2;
            end
            S3_COUNT: 
            begin
                RCO = 1'b0;
                Q   = 4'd3;
            end
            S4_COUNT:
            begin
                RCO = 1'b0;
                Q   = 4'd4;
            end
            S5_COUNT:
            begin
                RCO = 1'b0;
                Q   = 4'd5;
            end
            S6_COUNT: 
            begin
                RCO = 1'b0;
                Q   = 4'd6;
            end
            S7_COUNT: 
            begin
                RCO = 1'b0;
                Q   = 4'd7;
            end
            S8_COUNT: 
            begin
                RCO = 1'b0;
                Q   = 4'd8;
            end
            S9_COUNT: 
            begin
                RCO = 1'b0;
                Q   = 4'd9;
            end
            S10_COUNT: 
            begin
                RCO = 1'b0;
                Q   = 4'd10;
            end
            S11_COUNT: 
            begin
                RCO = 1'b0;
                Q   = 4'd11;
            end
            S12_COUNT: 
            begin
                RCO = 1'b0;
                Q   = 4'd12;
            end
            S13_COUNT: 
            begin
                RCO = 1'b0;
                Q   = 4'd13;
            end
            S14_COUNT:
            begin
                RCO = 1'b0;
                Q   = 4'd14;
            end
            S15_COUNT: 
            begin
                RCO = 1'b1;
                Q   = 4'd15;
            end
            default:
            begin
                RCO = 1'b0;
                Q   = 4'd0;                   
            end
        endcase
    end
endmodule
