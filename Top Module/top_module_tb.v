//`include "Top Module\top_module.v"

module top_module_tb;
reg clk;
reg reset;
wire [31:0] write_back_data;
wire [31:0] mem_read_data;
reg [4:0] prev_rd;
wire [31:0] rd_data_in;
wire [31:0] data_stored_in_rd;

top_module uut (.clk(clk), .reset(reset), .write_back_data(write_back_data), .mem_read_data(mem_read_data), .rd_data_in(rd_data_in), .data_stored_in_rd(data_stored_in_rd));

    initial begin
        clk = 0;
        uut.mem_instan.mem[3] = 32'hDEADBEEF;  // address 20 (5 × 4)
        uut.mem_instan.mem[6] = 32'hCAFEBABE;  // address 24 (6 × 4)

        forever #5 clk = ~clk;
    end

    initial begin
    reset = 1;
    #3 reset = 0;  
    end

    task print_values;
    begin 
        //#5.3;
        /*#1;
        $display("Instruction from instr_memory = %h", uut.instruction_wire);
        $display("Instruction fetched from IF_out = %h", uut.instr_wire_out_if);

        $display("New Address from PC = %h", uut.addr_from_pc_wire);
        $display("Write back data = %h", write_back_data);

        $display("Register x8 = %h", uut.regt.regs[8]);   */

        #1; 
        prev_rd = uut.rd;

        @(posedge clk);

        #1;
        $display("---------------------------------------------");
        $display("Address from PC = %h", uut.addr_from_pc_wire);
        $display("Instruction from instr_memory = %h", uut.instruction_wire);

        $display("Actual Instruction fetched from IF_out = %h", uut.instr_wire_out_if);

        $display("o/p from Decoder : Opcode = %b, Funct3 = %b, Funct7 = %b, rd = %b, rs1 = %b, rs2 = %b, imm = %h    (Gets stored in ID_EX)"
        , uut.opcode_wire, uut.funct3_wire, uut.funct7_wire, uut.rd_wire, uut.rs1_wire, uut.rs2_wire, uut.imm_wire);

        $display("o/p from ID_EX register : Opcode = %b, Funct3 = %b, Funct7 = %b, rd = %b, rs1 = %b, rs2 = %b, imm = %h   (Decoded values for the previous instruction fetched)"            
        , uut.opcode, uut.funct3, uut.funct7, uut.rd, uut.rs1, uut.rs2, uut.imm);

        $display("r1_out from register x%0d= %h", uut.rs1, uut.r1_out);
        $display("r2_out from register x%0d = %h", uut.rs2, uut.r2_out);

        $display("ALU control = %b", uut.alu_control);

        $display("ALU result = %h", uut.alu_result);

        $display("Read data from memory = %h", mem_read_data);
        $display("Write back data = %h", write_back_data);

        //prev_rd = uut.rd;
        //$display("Initial Value in Register x%0d = %h", uut.rd, uut.regt.regs[uut.rd]);
        //#10;
        //@(posedge clk);
        //#1;
        $display("Updated Register (based on previous to previous instruction) x%0d = %h", prev_rd, uut.regt.regs[prev_rd]);
        $display("Register x8 = %h", uut.regt.regs[8]);
        $display("Register x5 = %h", uut.regt.regs[5]);

        $display("---------------------------------------------");
    end
    endtask

    initial begin

        $dumpfile("top_module.vcd");
        $dumpvars(0,top_module_tb);

        print_values();
        print_values();
        print_values();
        print_values();
        print_values();
#4;
        $display("Value at memory address 23 = %h", uut.mem_instan.mem[23]);


#5;
        $finish;


       /* @(posedge clk);
        #1;
        $display("---------------------------------------------");
        $display("Address from PC = %h", uut.addr_from_pc);

        $display("Instruction fetched = %h", uut.instruction_wire);

        $display("Opcode = %b, Funct3 = %b, Funct7 = %b, rd = %b, rs1 = %b, rs2 = %b, imm = %h"
        , uut.opcode, uut.funct3, uut.funct7, uut.rd, uut.rs1, uut.rs2, uut.imm);

        $display("r1_out from register x%0d= %h", uut.rs1, uut.r1_out);
        $display("r2_out from register x%0d = %h", uut.rs2, uut.r2_out);

        $display("ALU control = %b", uut.alu_control);

        $display("ALU result = %h", uut.alu_result);

        $display("Read data from memory = %h", mem_read_data);
        $display("Write back data = %h", write_back_data);

        $display("Value in Register x%0d = %h", uut.rd, uut.regt.regs[uut.rd]);

        $display("---------------------------------------------");

        $finish; */
    end
endmodule
