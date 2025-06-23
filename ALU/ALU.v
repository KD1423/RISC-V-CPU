module ALU (
    input [31:0] a,b ,
    input [3:0] alu_control,
    output reg [31:0] alu_result);

    always@(*) begin
    case(alu_control)
      4'b0000 : alu_result = a + b;
      4'b0001 : alu_result = a - b;
      4'b0010 : alu_result = a & b;
      4'b0011 : alu_result = a | b;
      4'b0100 : alu_result = a ^ b; 
      4'b0101 : alu_result = a < b;
      4'b0110 : alu_result = a << b[4:0];
      4'b0111 : alu_result = a >> b[4:0];
      default : alu_result = 32'b0;

    endcase 
    end
endmodule 


