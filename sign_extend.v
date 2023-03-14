module sign_extend
( input [1:0] immSRC,
input [31:7] instr,
output reg [31:0] immEXT
);
always@(*)
begin
case(immSRC)
2'b00: immEXT={{20{instr[31]}},instr[31:20]};
2'b01: immEXT={{20{instr[31]}},instr[31:25],instr[11:7]};
2'b10: immEXT={{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0};
default: immEXT= 0;
//{{20{instr[31]}},instr[31:20]};
endcase 
end
endmodule

