module FIFO8x9(
  input clk, rst,
  input RdPtrClr, WrPtrClr, 
  input RdInc, WrInc,
  input [8:0] DataIn,
  output reg [8:0] DataOut,
  input rden, wren
	);
//signal declarations

	reg [8:0] fifo_array[7:0];
	reg [7:0] wrptr, rdptr;
	wire [7:0] wr_cnt, rd_cnt;
    integer i;
    always @(posedge(clk), rst, WrPtrClr)
    begin
        if((rst == 1'b0) || (WrPtrClr == 1'b1))
        begin
            wrptr <= 1'b0;
            for (i=0; i<8; i=i+1)
            begin
                fifo_array[i] <= 9'bz;
            end
        end else if((wren == 1'b1) && (WrInc == 1'b1) && (wrptr < 7))
        begin
            wrptr <= wrptr + 8'd1;
            fifo_array[wrptr] <= DataIn;
        end else if((wren == 1'b1) && (WrInc == 1'b1) && (wrptr == 7))
        begin
            wrptr <= 8'd0;
            fifo_array[wrptr] <= DataIn;
        end else if((wren == 1'b1) && (WrInc == 0'b1))
        begin
            wrptr <= wrptr;
            fifo_array[wrptr] <= DataIn;
        end else if(wren == 0'b1)
        begin
            wrptr <= wrptr;
            fifo_array[wrptr] <= 9'bz;
        end
    end
    always@(posedge(clk), rst)
    begin
        if((rst == 1'b0) || (RdPtrClr == 1'b1))
        begin
            rdptr <= 1'b0;
            DataOut <= 9'bz;
        end else if((rden == 1'b1) && (RdInc == 1'b1) && (rdptr < 7))
        begin
            rdptr <= rdptr + 8'd1;
            DataOut <= fifo_array[wrptr];
        end else if((rden == 1'b1) && (RdInc == 1'b1) && (rdptr == 7))
        begin
            rdptr <= 8'd0;
            DataOut <= fifo_array[wrptr];
        end else if((rden == 1'b1) && (RdInc == 0'b1))
        begin
            rdptr <= rdptr;
            DataOut <= fifo_array[wrptr];
        end else if(rden == 0'b1)
        begin
            rdptr <= rdptr;
            DataOut <= 9'bz;
        end
       
    end
    
endmodule

