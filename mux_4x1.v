module mux_4x1 (
    input logic [1:0] MUX_SEL,
    input logic SERIAL_BIT,
    input logic PARITY_BIT,
    input logic STOP_BIT,
    input logic IDLE_BIT,
    output logic TX_OUTPUT
);

    always_comb @(*) begin
        case (MUX_SEL)
            2'b00 : TX_OUTPUT = SERIAL_BIT;
            2'b01 : TX_OUTPUT = PARITY_BIT;
            2'b10 : TX_OUTPUT = STOP_BIT;
            2'b11 : TX_OUTPUT = IDLE_BIT;
            default : TX_OUTPUT = 1'b0;
        endcase
    end

endmodule
