module draw_x(
    input wire clk,
    input wire reset,
    input wire [9:0] h_counter, // Contador horizontal
    input wire [9:0] v_counter, // Contador vertical
    output reg [7:0] R,
    output reg [7:0] G,
    output reg [7:0] B
);

    // Parâmetros de posição e escala
    parameter X_POS_X = 100;
    parameter X_POS_Y = 100;
    parameter SCALE = 10;

    // Padrão do X
    reg [63:0] X_PATTERN = 64'b10000001_01000010_00100100_00011000_00011000_00100100_01000010_10000001;

    always @(posedge clk or posedge reset) begin
        integer orig_x;
        integer orig_y;

        if (reset) begin
            R <= 8'b0;
            G <= 8'b0;
            B <= 8'b0;
        end else begin
            // Inicialize a cor para preto
            R <= 8'b0;
            G <= 8'b0;
            B <= 8'b0;
            // Desenhar o X
            if ((h_counter >= X_POS_X) && (h_counter < X_POS_X + 8 * SCALE) && 
                (v_counter >= X_POS_Y) && (v_counter < X_POS_Y + 8 * SCALE)) begin
                // Calcule a posição na grade original de 8x8
                orig_x = (h_counter - X_POS_X) / SCALE;
                orig_y = (v_counter - X_POS_Y) / SCALE;

                // Verifique o bit correspondente no padrão do X
                if (X_PATTERN[orig_y * 8 + orig_x]) begin
                    // Defina a cor para branco
                    R <= 8'b11111111;
                    G <= 8'b11111111;
                    B <= 8'b11111111;
                end else begin
                    R <= 8'b0;
                    G <= 8'b0;
                    B <= 8'b0;
                end
            end
        end
    end
endmodule