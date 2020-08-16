module stage5(ALUOut, DataMemoryOut, MEM_R_EN, RegisterFileWriteData);
	input[31:0] ALUOut, DataMemoryOut;
	input MEM_R_EN;
	output[31:0] RegisterFileWriteData;
	
	mux_2_input #(.WORD_LENGTH(32)) Mux1(
		.in1(ALUOut), 
		.in2(DataMemoryOut), 
		.sel(MEM_R_EN), 
		.out(RegisterFileWriteData)
	);


endmodule