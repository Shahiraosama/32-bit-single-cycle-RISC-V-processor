module ALU_32
(  
input wire [31:0] A,B,
input wire [2:0] OPCODE,
output reg [31:0] result,
output wire status_SF,status_ZF
);
wire [32:0] carry;
wire [31:0] sign;
assign carry ={1'b0,A}+{1'b0,B};
assign status_CF=carry[32];
assign sign =A-B;
assign status_SF=sign[31];
always@(*)
begin
case(OPCODE)
3'b000: result= A+B;
3'b001: result= A<<<B;
3'b010: result= A-B;
3'b100: result= A^B;
3'b101: result= A>>>B;
3'b110: result= (A|B);
3'b111: result= (A&B);
default: result=0;
endcase
end
assign status_ZF=(A==B)?1'b1:1'b0;
endmodule
