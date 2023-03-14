`timescale 1ns/1ps
module RISCV_TB ();
reg              clk,areset;


//initial block
initial 
begin
areset=0;
clk=0;
repeat(2) @(posedge clk )
areset=1;
repeat(1100)  @(posedge clk );
#100 $stop ;
end
//clk Gen
always #5 clk = ~clk ;
//DUT Instantiaon
 RISC_V RISCTB(.clk(clk),.areset(areset));
endmodule
