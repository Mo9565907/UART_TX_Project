`timescale 1ns/1ps

module tb_uart_tx;

    reg CLK;
    reg RST;
    reg [7:0] P_INPUT;
    reg V_INPUT;
    reg P_EN;
    reg P_BIT;

    wire TX_OUTPUT;
    wire BUSY;

    uart_tx uut (
        .CLK(CLK),
        .RST(RST),
        .P_INPUT(P_INPUT),
        .V_INPUT(V_INPUT),
        .P_EN(P_EN),
        .P_BIT(P_BIT),
        .TX_OUTPUT(TX_OUTPUT),
        .BUSY(BUSY)
    );

    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end

    initial begin

        RST = 1;
        P_INPUT = 8'b0;
        V_INPUT = 0;
        P_EN = 0;
        P_BIT = 0;

        #20;
        RST = 0;

        #20;

        P_INPUT = 8'b10101010;
        V_INPUT = 1;
        P_EN = 0;

        #10;
        V_INPUT = 0;

        wait(BUSY == 0);

        #30;

        P_INPUT = 8'b11001100;
        V_INPUT = 1;
        P_EN = 1;
        P_BIT = 0;

        #10;
        V_INPUT = 0;

        wait(BUSY == 0);

        #30;

        P_INPUT = 8'b11110000;
        V_INPUT = 1;
        P_EN = 1;
        P_BIT = 1;

        #10;
        V_INPUT = 0;

        wait(BUSY == 0);

        #50;

        $stop;
    end

    initial begin
        $monitor("Time=%0t | RST=%b | V_INPUT=%b | P_INPUT=%b | P_EN=%b | P_BIT=%b | TX_OUTPUT=%b | BUSY=%b",
                 $time, RST, V_INPUT, P_INPUT, P_EN, P_BIT, TX_OUTPUT, BUSY);
    end

endmodule