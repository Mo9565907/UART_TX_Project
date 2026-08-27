module tb_parity_calculator;

    reg CLK;
    reg RST;
    reg [7:0] P_INPUT;
    reg P_BIT;
    reg P_EN;
    wire PARITY_BIT;
    wire PARTY_DONE;

    parity_calculator uut (
        .CLK(CLK),
        .RST(RST),
        .P_INPUT(P_INPUT),
        .P_BIT(P_BIT),
        .P_EN(P_EN),
        .PARITY_BIT(PARITY_BIT),
        .PARTY_DONE(PARTY_DONE)
    );

    always #5 CLK = ~CLK;

    initial begin
        CLK = 0;
        RST = 1;
        P_INPUT = 8'b0;
        P_BIT = 1'b0;
        P_EN = 1'b0;

        #20;
        RST = 0;
        #10;

        P_INPUT = 8'b11010100;
        P_BIT = 1'b0;
        P_EN = 1'b1;
        #10;
        P_EN = 1'b0;
        #20;

        P_INPUT = 8'b11010100;
        P_BIT = 1'b1;
        P_EN = 1'b1;
        #10;
        P_EN = 1'b0;
        #20;

        P_INPUT = 8'b11010101;
        P_BIT = 1'b0;
        P_EN = 1'b1;
        #10;
        P_EN = 1'b0;
        #20;

        P_INPUT = 8'b11010101;
        P_BIT = 1'b1;
        P_EN = 1'b1;
        #10;
        P_EN = 1'b0;
        #20;

        #50;
        $finish;
    end

    initial begin
        $monitor("%0t ns | P_INPUT=%b P_BIT=%b P_EN=%b | PARITY_BIT=%b PARTY_DONE=%b",
                  $time, P_INPUT, P_BIT, P_EN, PARITY_BIT, PARTY_DONE);
    end

    initial begin
        $dumpfile("parity_tb.vcd");
        $dumpvars(0, tb_parity_calculator);
    end

endmodule