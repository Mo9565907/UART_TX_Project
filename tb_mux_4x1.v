module tb_mux_4x1;

    logic [1:0] MUX_SEL;
    logic SERIAL_BIT;
    logic PARITY_BIT;
    logic STOP_BIT;
    logic IDLE_BIT;
    logic TX_OUTPUT;

    mux_4x1 uut (
        .MUX_SEL(MUX_SEL),
        .SERIAL_BIT(SERIAL_BIT),
        .PARITY_BIT(PARITY_BIT),
        .STOP_BIT(STOP_BIT),
        .IDLE_BIT(IDLE_BIT),
        .TX_OUTPUT(TX_OUTPUT)
    );

    initial begin
        MUX_SEL = 2'b00;
        SERIAL_BIT = 1'b0;
        PARITY_BIT = 1'b0;
        STOP_BIT = 1'b1;
        IDLE_BIT = 1'b0;

        #10;
        MUX_SEL = 2'b00;
        SERIAL_BIT = 1'b1;
        #10;
        SERIAL_BIT = 1'b0;
        #10;

        MUX_SEL = 2'b01;
        PARITY_BIT = 1'b1;
        #10;
        PARITY_BIT = 1'b0;
        #10;

        MUX_SEL = 2'b10;
        #20;

        MUX_SEL = 2'b11;
        #20;

        $finish;
    end

    initial begin
        $monitor("%0t ns | MUX_SEL=%b | SERIAL=%b PARITY=%b STOP=%b IDLE=%b | TX_OUTPUT=%b",
                  $time, MUX_SEL, SERIAL_BIT, PARITY_BIT, STOP_BIT, IDLE_BIT, TX_OUTPUT);
    end

    initial begin
        $dumpfile("mux_tb.vcd");
        $dumpvars(0, tb_mux_4x1);
    end

endmodule
