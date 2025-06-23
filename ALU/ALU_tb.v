`include "ALU.v"
module ALU_tb;
reg [31:0] a,b;
reg [3:0] alu_control;
wire [31:0] alu_result;

ALU uut (.a(a), .b(b), .alu_control(alu_control), .alu_result(alu_result));

initial begin 

  $dumpfile ("alu_wave.vcd");
  $dumpvars (0, ALU_tb);
  a = 32'd5;
  b = 32'd10;
  alu_control = 4'b0000;
  #10;

  $display ("ADD: %0d + %0d = %0d", a,b,alu_result);

  a = 12; b = 7; alu_control = 4'b0001; #10;
  $display ("SUB: %0d - %0d = %0d", a,b,alu_result);

  $finish;
end
endmodule
