module registerFile(clock, regWrite, writeRegister, writeData, readRegister1, readRegister2, readData1, readData2);
  input clock, regWrite;
  input [3:0] readRegister1, readRegister2, writeRegister;
  input [31:0] writeData;
  output [31:0] readData2, readData1;

  reg[31:0] registers[15:0]; 
  assign readData1 = registers[readRegister1];
  assign readData2 = registers[readRegister2];

  always @(posedge clock, negedge clock) begin
    if (regWrite)begin
      registers[writeRegister] <= writeData;
    end
  end

endmodule