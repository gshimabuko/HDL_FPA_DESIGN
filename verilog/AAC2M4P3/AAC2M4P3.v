module FSM(In1, RST, CLK, Out1);    
    input In1;
    input RST;
    input CLK; 
    output reg Out1;
   
    wire In1;
    wire RST;
    wire CLK;
    
    parameter size = 2;
    parameter SA = 2'b00;
    parameter SB = 2'b01;
    parameter SC = 2'b11;

    reg     [1:0]c_state;
    wire    [1:0]next_state;

    assign next_state = fsm_function(c_state, In1, RST); 

    function [3:0] fsm_function;
    input [1:0] c_state;
    input In1;
    input RST;
    if (RST == 1'b0)
    begin
        fsm_function = SA;
    end else
    begin
        case(c_state)
        SA:
            if (In1 == 1'b0)
            begin
                fsm_function = SA;
            end else
            begin
                fsm_function = SB;
            end
        SB:
            if (In1 == 1'b1)
            begin
                fsm_function = SB;
            end else
            begin
                fsm_function = SC;
            end
        SC:
            if (In1 == 1'b0)
            begin
                fsm_function = SC;
            end else
            begin
                fsm_function = SA;
            end
        default:
            fsm_function = SA;
        endcase
    end
    endfunction

    always @ (posedge CLK)
    begin
        if (RST == 1'b0)
        begin
            c_state <= SA;
        end else
        begin
            c_state <= next_state;
        end
    end
    
    always @ (c_state)
    begin
        case (c_state)
        SA: 
            Out1 = 1'b0;
           
        SB: 
            Out1 = 1'b0;
        SC: 
            Out1 = 1'b1;
        default:
            Out1 = 1'b0;
    endcase
    end
endmodule;
