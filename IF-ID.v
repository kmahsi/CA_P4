module IF_ID_pipeline(clk, rst, Hazard, BranchTaken, PCIn, InstructionIn, PCOut, InstructionOut);
	input clk, rst, Hazard, BranchTaken;
	input[31:0] PCIn, InstructionIn;
	output [31:0] PCOut, InstructionOut;

	registerWitEnb  #(.size(64)) Reg(
		.clock(clk), 
		.reset(rst || BranchTaken), 
		.enable(~Hazard),
		.regIn({PCIn,InstructionIn}), 
		.regOut({PCOut,InstructionOut})
	);

endmodule


