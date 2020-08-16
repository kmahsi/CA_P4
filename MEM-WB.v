module MEM_WB_pipeline(clk, rst, MEM_WB_ENIn, MEM_R_ENIn, ALUResIn, DataMemResIn, DestIn, MEM_WB_ENOut, MEM_R_ENOut, ALUResOut,
						DataMemResOut, DestOut);
	input clk, rst, MEM_WB_ENIn, MEM_R_ENIn;
	input[31:0] ALUResIn, DataMemResIn;
	input[3:0] DestIn;
	output MEM_WB_ENOut, MEM_R_ENOut;
	output [31:0] ALUResOut, DataMemResOut;
	output [3:0] DestOut;

	register  #(.size(70)) Reg(
		.clock(clk), 
		.reset(rst), 
		.regIn({MEM_WB_ENIn,MEM_R_ENIn,ALUResIn,DataMemResIn,DestIn}), 
		.regOut({MEM_WB_ENOut,MEM_R_ENOut,ALUResOut,DataMemResOut,DestOut})
	);
endmodule
