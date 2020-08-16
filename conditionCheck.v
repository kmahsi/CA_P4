`define OVERFLOW 0
`define CARRY 1 
`define ZERO 2
`define NEGATIVE 3

module ConditionCheck(Cond, Status, result);
	input[3:0] Cond, Status;
	output reg result;

	always @(*) begin
		case (Cond)
			4'b 0000: begin
				result = Status[`ZERO];
			end
			4'b 0001: begin
				result = ~Status[`ZERO];
			end
			4'b 0010: begin
				result = Status[`CARRY];
			end
			4'b 0011: begin 
				result = ~Status[`CARRY];
			end
			4'b 0100: begin 
				result = Status[`NEGATIVE];
			end
			4'b 0101: begin 
				result = ~Status[`NEGATIVE];
			end
			4'b 0110: begin 
				result = Status[`OVERFLOW];
			end
			4'b 0111: begin 	
				result = ~Status[`OVERFLOW];
			end
			4'b 1000: begin 
				result = Status[`CARRY] && ~Status[`ZERO];
			end
			4'b 1001: begin 
				result = ~Status[`CARRY] && Status[`ZERO];
			end
			4'b 1010: begin 
				result = Status[`NEGATIVE]==Status[`OVERFLOW];
			end
			4'b 1011: begin 
				result = Status[`NEGATIVE]!=Status[`OVERFLOW];
			end
			4'b 1100: begin
				result = ~Status[`ZERO] && (Status[`NEGATIVE] == Status[`OVERFLOW]);
			end
			4'b 1101: begin 
				result = Status[`ZERO] || (Status[`NEGATIVE] != Status[`OVERFLOW]);
			end
			4'b 1110: begin
				result = 1;
			end
		endcase
	end
endmodule