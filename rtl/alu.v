module alu(a_in, b_in, op_in, clock, result_out);

// declaration of the inputs
input [7:0] a_in;
input [7:0] b_in;
input [2:0] op_in;
input clock;

// declaration of the output
output reg [15:0] result_out;

// combinational logic for ALU operations
always @(posedge clock) begin
    case (op_in)
        3'b000: result_out = a_in + b_in;        // Addition
        3'b001: result_out = a_in - b_in;        // Subtraction
        3'b010: result_out = a_in & b_in;        // Bitwise AND
        3'b011: result_out = a_in | b_in;        // Bitwise OR
        3'b100: result_out = a_in ^ b_in;        // Bitwise XOR
        3'b101: result_out = ~a_in;              // Bitwise NOT of a_in
        3'b110: result_out = a_in << 1;          // Left Shift
        3'b111: result_out = a_in >> 1;          // Right Shift
        default: result_out = 16'b0;              // Default
    endcase
end

endmodule
