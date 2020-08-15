
module val2Generator(RMVal, Imm, ShiftOperand, LdOrStr, result);
	input[31:0] RMVal;
	input Imm, LdOrStr;
	input[11:0] ShiftOperand;
	output reg[31:0] result;
  
  
  integer i;
	always @(*) begin
		
		result <= 32'b 0;
		if (LdOrStr) begin result <= { {20{ShiftOperand[11]}}, ShiftOperand }; end
		else begin
			if (Imm) begin
				result <= { {24{ShiftOperand[7]}}, ShiftOperand[7:0] }; //sign extend
				for (i = 0; i < ShiftOperand[11:8]; i=i+1) begin
					result <= { result[1],result[0],result[31:2] }; //rotate 2 bits to right
				end
			end
			else if(ShiftOperand[4] == 0) begin
				case (ShiftOperand[6:5])
					2'b 00: begin //Logical shift left
						result <= { RMVal[30:0],1'b 0 };
					end
					2'b 01: begin //logical shift right
						result <= { 1'b 0,RMVal[31:1] };
					end
					2'b 10: begin //Arithmetic shift right
						result <= { RMVal[31],RMVal[31:1] };
					end
					2'b 11: begin //Rotate right
						result <= { RMVal[0],RMVal[31:1] };
					end 
				endcase
			end
		end
	end 

endmodule