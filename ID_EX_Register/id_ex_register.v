module id_ex_reg (
    input clk,
    input reset,
    input [6:0] opcode_in,
    input [4:0]  rd_in,
    input [2:0]  funct3_in,
    input [4:0]  rs1_in,
    input [4:0]  rs2_in,
    input [6:0]  funct7_in,
    input [31:0] imm_in,

    output reg [6:0] opcode_out,
    output reg [4:0]  rd_out,
    output reg [2:0]  funct3_out,
    output reg [4:0]  rs1_out,
    output reg [4:0]  rs2_out,
    output reg [6:0]  funct7_out,
    output reg [31:0] imm_out

);

always @(posedge clk) begin
    if (reset) begin
        opcode_out <= 0;
        rd_out <= 0;
        funct3_out <= 0;
        rs1_out <= 0;
        rs2_out <= 0;
        funct7_out <= 0;
        imm_out <= 0;
    end

    else begin
        opcode_out <= opcode_in;
        rd_out <= rd_in;
        funct3_out <= funct3_in;
        rs1_out <= rs1_in;
        rs2_out <= rs2_in;
        funct7_out <= funct7_in;
        imm_out <= imm_in;      
    end
end


endmodule