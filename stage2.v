module stage2(clk, rst, init, instruction, PCIn, MEM_Dest, MEM_WB_EN, EXE_Dest, EXE_WB_EN, Hazard, WB_Dest, WB_Value, WB_WB_EN,
	WB_EN, MEM_R_EN, MEM_WB_EN, B, S, SregOut, two_src, OutImm, ShiftOperandOut, SignImm24Out, DestOut);
	
	input clk, rst, init;
	input [31:0] instruction, PCIn;
	input MEM_WB_EN, EXE_WB_EN, WB_WB_EN, SregOut;
	input [3:0] MEM_Dest, EXE_Dest;
	input [3:0] WB_Dest;
	input [31:0] WB_Value;
	input Hazard;
	wire[8:0] ControllerOutput;
	output WB_EN, MEM_R_EN, MEM_W_EN, B, S, two_src, OutImm, SignImm24Out;
	output [3:0] EXE_CMD, DestOut;
	output [11:0] ShiftOperandOut;
	output [31:0] PCout;
	wire ConditionCheckOut;
	output [31:0] Val_Rn, Val_Rm;

	wire [3:0] Rn, Rd, Rm;
	assign Rn = instruction[19:16];
	assign Rd = instruction[15:12];
	assign Rm = instruction[3:0];
	assign  PCout = PCIn;
	assign two_src = MEM_W_EN | (^ (instruction[25]));
	assign OutImm = instruction[25];
	assign ShiftOperandOut = instruction[11:0];
	assign SignImm24Out = instruction[25];
	assign DestOut = Rd;


	controller CU (
		.clock(clk), 
		.opcode(instruction[24:21]), 
		.statusUpdate(S), 
		.mode(instruction[27:26]), 
		.controllerOut(ControllerOutput)
	);

	ConditionCheck CCHECK(
		.cond(instruction[31:28]),
		.stRegister(SregOut),
		.out(ConditionCheckOut)
	);
	
	mux_2_input  #(.WORD_LENGTH (4)) MUX3 (    //mux 8
		.in1(ControllerOutput), 
		.in2(0), 
		.sel(Hazard | (^ConditionCheckOut)), 
		.out({WB_EN, MEM_R_EN, MEM_W_EN, EXE_CMD, B, S})
	);

	

	mux_2_input  #(.WORD_LENGTH (4)) MUX2 (    //mux 8
		.in1(Rd), 
		.in2(Rm), 
		.sel(MEM_W_EN), 
		.out(controllerAllBits)
	);

	registerFile regFile(
		.clock(clk), 
		.regWrite(WB_WB_EN), 
		.writeRegister(WB_Dest), 
		.writeData(WB_Value), 
		.readRegister1(Rn), 
		.readRegister2(Rd), 
		.readData1(Val_Rn), 
		.readData2(Val_Rm)
	);

endmodule 