module ID_EX_pipeline(clk, rst, Freeze, BranchTaken, MEM_WB_ENIn, MEM_R_ENIn, MEM_W_ENIn, EXE_CMDIn, BIn, SIn, PCIn, RNValIn, RMValIn,
						ImmIn, ShifOperandIn, SignedImmIn, DestIn, CarryIn, MEM_WB_ENOut, MEM_R_ENOut, MEM_W_ENOut, EXE_CMDOut,
						BOut, SOut, PCOut, RNValOut, RMValOut, ImmOut, ShifOperandOut, SignedImmOut, DestOut, CarryOut);
	input clk, rst, BranchTaken, MEM_WB_ENIn, MEM_R_ENIn, MEM_W_ENIn; //TODO branch taken should be enable
	input[3:0] EXE_CMDIn;
	input BIn, SIn;
	input[31:0] PCIn, RNValIn, RMValIn;
	input ImmIn;
	input[11:0] ShifOperandIn;
	input[23:0] SignedImmIn;
	input[3:0] DestIn;
	input CarryIn;
	output MEM_WB_ENOut, MEM_R_ENOut, MEM_W_ENOut;
	output [3:0] EXE_CMDOut;
	output BOut, SOut;
	output [31:0] PCOut, RNValOut, RMValOut;
	output ImmOut;
	output [11:0] ShifOperandOut;
	output [23:0] SignedImmOut;
	output [3:0] DestOut;
	output CarryOut;
	input Freeze;

	registerWitEnb  #(.size(147)) Reg(
		.clock(clk), 
		.reset(rst || BranchTaken), 
		.enable(1),
		.regIn({MEM_WB_ENIn,MEM_R_ENIn,MEM_W_ENIn,EXE_CMDIn,BIn,SIn,PCIn,RNValIn,RMValIn,ImmIn,ShifOperandIn,SignedImmIn,DestIn,CarryIn}), 
		.regOut({MEM_WB_ENOut,MEM_R_ENOut,MEM_W_ENOut,EXE_CMDOut,BOut,SOut,PCOut,RNValOut,RMValOut,ImmOut,ShifOperandOut,SignedImmOut,DestOut,CarryOut})
	); 

endmodule