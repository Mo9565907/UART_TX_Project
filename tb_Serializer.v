module tb_Serializer;

    logic clk;
    logic rst;
    logic  load;
    logic shift;
    logic  [7:0] p_input;
    logic serial_bit;
    logic done;

    Serializer uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .shift(shift),
        .p_input(p_input),
        .serial_bit(serial_bit),
        .done(done)
    );

    always_ff #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        load = 0;
        shift = 0;
        p_input = 8'b0;

        #20;
        rst = 0;
        #10;

        p_input = 8'b11010100;
        load = 1;
        #10;
        load = 0;
        #10;

        shift = 1;
        #80;
        shift = 0;
        #20;

        p_input = 8'b10101010;
        load = 1;
        #10;
        load = 0;
        #10;
        shift = 1;
        #80;
        shift = 0;

        #50;
        $finish;
    end

    initial begin
        $monitor("%0t ns | load=%b shift=%b data_in=%b | serial_bit=%b done=%b", 
                  $time, load, shift, p_input, serial_bit, done);
    end

    initial begin
        $dumpfile("serializer_tb.vcd");
        $dumpvars(0, tb_Serializer);
    end

endmodule
