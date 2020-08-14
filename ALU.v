
module ALU(inputA, inputB, exeCommand, carryIn, result, statusOut);
	input[31:0] inputA, inputB;
	input[3:0] exeCommand;
	input carryIn;
	output reg[31:0] result;
	output[3:0] statusOut;

	reg negative, zero, carry, overflow;

	always @(*) begin
		result <= 32'b 0;
		negative <= 1'b 0;
		zero <= 1'b 0;
		carry <= 1'b 0;
		overflow <= 1'b 0;

		case(exeCommand)
			4'b 0001: result = inputB; //MOV
			4'b 1001: result = ~inputB; //MVN
			4'b 0010: {carry,result} = inputA + inputB; //ADD
			4'b 0011: {carry,result} = inputA + inputB + carryIn; //ADC
			4'b 0100: {carry,result} = inputA - inputB; //SUB
			4'b 0101: {carry,result} = inputA - inputB - 1; //SBC
			4'b 0110: result = inputA & inputB; //AND
			4'b 0111: result = inputA | inputB; //ORR
			4'b 1000: result = inputA ^ inputB; //EOR
			4'b 0100: {carry,result} = inputA - inputB; //CMP
			4'b 0110: result = inputA & inputB; //TST
			4'b 0010: {carry,result} = inputA + inputB; //LDR, STR
		endcase	
		zero <= result == 32'b 0;
		negative <= result[31];
		overflow <= (inputA[31] && inputB[31] && ~negative) || (~inputA[31] && ~inputB[31] && negative);
	end

	assign statusOut = {negative,zero,carry,overflow};

endmodule 
