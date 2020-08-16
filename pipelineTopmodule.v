module pipeline(clk, rst, init);
	input clk, rst, init;

	wire pipeline1InputBranchTaken;
	wire [31:0] pipeline1InputInstruction, pipeline1OutputINstruction;
	wire [31:0] pipeline1InputPC, pipeline1OutputPC;
	wire hazardDetectionOutputHazard;
	wire [31:0] stage3OutputBranchAddress;
	wire [3:0] step5OutputWB_Dest;
	wire [31:0] stage5OutputWB_Value;
	wire stage2OutputMemWBEnb, stage2OutputMEM_R_EN, stage2OutputB, stage2OutputS, stage2OutputTwoSource, 
				stage2OutputOutImm, stage2OutputSignImm24Out, stage2OUtputMemWEn;
	wire [3:0] stage2OutputExeCmd;
	wire stage2InputSregOut;
	wire [11:0] stage2OUtputShiftOperandOut, pipeline2OutputShiftOperand;
	wire [3:0]  stage2OUtputDestOut, pipeline2OutputDest;
	wire [31:0] stage2OutputValRn, stage2OutputValRm, pipeline2OutputPC, pipeline2OutputRN, pipeline2OutputRM;
	wire [3:0] StatusRegisterCarryOut;
	wire [3:0] pipeline2OutputExeCmd, HazaradSource2;
	wire pipeline2OutputMemWbEn, pipeline2OutputMemREN, pipeline2OutputMemWEn, pipeline2OutputB, 
				pipeline2OutputS, pipeline2OutputImm, pipeline2OutputSignedImm, pipeline2OutputCarry;
	wire pipeline4OutMemWbEn, pipeline4OutMemREn ;
	wire [3:0] stage3OutAluToSreg, stage3OutDest;

	stage1 s1(
		.clk(clk),
		.rst(rst),
		.pcEnb(hazardDetectionOutputHazard),
		.BrachTaken(pipeline1InputBranchTaken),
		.PCAdder1Out(pipeline1InputPC),
		.BranchAddress(stage3OutputBranchAddress),
		.InstMemoryOut(pipeline1InputInstruction)
	);	

	IF_ID_pipline if_id(
		.clk(clk),
		.rst(rst),
		.Hazard(hazardDetectionOutputHazard), 
		.BranchTaken(pipeline1InputBranchTaken),
		.PCIn(pipeline1InputPC),
		.InstructionIn(pipeline1InputInstruction),
		.PCOut(pipeline1OutputPC),
		.InstructionOut(pipeline1OutputINstruction)
	);

	stage2 s2(
		.clk(clk),
		.rst(rst),
		.init(init),
		.instruction(pipeline1OutputINstruction),
		.Hazard(hazardDetectionOutputHazard),
		.WB_Dest(step5OutputWB_Dest),
		.WB_Value(stage5OutputWB_Value),
		.WB_WB_EN(pipeline4OutMemWbEn),
		.RegisterReadAddress2(HazaradSource2),
		.MEM_WB_EN(stage2OutputMemWBEnb),
		.MEM_R_EN(stage2OutputMEM_R_EN),
		.MEM_W_EN(stage2OUtputMemWEn),
		.EXE_CMD(stage2OutputExeCmd),
		.B(stage2OutputB),
		.S(stage2OutputS),
		.SregOut(stage2InputSregOut),
		.two_src(stage2OutputTwoSource),
		.OutImm(stage2OutputOutImm),
		.ShiftOperandOut(stage2OUtputShiftOperandOut),
		.SignImm24Out(stage2OutputSignImm24Out),
		.DestOut(stage2OUtputDestOut),
		.Val_Rn(stage2OutputValRn),
		.Val_Rm(stage2OutputValRm)
	);


	hazardUnit hazard(
		src1(stage2OutputValRn),
		src2(HazaradSource2),
		TwoSrc(stage2OutputTwoSource),
		MEM_Dest(pipeline3OutDestOut),
		MEM_WB_EN(pipeline3OutMemWbEn),
		EXE_Dest(pipeline2OutputDest),
		EXE_WB_EN(pipeline2OutputMemWbEn),
		Hazard (hazardDetectionOutputHazard)
	);

	statusRegister stRegister(
		.S(pipeline2OutputS),
		.newStatus(stage3OutAluToSreg),
		.result(stage2InputSregOut)
	);
	ID_EX_pipline id_ex(
		.clk(clk),
		.rst(rst),
		.BranchTaken(pipeline1InputBranchTaken),
		.MEM_WB_ENIn(stage2OutputMemWBEnb),
		.MEM_R_ENIn(stage2OutputMEM_R_EN),
		.MEM_W_ENIn(stage2OUtputMemWEn),
		.EXE_CMDIn(stage2OutputExeCmd),
		.BIn(stage2OutputB),
		.SIn(stage2OutputS),
		.PCIn(pipeline1OutputPC),
		.RNValIn(stage2OutputValRn),
		.RMValIn(stage2OutputValRm),
		.ImmIn(stage2OutputOutImm),
		.ShifOperandIn(stage2OUtputShiftOperandOut),
		.SignedImmIn(stage2OutputSignImm24Out),
		.DestIn(stage2OUtputDestOut),
		.CarryIn(stage2InputSregOut),
		.MEM_WB_ENOut(pipeline2OutputMemWbEn),
		.MEM_R_ENOut(pipeline2OutputMemREN),
		.MEM_W_ENOut(pipeline2OutputMemWEn),
		.EXE_CMDOut(pipeline2OutputExeCmd),
		.BOut(pipeline2OutputB),
		.SOut(pipeline2OutputS),
		.PCOut(pipeline2OutputPC),
		.RNValOut(pipeline2OutputRN),
		.RMValOut(pipeline2OutputRM),
		.ImmOut(pipeline2OutputImm),
		.ShifOperandOut(pipeline2OutputShiftOperand),
		.SignedImmOut(pipeline2OutputSignedImm),
		.DestOut(pipeline2OutputDest),
		.CarryOut(pipeline2OutputCarry)
	);
	wire [31:0] stage3OutAluout, stage3OutRmValOut;
	wire stage3OutMemrEn, stage3OutMemWbEn, stage3OutMemwEn;
	
	stage3 s3(
		.clk(clk),
		.MEM_WB_EN(pipeline2OutputMemWbEn),
		.MEM_R_EN(pipeline2OutputMemREN),
		.MEM_W_EN(pipeline2OutputMemWEn),
		.EXE_CMD(pipeline2OutputExeCmd),
		.S(pipeline2OutputS),
		.PCIn(pipeline2OutputPC),
		.RNVal(pipeline2OutputRN),
		.RMVal(pipeline2OutputRM),
		.Imm(pipeline2OutputImm),
		.ShiftOperand(pipeline2OutputShiftOperand),
		.SignedImmediate(pipeline2OutputSignedImm),
		.DestIn(pipeline2OutputCarry),
		.CarryIn(pipeline2OutputCarry),
		.ALUToSReg(stage3OutAluToSreg),
		.ALUOut(stage3OutAluout),
		.RMValOut(stage3OutRmValOut),
		.MEM_R_ENOut(stage3OutMemrEn),
		.MEM_WB_ENOut(stage3OutMemWbEn),
		.MEM_W_ENOut(stage3OutMemwEn),
		.DestOut(stage3OutDest),
		.BranchAddress(stage3OutputBranchAddress)
	);

	wire pipeline3OutMemWbEn, pipeline3OutMemREn, pipeline3OutMemWEn;
	wire [31:0] pipeline3OutALURes, pipeline3OutRMVal;
	wire [3:0] pipeline3OutDestOut;
	
	EX_MEM_pipline ex_mem(
		.clk(clk),
		.rst(rst),
		.MEM_WB_ENIn(stage3OutMemWbEn),
		.MEM_R_ENIn(stage3OutMemrEn),
		.MEM_W_ENIn(stage3OutMemwEn),
		.ALUResIn(stage3OutAluout),
		.RMValIn(stage3OutRmValOut),
		.DestIn(stage3OutDest),
		.MEM_WB_ENOut(pipeline3OutMemWbEn),
		.MEM_R_ENOut(pipeline3OutMemREn),
		.MEM_W_ENOut(pipeline3OutMemWEn),
		.ALUResOut(pipeline3OutALURes),
		.RMValOut(pipeline3OutRMVal),
		.DestOut(pipeline3OutDestOut)
	);
	wire [31:0] stage4DataMemroyOut;
	wire stage4;

	stage4 s4(
		.clk(clk),
		.MEM_R_EN(pipeline3OutMemREn),
		.MEM_W_EN(pipeline3OutMemWEn),
		.ALUOut(pipeline3OutALURes),
		.RMVal(pipeline3OutRMVal),
		.dataMemOut(stage4DataMemroyOut)
	);

	wire [31:0] pipeline4OutDataMem, pipeline4OutAluRes;
	wire [3:0] pipeline4OutDest;


	MEM_WB_pipeline mem_wb(
		.clk(clk),
		.rst(rst),
		.MEM_WB_ENIn(pipeline3OutMemWEn),
		.MEM_R_ENIn(pipeline3OutMemREn),
		.ALUResIn(pipeline3OutALURes),
		.DataMemResIn(stage4DataMemroyOut),
		.DestIn(pipeline3OutDestOut),
		.MEM_WB_ENOut(pipeline4OutMemWbEn),
		.MEM_R_ENOut(pipeline4OutMemREn),
		.ALUResOut(pipeline4OutAluRes),
		.DataMemResOut(pipeline4OutDataMem),
		.DestOut(pipeline4OutDest)
	);

	stage5 s5(
		.ALUOut(pipeline4OutAluRes),
		.DataMemoryOut(pipeline4OutDataMem),
		.MEM_R_EN(pipeline4OutMemREn),
		.RegisterFileWriteData(stage5OutputWB_Value)
	);

endmodule

