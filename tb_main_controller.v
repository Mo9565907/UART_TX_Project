module tb_main_controller;

    parameter DATA_WIDTH = 8;

    reg CLK;
    reg RST;
    reg [DATA_WIDTH-1:0] P_INPUT;
    reg V_INPUT;
    reg P_EN;
    reg P_BIT;

    reg SHIFT_DONE;
    reg PARITY_DONE;

    wire LOAD;
    wire SHIFT_EN;
    wire [3:0] BIT_CNT;
    wire PARITY_CALC_EN;
    wire PARITY_SEL;
    wire [1:0] MUX_SEL;
    wire BUSY;

    main_controller #(
        .DATA_WIDTH(DATA_WIDTH)
    ) uut (
        .CLK(CLK),
        .RST(RST),
        .P_INPUT(P_INPUT),
        .V_INPUT(V_INPUT),
        .P_EN(P_EN),
        .P_BIT(P_BIT),
        .SHIFT_DONE(SHIFT_DONE),
        .PARITY_DONE(PARITY_DONE),
        .LOAD(LOAD),
        .SHIFT_EN(SHIFT_EN),
        .BIT_CNT(BIT_CNT),
        .PARITY_CALC_EN(PARITY_CALC_EN),
        .PARITY_SEL(PARITY_SEL),
        .MUX_SEL(MUX_SEL),
        .BUSY(BUSY)
    );

    always #5 CLK = ~CLK;

    initial begin

        CLK = 0;
        RST = 0;
        P_INPUT = 8'b10101010;
        V_INPUT = 0;
        P_EN = 0;
        P_BIT = 0;
        SHIFT_DONE = 0;
        PARITY_DONE = 0;

        #10;
        RST = 1;

        #10;
        V_INPUT = 1;

        #10;
        V_INPUT = 0;

        #50;
        SHIFT_DONE = 1;

        #10;
        SHIFT_DONE = 0;

        #20;

        P_EN = 1;
        P_BIT = 0;
        P_INPUT = 8'b11001100;
        V_INPUT = 1;

        #10;
        V_INPUT = 0;

        #50;
        SHIFT_DONE = 1;

        #10;
        SHIFT_DONE = 0;

        #20;
        PARITY_DONE = 1;

        #10;
        PARITY_DONE = 0;

        #20;

        $stop;

    end

endmodule