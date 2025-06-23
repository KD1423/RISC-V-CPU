module pc (
    input clk,
    input reset ,
    output reg [31:0] pc_out
) ;

always@(posedge clk or posedge reset) begin
    if (reset) begin
        pc_out <= 0;
    end

    else begin
        pc_out <= pc_out + 32'd4;
    end
end
endmodule
