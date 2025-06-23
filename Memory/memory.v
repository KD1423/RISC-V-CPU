module memory ( 
    input clk,
    input [9:0] mem_addrs,
    input mem_read,
    input mem_write,
    input [31:0] write_data,
    output reg [31:0] read_data
);

reg [31:0] mem [1023:0];

always @(posedge clk) begin

    if (mem_write)
       mem[mem_addrs] <= write_data;
end

always@(*) begin
    
    if (mem_read)
       read_data = mem[mem_addrs];
    else
       read_data = 32'b0;
       
end

endmodule
