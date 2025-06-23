module decoder (
    input [31:0] dec_instruction,
    output [6:0] opcode_dec,
    output [4:0]  rd_dec,
    output [2:0]  funct3_dec,
    output [4:0]  rs1_dec,
    output [4:0]  rs2_dec,
    output [6:0]  funct7_dec,
    output reg [31:0] imm_dec

);

assign opcode_dec = dec_instruction[6:0];
assign rd_dec     = dec_instruction[11:7];
assign funct3_dec = dec_instruction[14:12];
assign rs1_dec    = dec_instruction[19:15]; 
assign rs2_dec    = dec_instruction[24:20];
assign funct7_dec = dec_instruction[31:25];

always@(*) begin
    
    case(opcode_dec)
       7'b0000011, 7'b0010011, 7'b1100111 : imm_dec = {{20{dec_instruction[31]}}, dec_instruction[31:20]};   //lw, I-type
       7'b0100011 : imm_dec = {{20{dec_instruction[31]}}, dec_instruction[31:25], dec_instruction[11:7]}; //sw, S-type
       default : imm_dec = 32'b0;
    endcase
end

endmodule
