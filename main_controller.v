module main_controller #(
    parameter DATA_WIDTH = 8
)(
    input        CLK,
    input        RST,
    input  [DATA_WIDTH-1:0] P_INPUT,
    input        V_INPUT,
    input        P_EN,
    input        P_BIT,

    input        SHIFT_DONE,
    input        PARITY_DONE,

    output logic      LOAD,
    output logic      SHIFT_EN,
    output logic [3:0] BIT_CNT,
    output logic      PARITY_CALC_EN,
    output logic     PARITY_SEL,
    output logic [1:0] MUX_SEL,
    output logic     BUSY
);
    parameter IDLE        = 3'b000;
    parameter LOAD_DATA   = 3'b001;
    parameter DATA_SEND   = 3'b010;
    parameter PARITY_CALC = 3'b011;
    parameter PARITY_SEND = 3'b100;
    parameter STOP_SEND   = 3'b101;

    logic [2:0] STATE;
    logic [2:0] NEXT_STATE;

    always_ff @(posedge CLK or negedge RST) begin
        if (!RST)
            STATE <= IDLE;
        else
            STATE <= NEXT_STATE;
    end

    always_comb @(*) begin
        NEXT_STATE = STATE;

        case (STATE)

            IDLE: begin
                if (V_INPUT)
                    NEXT_STATE = LOAD_DATA;
            end

            LOAD_DATA: begin
                NEXT_STATE = DATA_SEND;
            end

            DATA_SEND: begin
                if (SHIFT_DONE) begin
                    if (P_EN)
                        NEXT_STATE = PARITY_CALC;
                    else
                        NEXT_STATE = STOP_SEND;
                end
            end

            PARITY_CALC: begin
                if (PARITY_DONE)
                    NEXT_STATE = PARITY_SEND;
            end

            PARITY_SEND: begin
                NEXT_STATE = STOP_SEND;
            end

            STOP_SEND: begin
                NEXT_STATE = IDLE;
            end

            default: begin
                NEXT_STATE = IDLE;
            end

        endcase
    end

    always_comb @(*) begin
        LOAD           = 1'b0;
        SHIFT_EN       = 1'b0;
        BIT_CNT        = 4'd0;
        PARITY_CALC_EN = 1'b0;
        PARITY_SEL     = P_BIT;
        MUX_SEL        = 2'b11;
        BUSY           = 1'b0;

        case (STATE)

            IDLE: begin
                BUSY    = 1'b0;
                MUX_SEL = 2'b11;
            end

            LOAD_DATA: begin
                BUSY    = 1'b1;
                LOAD    = 1'b1;
                MUX_SEL = 2'b11;
            end

            DATA_SEND: begin
                BUSY     = 1'b1;
                SHIFT_EN = 1'b1;
                MUX_SEL  = 2'b00;
            end

            PARITY_CALC: begin
                BUSY           = 1'b1;
                PARITY_CALC_EN = 1'b1;
                MUX_SEL        = 2'b01;
            end

            PARITY_SEND: begin
                BUSY    = 1'b1;
                MUX_SEL = 2'b01;
            end

            STOP_SEND: begin
                BUSY    = 1'b1;
                MUX_SEL = 2'b10;
            end

        endcase
    end

endmodule
