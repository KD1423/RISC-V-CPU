`include "register.v"
module register_tb;
    reg clk;
    reg [4:0] r1_address, r2_address, rd_address;
    reg [31:0] rd_data_in;
    reg rd_write_enb;
    wire [31:0] r1_out, r2_out;

register uut (.clk(clk), .r1_address(r1_address), .r2_address(r2_address),
              .rd_address(rd_address), .rd_data_in(rd_data_in),
              .rd_write_enb(rd_write_enb), .r1_out(r1_out), .r2_out(r2_out));

always #5 clk = ~clk;

initial begin
   $dumpfile ("register.vcd");
   $dumpvars (0, register_tb);

   clk= 0;
   r1_address = 0;
   r2_address = 0;
   rd_address = 0;
   rd_data_in = 0;
   rd_write_enb = 0;


   #10;
   rd_address = 5'd5;
   rd_data_in = 32'hDEADBEEF;
   rd_write_enb = 1'b1;


   #7;
   rd_write_enb = 0;

   r1_address = 5'd5;

   #10;

   $display ("Register x5 : %h", r1_out);

   #10;
   $finish;

end

endmodule



    
    