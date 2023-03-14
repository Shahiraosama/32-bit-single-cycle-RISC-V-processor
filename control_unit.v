module control_unitt
( input [31:0] instr ,
input zero, status_SF,areset,
output reg PCSRC,ResultSRC,ALUSRC,memWrite,
output reg RegWrite, load,
output  reg [1:0] immSRC ,
output reg [2:0] ALUControl
);
reg Branch;
reg [1:0] ALUOP;
reg [6:0] opcode;
reg [2:0] func3;
reg func7;
always @(*)
begin
opcode=instr[6:0];
func3=instr [14:12];
func7=instr[30];
end
//wire Branch;
wire beq,bnq,blt;
wire out1;
//wire [1:0] ALUOP;

always@(*)
begin
case(opcode)
//load word instruction 
7'b000_0011: 
begin
RegWrite =1'b1;
immSRC=2'b00;
ALUSRC=1'b1;
memWrite=1'b0;
ResultSRC=1'b1;
Branch=1'b0;
ALUOP=2'b00;
load = 1'b1;
end
7'b010_0011:
begin
RegWrite =1'b0;
immSRC=2'b01;
ALUSRC=1'b1;
memWrite=1'b1;
ResultSRC=1'b0;
Branch=1'b0;
ALUOP=2'b00;
load = 1'b1;
end
7'b011_0011:
begin
RegWrite =1'b1;
immSRC=2'b00;
ALUSRC=1'b0;
memWrite=1'b0;
ResultSRC=1'b0;
Branch=1'b0;
ALUOP=2'b10;
load = 1'b1;
end
7'b001_0011:
begin
RegWrite =1'b1;
immSRC=2'b00;
ALUSRC=1'b1;
memWrite=1'b0;
ResultSRC=1'b0;
Branch=1'b0;
ALUOP=2'b10;
load = 1'b1;
end
7'b1100011:
begin
RegWrite =1'b0;
immSRC=2'b10;
ALUSRC=1'b0;
memWrite=1'b0;
ResultSRC=1'b0;
Branch=1'b1;
ALUOP=2'b01;
load = 1'b1;
end
default:
begin
RegWrite =1'b0;
immSRC=2'b00;
ALUSRC=1'b0;
memWrite=1'b0;
ResultSRC=1'b0;
Branch=1'b0;
ALUOP=2'b00;
load = 1'b0;
end
endcase
end
always@(*)
begin
case(ALUOP)
2'b00:
ALUControl =3'b000;
2'b01:
begin
case(func3)
3'b000: ALUControl=3'b010;
3'b001: ALUControl=3'b010;
3'b100: ALUControl=3'b010;
default: ALUControl =3'b000; 
endcase
end
2'b10:
begin
case(func3)
3'b000:
begin 
if ({opcode[5],func7}!=2'b11)
ALUControl=3'b000;
else if ({opcode[5],func7}==2'b11) 
ALUControl=3'b010;
end
3'b001:
ALUControl=3'b001;
3'b100:
ALUControl=3'b100;
3'b101:
ALUControl=3'b101;
3'b110:
ALUControl=3'b110;
3'b111:
ALUControl=3'b111;
default:
ALUControl =3'b000;
endcase
end
default: ALUControl=3'b000;
endcase
end

always@(*)
begin

case(func3)

3'b000: PCSRC =beq;
3'b001: PCSRC =bnq;
3'b100: PCSRC =blt;
default:PCSRC =1'b0;

endcase
end

assign beq=Branch & zero;
assign bnq=Branch & ~zero;
assign blt=Branch & status_SF ;

endmodule