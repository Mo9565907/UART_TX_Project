module parity_calculator (
    input logic CLK,
    input logic RST,
    input logic [7:0] P_INPUT,
    input logic P_BIT,
    input logic P_EN,
    output logic PARITY_BIT,
    output logic PARTY_DONE
);

    logic parity_result;
    assign parity_result = (P_BIT == 1'b0) ? ^P_INPUT : ~(^P_INPUT);

    always_ff @(posedge CLK or posedge RST) begin
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
