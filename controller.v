module controller (clock, opcode, statusUpdate, mode, controllerOut);
	input clock;
	input[3:0]opcode;
	input statusUpdate;
	input[1:0]mode;
	output [8:0]controllerOut; //4bits for execute command, 5bits for other 1bit signals
	reg[3:0] exeCommand;
	reg memWEn, memWBEn, memREn, branch, statusEnOut;  

	always @(opcode, statusUpdate, mode) begin
		memWEn = 1'b 0;
		memWBEn = 1'b 0;
		memREn = 1'b 0;
		branch = 1'b 0;
		statusEnOut = statusUpdate;

		case(mode)
			2'b 00: begin //arithmetic
				case (opcode)
					4'b 1101: begin //MOV
						exeCommand = 4'b 0001;
						memWBEn = 1'b 1;
					end
					4'b 1111: begin //MVN
						exeCommand = 4'b 1001;
						memWBEn = 1'b 1;
					end
					4'b 0100: begin //ADD
						exeCommand = 4'b 0010;
						memWBEn = 1'b 1;
					end
					4'b 0101: begin //ADC
						exeCommand = 4'b 0011;
						memWBEn = 1'b 1;
					end
					4'b 0010: begin //SUB
						exeCommand = 4'b 0100;
						memWBEn = 1'b 1;
					end
					4'b 0110: begin //SBC
						exeCommand = 4'b 0101;
						memWBEn = 1'b 1;
					end
					4'b 0000: begin //AND
						exeCommand = 4'b 0110;
						memWBEn = 1'b 1;
					end
					4'b 1100: begin //ORR
						exeCommand = 4'b 0111;
						memWBEn = 1'b 1;
					end
					4'b 0001: begin //EOR
						exeCommand = 4'b 1000;
						memWBEn = 1'b 1;
					end
					4'b 1010: begin //CMP
						exeCommand = 4'b 0100;
						statusEnOut = 1'b 1;
					end
					4'b 1000: begin //TST
						exeCommand = 4'b 0110;
						statusEnOut = 1'b 1;
					end	
				endcase // opcode
			end
			2'b 01: begin //memory
				if(statusUpdate==1'b 1)begin exeCommand<=4'b 0010; statusEnOut=1'b 1; memREn=1'b 1; memWBEn=1'b 1; end
				if(statusUpdate==1'b 0)begin exeCommand<=4'b 0010; memWEn=1'b 1; end
			end	
			2'b 10: begin //branch
				branch = 1'b 1;
			end 
		endcase // mode
	end
	assign controllerOut = {memWBEn, memREn, memWEn, exeCommand, branch, statusEnOut};
endmodule
