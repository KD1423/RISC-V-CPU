module top_module (
    input clk,
    input reset,
    output [31:0] write_back_data,
    output [31:0] mem_read_data,
    output [31:0] rd_data_in,
    output [31:0] data_stored_in_rd

);

wire [31:0] instruction_wire;
wire [31:0] instr_wire_out_if;
wire [31:0] pc_wire_out_if;

//assign instruction =  32'h00A506B3;
//assign instruction = 32'h00428303;
wire [6:0] opcode;
wire [4:0]  rd;
wire [2:0]  funct3;
wire [4:0]  rs1;
wire [4:0]  rs2;
wire [6:0]  funct7;
wire [3:0] alu_control;
wire [31:0] alu_result;
wire [31:0] imm;
wire [31:0] mem_data_internal;

wire [6:0] opcode_wire;
wire [4:0]  rd_wire;
wire [2:0]  funct3_wire;
wire [4:0]  rs1_wire;
wire [4:0]  rs2_wire;
wire [6:0]  funct7_wire;
wire [31:0] imm_wire;


wire [31:0] a, b;
wire [31:0] r1_out, r2_out;

//assign alu_result_out = alu_result;

wire use_imm;
assign use_imm = (opcode == 7'b0010011 || opcode == 7'b0000011 || opcode == 7'b0100011);
wire [31:0] alu_b;
assign alu_b = (use_imm) ? imm : r2_out; 


wire [31:0] addr_from_pc_wire;
wire [31:0] pc_out;
//assign addr_from_pc = 32'd8; 

pc pc_inst (.clk(clk), .reset(reset), .pc_out(addr_from_pc_wire));

instr_mem IM (.addr_from_pc(addr_from_pc_wire), .instruction(instruction_wire));

if_id_reg if_id_instn (.clk(clk), .reset(reset), .instr_in_if(instruction_wire), 
.pc_in_if(addr_from_pc_wire), .instr_out_if(instr_wire_out_if), .pc_out_if(pc_wire_out_if));

decoder dec (.dec_instruction(instr_wire_out_if), .opcode_dec(opcode_wire), .rd_dec(rd_wire), .funct3_dec(funct3_wire), .rs1_dec(rs1_wire),
             .rs2_dec(rs2_wire), .funct7_dec(funct7_wire), .imm_dec(imm_wire)); 

id_ex_reg id_ex_inst (.clk(clk), .reset(reset), .opcode_in(opcode_wire), .rd_in(rd_wire), .funct3_in(funct3_wire), .rs1_in(rs1_wire),
             .rs2_in(rs2_wire), .funct7_in(funct7_wire), .imm_in(imm_wire),  
             .opcode_out(opcode), .rd_out(rd), .funct3_out(funct3), .rs1_out(rs1),
             .rs2_out(rs2), .funct7_out(funct7), .imm_out(imm));

generator gen (.opcode(opcode), .funct3(funct3), .funct7(funct7), .alu_control(alu_control));


ALU alu (.a(r1_out), .b(alu_b), .alu_control(alu_control), .alu_result(alu_result));


register regt (.clk(clk), .r1_address(rs1), .r2_address(rs2),
              .rd_address(rd), .rd_data_in(write_back_data),
              .rd_write_enb(opcode == 7'b0000011 || opcode == 7'b0110011 || opcode == 7'b0010011), .r1_out(r1_out), .r2_out(r2_out));

memory mem_instan (.clk(clk), .mem_addrs(alu_result[9:0]),
         .mem_read(opcode == 7'b0000011), .mem_write(opcode == 7'b0100011),
        .write_data(r2_out), .read_data(mem_data_internal)); 


assign mem_read_data = mem_data_internal; // this line is new
assign write_back_data = (opcode == 7'b0000011) ? mem_read_data : alu_result;

reg [4:0] prev_rd;

always @(posedge clk or posedge reset) begin
    if (reset)
        prev_rd <= 0;
    else
        prev_rd <= rd;  // Capture rd for previous instruction
end


assign data_stored_in_rd = regt.regs[prev_rd]; 
endmodule
