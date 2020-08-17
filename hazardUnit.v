module hazardUnit(src1, src2, TwoSrc, MEM_Dest, MEM_WB_EN, EXE_Dest, EXE_WB_EN, Hazard );
	input[3:0] src1, src2;
	input TwoSrc;
	input[3:0] MEM_Dest, EXE_Dest;
	input MEM_WB_EN, EXE_WB_EN;		
	output reg Hazard;

	always @(src1, src2, TwoSrc, MEM_Dest, EXE_Dest, MEM_WB_EN, EXE_WB_EN) begin
		Hazard = 0;
		if ((EXE_WB_EN==1 && (src1==EXE_Dest)) || 
					(MEM_WB_EN==1 && (src1==MEM_Dest)) || 
					(EXE_WB_EN==1 && TwoSrc && (src2==EXE_Dest)) || 
					(MEM_WB_EN==1 && TwoSrc && (src2==MEM_Dest))) begin
			Hazard = 1;
		end
		else begin
			Hazard = 0;
		end
	end
	// assign Hazard = ((EXE_WB_EN==1 && (src1==EXE_Dest)) || 
	// 				(MEM_WB_EN==1 && (src1==MEM_Dest)) || 
	// 				(EXE_WB_EN==1 && TwoSrc && (src2==EXE_Dest)) || 
	// 				(MEM_WB_EN==1 && TwoSrc && (src2==MEM_Dest))) ?1:0; 
	
endmodule