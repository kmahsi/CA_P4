module stage2(clk, rst, init, instruction, Hazard, WB_Dest, WB_Value, WB_WB_EN, RegisterReadAddress2,
	MEM_WB_EN, MEM_R_EN, MEM_W_EN, EXE_CMD, B, S, SregOut, two_src, OutImm, ShiftOperandOut, SignImm24Out, DestOut, Val_Rn, Val_Rm);
	
	input clk, rst, init;
	input [31:0] instruction;
	input WB_WB_EN;
	input[3:0] SregOut;
	input [3:0] WB_Dest;
	input [31:0] WB_Value;
	input Hazard;
	wire[8:0] ControllerOutput;
	output MEM_WB_EN, MEM_R_EN, MEM_W_EN, B, S, two_src, OutImm;
	output[23:0] SignImm24Out;
	output [3:0] EXE_CMD, DestOut;
	output [11:0] ShiftOperandOut;
	wire ConditionCheckOut;
	output [31:0] Val_Rn, Val_Rm;

	wire [3:0] Rn, Rd, Rm;
	output[3:0] RegisterReadAddress2;
	assign Rn = instruction[19:16];
	assign Rd = instruction[15:12];
	assign Rm = instruction[3:0];
	assign two_src = MEM_W_EN | (^ (instruction[25]));
	assign OutImm = instruction[25];
	assign ShiftOperandOut = instruction[23:0];
	assign SignImm24Out = instruction[25];
	assign DestOut = Rd;


	controller CU (
		.clock(clk), 
		.opcode(instruction[24:21]), 
		.statusUpdate(instruction[20]), 
		.mode(instruction[27:26]), 
		.controllerOut(ControllerOutput)
	);

	ConditionCheck CCHECK(
		.Cond(instruction[31:28]),
		.Status(SregOut),
		.result(ConditionCheckOut)
	);
	
	mux_2_input  #(.WORD_LENGTH (9)) MUX3 (    //mux 8
		.in1(ControllerOutput), 
		.in2(9'd 0), 
		.sel(Hazard || (~ConditionCheckOut)), 
		.out({MEM_WB_EN, MEM_R_EN, MEM_W_EN, EXE_CMD, B, S})
	);

	

	mux_2_input  #(.WORD_LENGTH (4)) MUX2 (    //mux 8
		.in1(Rm), 
		.in2(Rd), 
		.sel(MEM_W_EN), 
		.out(RegisterReadAddress2)
	);

	registerFile regFile(
		.clock(clk), 
		.regWrite(WB_WB_EN), 
		.writeRegister(WB_Dest), 
		.writeData(WB_Value), 
		.readRegister1(Rn), 
		.readRegister2(RegisterReadAddress2), 
		.readData1(Val_Rn), 
		.readData2(Val_Rm)
	);

endmodule 