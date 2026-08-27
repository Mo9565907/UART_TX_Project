module parity_calculator (
    input wire CLK,
    input wire RST,
    input wire [7:0] P_INPUT,
    input wire P_BIT,
    input wire P_EN,
    output reg PARITY_BIT,
    output reg PARTY_DONE
);

    wire parity_result;
    assign parity_result = (P_BIT == 1'b0) ? ^P_INPUT : ~(^P_INPUT);

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            PARITY_BIT <= 1'b0;
            PARTY_DONE <= 1'b0;
        end else begin
            if (P_EN) begin
                PARITY_BIT <= parity_result;
                PARTY_DONE <= 1'b1;
            end else begin
                PARTY_DONE <= 1'b0;
            end
        end
    end

endmodule