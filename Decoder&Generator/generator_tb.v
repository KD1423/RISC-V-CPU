`include "generator.v"

module generator_tb;
    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;
    wire [3:0] alu_control;


generator uut (.opcode(opcode), .funct3(funct3), .funct7(funct7), .alu_control(alu_control));

initial begin

opcode = 7'b0110011;
funct3 = 3'b000;
funct7 = 7'h20;

#10 

if (alu_control == 4'b1111) begin
        $display(" Invalid instruction detected, alu_control = 1111");
    end else begin
        $display(" Valid instruction. alu_control = %b", alu_control);
    end
$finish;
end
endmodule