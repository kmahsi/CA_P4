module registerFile(clock, regWrite, writeRegister, writeData, readRegister1, readRegister2, readData1, readData2);
  input clock, regWrite;
  input [2:0] readRegister1, readRegister2, writeRegister;
  input [7:0] writeData;
  output [7:0] readData2, readData1;

  reg[7:0] registers[7:0]; 
  assign readData1 = registers[readRegister1];
  assign readData2 = registers[readRegister2];

  always @(posedge clock, negedge clock) begin
    if (regWrite)begin
      if(writeRegister != 0) registers[writeRegister] <= writeData;
    end
    registers[0] = 0;
  end

endmodule