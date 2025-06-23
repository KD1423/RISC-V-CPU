module instr_mem (
    input [31:0] addr_from_pc,
    output [31:0] instruction

);

reg [31:0] i_mem [255:0]; 

initial begin
    i_mem[0] = 32'h00016183;
    i_mem[1] = 32'h00A00293;        //h00A00293
    i_mem[2] = 32'h00730433;
    i_mem[3] = 32'h02312023;
    i_mem[4] = 32'h02312023;

end

assign instruction = i_mem[addr_from_pc[9:2]];

endmodule