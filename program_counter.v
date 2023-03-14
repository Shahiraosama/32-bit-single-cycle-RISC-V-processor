module program_counter
( input clk,areset,load,PCSRC,
input [31:0] immEXT,
output reg [31:0] PC 
);
reg [31:0] PCNEXT;

always @(posedge clk or negedge areset)
begin
if (!areset)
PC<=0;
else if (load==1)
PC<=PCNEXT;
end
always@(*)
begin
case (PCSRC)
            1'b0:PCNEXT=PC+32'd4;
            1'b1:PCNEXT=PC+immEXT;
endcase
    end
endmodule