module data_memory (
input wire [31:0] A,WD,
input clk ,WE,
output wire [31:0]ReadData
);
integer i;
reg [31:0] D_mem[0:63];
initial
begin
for(i=0;i<64;i=i+1)
D_mem[i]<=32'b0;
end
always @(posedge clk)
begin
if(WE) 
D_mem[A[31:2]]=WD;
end
assign ReadData=D_mem[A[31:2]];
endmodule

