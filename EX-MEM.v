module EX_MEM_pipeline(clk, rst, MEM_WB_ENIn, MEM_R_ENIn, MEM_W_ENIn, ALUResIn, RMValIn, DestIn, MEM_WB_ENOut, MEM_R_ENOut,
						MEM_W_ENOut, ALUResOut, RMValOut, DestOut);
	input clk, rst, MEM_WB_ENIn, MEM_R_ENIn, MEM_W_ENIn;
	input[31:0] ALUResIn, RMValIn;
	input[3:0] DestIn;
	output MEM_WB_ENOut, MEM_R_ENOut, MEM_W_ENOut;
	output [31:0] ALUResOut, RMValOut;
	output [3:0] DestOut;

	register  #(.size(71)) Reg(
		.clock(clk), 
		.reset(rst), 
		.regIn({MEM_WB_ENIn,MEM_R_ENIn,MEM_W_ENIn,ALUResIn,RMValIn,DestIn}), 
		.regOut({MEM_WB_ENOut,MEM_R_ENOut,MEM_W_ENOut,ALUResOut,RMValOut,DestOut})
	);

endmodule

