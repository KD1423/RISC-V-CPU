module generator (
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] alu_control
);

always @(*) begin
    case (opcode)
        7'b0110011: begin // R-type instructions
            case ({funct7, funct3})
                10'b0000000000: alu_control = 4'b0000; // ADD
                10'b0100000000: alu_control = 4'b0001; // SUB
                10'b0000000111: alu_control = 4'b0010; // AND
                10'b0000000110: alu_control = 4'b0011; // OR
                10'b0000000100: alu_control = 4'b0100; // XOR
                10'b0000000010: alu_control = 4'b0101; // SLT (Set Less Than)
                10'b0000000001: alu_control = 4'b0110; // SLL (Shift Left Logical)
                10'b0000000101: alu_control = 4'b0111; // SRL (Shift Right Logical)
                default: alu_control = 4'b1111;  // Invalid funct3/funct7 combination
            endcase
        end

        7'b0010011: begin // I-type instructions ( ADDI, ANDI, ORI, XORI etc.)
            case (funct3)
                3'b000: alu_control = 4'b0000; // ADDI
                3'b111: alu_control = 4'b0010; // ANDI
                3'b110: alu_control = 4'b0011; // ORI
                3'b100: alu_control = 4'b0100; // XORI
                default: alu_control = 4'b1111; // Invalid funct3 value
            endcase
        end

        7'b0000011: alu_control = 4'b0000;  //lw
        7'b0100011: alu_control = 4'b0000; //sw 

        default: alu_control = 4'b1111; // Default for unrecognized opcode
    endcase
end

endmodule