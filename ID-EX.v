module ID_EX_pipeline(clk, rst, BranchTaken, MEM_WB_ENIn, MEM_R_ENIn, MEM_W_ENIn, EXE_CMDIn, BIn, SIn, PCIn, RNValIn, RMValIn,
						ImmIn, ShifOperandIn, SignedImmIn, DestIn, CarryIn, MEM_WB_ENOut, MEM_R_ENOut, MEM_W_ENOut, EXE_CMDOut,
						BOut, SOut, PCOut, RNValOut, RMValOut, ImmOut, ShifOperandOut, SignedImmOut, DestOut, CarryOut);
	input clk, rst, BranchTaken, MEM_WB_ENIn, MEM_R_ENIn, MEM_W_ENIn; //TODO branch taken should be enable
	input[3:0] EXE_CMDIn;
	input BIn, SIn;
	input[31:0] PCIn, RNValIn, RMValIn;
	input ImmIn;
	input[11:0] ShifOperandIn;
	input[23:0] SignedImmIn;
	input DestIn;
	input CarryIn;
	output reg MEM_WB_ENOut, MEM_R_ENOut, MEM_W_ENOut;
	output reg[3:0] EXE_CMDOut;
	output reg BOut, SOut;
	output reg[31:0] PCOut, RNValOut, RMValOut;
	output reg ImmOut;
	output reg[11:0] ShifOperandOut;
	output reg[23:0] SignedImmOut;
	output reg[3:0] DestOut;
	output reg CarryOut;

	registerWithNegEdge  #(.size(144)) Reg(
		.clock(clk), 
		.reset(rst), 
		.regIn({MEM_WB_ENIn,MEM_R_ENIn,MEM_W_ENIn,EXE_CMDIn,BIn,SIn,PCIn,RNValIn,RMValIn,ImmIn,ShifOperandIn,SignedImmIn,DestIn,CarryIn}), 
		.regOut({MEM_WB_ENOut,MEM_R_ENOut,MEM_W_ENOut,EXE_CMDOut,BOut,SOut,PCOut,RNValOut,RMValOut,ImmOut,ShifOperandOut,SignedImmOut,DestOut,CarryOut})
	); 

endmodule