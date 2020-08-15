module stage5(ALUOut, DataMemoryOut, MEM_R_EN, MEM_WB_EN, RegisterFileWriteData, MEM_R_ENOut, MEM_WB_ENOut);
	input[31:0] ALUOut, DataMemoryOut;
	input MEM_R_EN, MEM_WB_EN;
	output[31:0] RegisterFileWriteData;
	output MEM_R_ENOut, MEM_WB_ENOut;

	assign MEM_R_ENOut = MEM_R_EN;
	assign MEM_WB_ENOut = MEM_WB_EN;
	
	mux_2_input #(.WORD_LENGTH(32)) Mux1(
		.in1(ALUOut), 
		.in2(DataMemoryOut), 
		.sel(MEM_R_ENOut), 
		.out(RegisterFileWriteData)
	);


endmodule