module Serializer (
    input wire clk,
    input wire rst,
    input wire load,
    input wire shift,
    input wire [7:0] p_input,
    output reg serial_bit,
    output reg done
);

    reg [7:0] shift_reg;
    reg [2:0] bit_counter;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            shift_reg   <= 8'b0;
            serial_bit  <= 1'b0;
            bit_counter <= 3'b0;
            done        <= 1'b0;
        end else begin
            if (load) begin
                shift_reg   <= p_input;
                bit_counter <= 3'b0;
                done        <= 1'b0;
                serial_bit  <= p_input[0];
            end else if (shift) begin
                serial_bit <= shift_reg[0];
                shift_reg <= {1'b0, shift_reg[7:1]};
                if (bit_counter == 3'd7) begin
                    done <= 1'b1;
                    bit_counter <= bit_counter;
                end else begin
                    bit_counter <= bit_counter + 1;
                    done <= 1'b0;
                end
            end else begin
                done <= 1'b0;
            end
        end
    end

endmodule