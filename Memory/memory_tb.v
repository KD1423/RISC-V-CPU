`include "memory.v"
module memory_tb;

    reg clk;
    reg [9:0] mem_addrs;
    reg mem_read;
    reg mem_write;
    reg [31:0] write_data;
    wire [31:0] read_data;

    memory mem_inst (
        .clk(clk),
        .mem_addrs(mem_addrs),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("memory.vcd");
        $dumpvars(0,memory_tb);
        clk = 0;

        // Initial values
        mem_addrs = 10'd0;
        mem_read = 0;
        mem_write = 0;
        write_data = 32'd0;

        // WRITE: Store 12345678 at address 10
        #2;
        mem_addrs = 10'd10;
        write_data = 32'h12345678;
        mem_write = 1;
        #10;
        mem_write = 0;

        // READ: Read from address 10
        #2;
        mem_read = 1;
        #1;
        $display("Read data from addr 10: %h", read_data);
        mem_read = 0;

        // WRITE: Store deadbeef at address 20
        #2;
        mem_addrs = 10'd20;
        write_data = 32'hDEADBEEF;
        mem_write = 1;
        #10;
        mem_write = 0;

        // READ: Read from address 20
        #2;
        mem_addrs = 10'd20;
        mem_read = 1;
        #1;
        $display("Read data from addr 20: %h", read_data);
        mem_read = 0;

        $finish;
    end

endmodule
