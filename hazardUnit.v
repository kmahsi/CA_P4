module hazardUnit(src1, src2, TwoSrc, MEM_Dest, MEM_WB_EN, EXE_Dest, EXE_WB_EN, Hazard );
	input[3:0] src1, src2;
	input TwoSrc;
	input[3:0] MEM_Dest, EXE_Dest;
	input MEM_WB_EN, EXE_WB_EN;		
	output reg Hazard;

	always @(*) begin
		Hazard <= (EXE_WB_EN && (src1==EXE_Dest)) || 
					(MEM_WB_EN && (src1==MEM_Dest)) || 
					(EXE_WB_EN && TwoSrc && (src2==EXE_Dest)) || 
					(MEM_WB_EN && TwoSrc && (src2==MEM_Dest)); 
	end
endmodule