`include "PC.v"

module pc_tb;
    reg clk;
    reg reset;
    wire [31:0] pc_out;

    pc uut (.clk(clk), .reset(reset), .pc_out(pc_out));

    always #5 clk = ~clk;
    initial begin 

        //$dumpfile("pc_wave.vcd");
        $dumpvars(0, pc_tb);

        reset = 1;
        clk = 0;

        #10

        $display("pc is at - %h", pc_out); 

        reset = 0;
        #10
        $display("pc is at - %h", pc_out); 

        #10
        $display("pc is at - %h", pc_out); 

        $finish;
    end
endmodule
    