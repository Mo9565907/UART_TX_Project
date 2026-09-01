module Serializer (
    input logic clk,
    input logic rst,
    input logic load,
    input logic shift,
    input logic [7:0] p_input,
    output logic serial_bit,
    output logic done
);

    logic [7:0] shift_reg;
    logic [2:0] bit_counter;

    always_ff @(posedge clk or posedge rst) begin
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
