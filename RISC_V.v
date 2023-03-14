module RISC_V 
(input  clk,
input  areset
);
wire [31:0]SRCA;
    reg [31:0]SRCB,Result;
    wire [2:0]ALUControl;
    wire [31:0]ALUResult,immEXT,PC,instr,WriteData,ReadData;
    wire zero,status_SF,PCSRC,load,ALUSRC,ResultSRC,RegWrite;
    wire [1:0]immSRC;
 
  
ALU_32 ALU(.A(SRCA),.B(SRCB),.OPCODE(ALUControl),.result(ALUResult),.status_ZF(zero),.status_SF(status_SF));

 
 program_counter Prog_Counter(.clk(clk),.PCSRC(PCSRC),.load(load),.areset(areset),.immEXT(immEXT),.PC(PC));


 instruction_memory Instr_mem(.A(PC),.RD(instr));

 
 register_file Reg_file(.clk(clk),.WE3(RegWrite),.A1(instr[19:15]),.A2(instr[24:20]),.A3(instr[11:7]),.WD3(Result),.RD1(SRCA),.RD2(WriteData),.reset(areset));

 
 data_memory Data_mem(.clk(clk),.WE(memWrite),.A(ALUResult),.WD(WriteData),.ReadData(ReadData));


sign_extend sign_ext(.instr(instr[31:7]),.immSRC(immSRC),.immEXT(immEXT));


control_unitt ctr_unit(.zero(zero),.status_SF(status_SF),.instr(instr),.PCSRC(PCSRC),.load(load),.areset(areset),.ALUSRC(ALUSRC),.ALUControl(ALUControl),.ResultSRC(ResultSRC),.memWrite(memWrite),.immSRC(immSRC),.RegWrite(RegWrite));
always @(*) begin
    if(ResultSRC==1)
    Result=ReadData;
    else
    Result=ALUResult;
 end
always @(*) begin
    if(ALUSRC==0)
    SRCB=WriteData; 
    else
    SRCB=immEXT;

end
endmodule
