module mux_4x1 (
    input wire [1:0] MUX_SEL,
    input wire SERIAL_BIT,
    input wire PARITY_BIT,
    input wire STOP_BIT,
    input wire IDLE_BIT,
    output reg TX_OUTPUT
);

    always @(*) begin
        case (MUX_SEL)
            2'b00 : TX_OUTPUT = SERIAL_BIT;
            2'b01 : TX_OUTPUT = PARITY_BIT;
            2'b10 : TX_OUTPUT = STOP_BIT;
            2'b11 : TX_OUTPUT = IDLE_BIT;
            default : TX_OUTPUT = 1'b0;
        endcase
    end

endmodule