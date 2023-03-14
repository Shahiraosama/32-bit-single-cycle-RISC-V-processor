module instruction_memory
( input [31:0] A,
output [31:0] RD 
);
reg [31:0]inst_mem[0:63];
initial $readmemh ("instruction.txt",inst_mem, 0);
assign RD=inst_mem[A[31:2]];
endmodule
