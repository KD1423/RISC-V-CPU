`include "instr_memory.v"

module instr_memory_tb;
    reg [31:0] addr_from_pc;
    wire [31:0] instruction;

    instr_mem uut (.addr_from_pc(addr_from_pc), .instruction(instruction));

    initial begin 

        /*uut.i_mem[0] = 32'hDEACAEEF;
        uut.i_mem[1] = 32'h12345678;
        uut.i_mem[2] = 32'hAABBCCDD;*/
        
        // Fetch at address 0
        addr_from_pc = 32'd0;
        #1 $display("Instruction at 0 = %h", instruction);  // DEACAEEF

        // Fetch at address 1
        addr_from_pc = 32'd4;
        #1 $display("Instruction at 1 = %h", instruction);  // 12345678

        // Fetch at address 2
        addr_from_pc = 32'd8;
        #1 $display("Instruction at 2 = %h", instruction);  // AABBCCDD

        $finish;
    end

endmodule

        