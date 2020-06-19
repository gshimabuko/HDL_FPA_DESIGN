module comparator_2bit(
    input[1:0] A, B,
    output reg Equals
);

always @(A or B)
begin: COMPARE
    if (A==B)
        Equals = 1;
    else
        Equals = 0;
    end
endmodule
