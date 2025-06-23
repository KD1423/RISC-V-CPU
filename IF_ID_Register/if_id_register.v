module if_id_reg (
    input clk,
    input reset,
    input [31:0] instr_in_if,
    input [31:0] pc_in_if,
    output reg [31:0] instr_out_if,
    output reg [31:0] pc_out_if
);

always@(posedge clk or posedge reset) begin

    if (reset) begin
        pc_out_if <= 0;
        instr_out_if <= 0;
    end

    else begin
        instr_out_if <= instr_in_if;
        pc_out_if <= pc_in_if; 
    end
end
endmodule

