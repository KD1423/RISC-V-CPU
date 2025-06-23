module register (
    input clk, 
    input [4:0] r1_address, r2_address, rd_address, 
    input [31:0] rd_data_in,
    input rd_write_enb,
    output [31:0] r1_out, r2_out
);
reg [31:0] regs [31:0];

integer i;
initial begin
    for (i = 1; i < 32; i = i + 1)
        regs[i] = 32'd3;
end 
assign r1_out = (r1_address == 5'd0) ? 32'd0 : regs[r1_address];
assign r2_out = (r2_address == 5'd0) ? 32'd0 : regs[r2_address];

always @(posedge clk) begin
   if (rd_write_enb && rd_address != 5'd0)
      regs[rd_address] <= rd_data_in;
end

endmodule
   