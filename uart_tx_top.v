module uart_tx (
    input wire CLK,
    input wire RST,
    input wire [7:0] P_INPUT,
    input wire V_INPUT,
    input wire P_EN,
    input wire P_BIT,
    output wire TX_OUTPUT,
    output wire BUSY
);

    wire LOAD;
    wire SHIFT_EN;
    wire [3:0] BIT_CNT;
    wire PARITY_CALC_EN;
    wire PARITY_SEL;
    wire [1:0] MUX_SEL;

    wire SERIAL_BIT;
    wire SHIFT_DONE;

    wire PARITY_BIT;
    wire PARTY_DONE;

    wire STOP_BIT;
    wire IDLE_BIT;

    assign STOP_BIT = 1'b1;
    assign IDLE_BIT = 1'b1;

    main_controller #(
        .DATA_WIDTH(8)
    ) main_controller_inst (
        .CLK(CLK),
        .RST(RST),
        .P_INPUT(P_INPUT),
        .V_INPUT(V_INPUT),
        .P_EN(P_EN),
        .P_BIT(P_BIT),
        .SHIFT_DONE(SHIFT_DONE),
        .PARITY_DONE(PARTY_DONE),
        .LOAD(LOAD),
        .SHIFT_EN(SHIFT_EN),
        .BIT_CNT(BIT_CNT),
        .PARITY_CALC_EN(PARITY_CALC_EN),
        .PARITY_SEL(PARITY_SEL),
        .MUX_SEL(MUX_SEL),
        .BUSY(BUSY)
    );

    Serializer serializer_inst (
        .clk(CLK),
        .rst(RST),
        .load(LOAD),
        .shift(SHIFT_EN),
        .p_input(P_INPUT),
        .serial_bit(SERIAL_BIT),
        .done(SHIFT_DONE)
    );

    parity_calculator parity_calculator_inst (
        .CLK(CLK),
        .RST(RST),
        .P_INPUT(P_INPUT),
        .P_BIT(P_BIT),
        .P_EN(PARITY_CALC_EN),
        .PARITY_BIT(PARITY_BIT),
        .PARTY_DONE(PARTY_DONE)
    );

    mux_4x1 mux_4x1_inst (
        .MUX_SEL(MUX_SEL),
        .SERIAL_BIT(SERIAL_BIT),
        .PARITY_BIT(PARITY_BIT),
        .STOP_BIT(STOP_BIT),
        .IDLE_BIT(IDLE_BIT),
        .TX_OUTPUT(TX_OUTPUT)
    );

endmodule