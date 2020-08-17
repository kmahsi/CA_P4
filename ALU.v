
module ALU(inputA, inputB, exeCommand, carryIn, result, statusOut);
	input[31:0] inputA, inputB;
	input[3:0] exeCommand;
	input carryIn;
	output reg[31:0] result;
	output[3:0] statusOut;

	reg negative, zero, carry, overflow;

	always @(inputA, inputB, exeCommand, carryIn) begin
		result = 32'b 0;
		negative = 1'b 0;
		zero = 1'b 0;
		carry = 1'b 0;
		overflow = 1'b 0;

		case(exeCommand)
			4'b 0001: begin result = inputB; end//MOV
			4'b 1001: begin result = ~inputB; end//MVN
			4'b 0010: begin {carry,result} = inputA + inputB; end//ADD
			4'b 0011: begin {carry,result} = inputA + inputB + carryIn;end //ADC
			4'b 0100: begin {carry,result} = inputA - inputB; end//SUB
			4'b 0101: begin {carry,result} = inputA - inputB - ~carryIn; end//SBC
			4'b 0110: begin result = inputA & inputB; end//AND
			4'b 0111: begin result = inputA | inputB; end//ORR
			4'b 1000: begin result = inputA ^ inputB; end//EOR
			4'b 0100: begin {carry,result} = inputA - inputB; end//CMP
			4'b 0110: begin result = inputA & inputB; end//TST
			4'b 0010: begin {carry,result} = inputA + inputB; end//LDR, STR
		endcase	
		zero = result == 32'b 0;
		negative = result[31];
		overflow = (inputA[31] && inputB[31] && ~negative) || (~inputA[31] && ~inputB[31] && negative);
	end

	assign statusOut = {negative,zero,carry,overflow};

endmodule 
