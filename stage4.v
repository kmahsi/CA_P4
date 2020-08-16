module stage4(clk, MEM_R_EN, MEM_W_EN, ALUOut, RMVal, dataMemOut);
	input clk, MEM_R_EN, MEM_W_EN;
	input[31:0] ALUOut, RMVal;
	output[31:0] dataMemOut;
	
	
	dataMemory DM(
		.clock(clk), 
		.memWrite(MEM_W_EN), 
		.address(ALUOut), 
		.data(RMVal), 
		.out(dataMemOut)
	);

endmodule