module MEM_WB_pipeline(clk, rst, MEM_WB_ENIn, MEM_R_ENIn, ALUResIn, DataMemResIn, DestIn, MEM_WB_ENOut, MEM_R_ENOut, ALUResOut,
						DataMemResOut, DestOut);
	input clk, rst, MEM_WB_ENIn, MEM_R_ENIn;
	input[31:0] ALUResIn, DataMemResIn;
	input[3:0] DestIn;
	output reg MEM_WB_ENOut, MEM_R_ENOut;
	output reg[31:0] ALUResOut, DataMemResOut;
	output reg[3:0] DestOut;

	registerWithNegEdge  #(.size(68)) Reg(
		.clock(clk), 
		.reset(rst), 
		.regIn({MEM_WB_ENIn,MEM_R_ENIn,ALUResIn,DataMemResIn,DestIn}), 
		.regOut({MEM_WB_ENOut,MEM_R_ENOut,ALUResOut,DataMemResOut,DestOut})
	);
endmodule
