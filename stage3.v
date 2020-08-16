module stage3(clk, MEM_WB_EN, MEM_R_EN, MEM_W_EN, EXE_CMD, S, PCIn, RNVal, RMVal, Imm, ShiftOperand, SignedImmediate, DestIn, CarryIn,
						 ALUToSReg, ALUOut, RMValOut, MEM_R_ENOut, MEM_WB_ENOut, MEM_W_ENOut, DestOut, BranchAddress);
	
	input clk, MEM_WB_EN, MEM_R_EN, MEM_W_EN;
	input[3:0] EXE_CMD;
	input S;
	input[31:0] PCIn, RNVal, RMVal;
	input Imm;
	input[11:0] ShiftOperand;
	input[23:0] SignedImmediate;
	input[3:0] DestIn;
	input CarryIn;
	output[3:0] ALUToSReg;
	output[31:0] ALUOut, RMValOut;
	output MEM_R_ENOut, MEM_WB_ENOut, MEM_W_ENOut;
	output[3:0] DestOut;
	output[31:0] BranchAddress;

	assign RMValOut = RMVal;
	assign MEM_R_ENOut = MEM_R_EN;
	assign MEM_WB_ENOut = MEM_WB_EN;
	assign MEM_W_ENOut = MEM_W_EN;
	assign DestOut = DestIn;

	wire ldOrStr;
	OR or1(
		.a(MEM_R_EN),
		.b(MEM_W_EN),
		.out(ldOrStr)
	);

	wire[31:0] val2Out;
	val2Generator val2Gen(
		.RMVal(RMVal), 
		.Imm(Imm), 
		.ShiftOperand(ShiftOperand), 
		.LdOrStr(ldOrStr), 
		.result(val2Out)
	);

	ALU aluUnit(
		.inputA(RMVal), 
		.inputB(val2Out), 
		.exeCommand(EXE_CMD), 
		.carryIn(CarryIn), 
		.result(ALUOut), 
		.statusOut(ALUToSReg)
	);

	adder #(.size(32)) BranchAddressCalc(
		.inputA(PCIn),
		.inputB( { {8{SignedImmediate[23]}}, SignedImmediate} ),
		.result(BranchAddress)
	);

endmodule