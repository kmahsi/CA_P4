module stage4(clk, MEM_WB_EN, MEM_R_EN, MEM_W_EN, ALUOut, RMVal, DestIn, dataMemOut, MEM_WB_ENOut, MEM_R_ENOut, DestOut);
	input clk, MEM_WB_EN, MEM_R_EN, MEM_W_EN;
	input[31:0] ALUOut, RMVal;
	input[3:0] DestIn;
	output[31:0] dataMemOut;
	output MEM_WB_ENOut, MEM_R_ENOut;
	output[3:0] DestOut;
	
	assign MEM_WB_ENOut = MEM_WB_EN;
	assign MEM_R_ENOut = MEM_R_EN;
	assign DestOut = DestIn;
	
	dataMemory DM(
		.clock(clk), 
		.memWrite(MEM_W_EN), 
		.address(ALUOut), 
		.data(RMVal), 
		.out(dataMemOut)
	);

endmodule