`include "decoder.v"

module decoder_tb;
    reg [31:0] instruction;
    wire [6:0] opcode;
    wire [4:0]  rd;
    wire [2:0]  funct3;
    wire [4:0]  rs1;
    wire [4:0]  rs2;
    wire [6:0]  funct7;
    wire [31:0] imm;

decoder uut (.instruction(instruction), .opcode(opcode), .rd(rd), .funct3(funct3), .rs1(rs1),
 .rs2(rs2), .funct7(funct7), .imm(imm));

initial begin
   $dumpfile ("decoder.vcd");
   $dumpvars (0, decoder_tb);
instruction = 32'h0040A283;

#10 

$display ("opcode: %h", opcode);
$finish;
end
endmodule