
module statusRegister(S, newStatus, result);
	input S;
	input[3:0] newStatus;
	output[3:0] result;

	reg[3:0] currStatus;

	always @(S, newStatus) begin 
		currStatus = 0;
		if (S) begin currStatus = newStatus; end
	end

	assign result = currStatus;
endmodule