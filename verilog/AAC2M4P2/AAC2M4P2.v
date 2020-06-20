module RAM128x32 (clk, we, address, d, q);
    parameter   Data_width = 32;  //# of bits in word
    parameter   Addr_width = 7;  // # of address bits
    input wire clk;
    input wire we;
    input wire [(Addr_width-1):0] address;
    input wire [(Data_width-1):0] d;
    output wire [(Data_width-1):0] q;
    
    reg[31:0]ram[6:0];
    assign q = ram[address];

    always @(posedge(clk))
    begin
        if (we == 1'b1)
        begin
            ram[address] <= d;
        end else
        begin
            ram[address] <= ram[address];
        end
    end
endmodule

