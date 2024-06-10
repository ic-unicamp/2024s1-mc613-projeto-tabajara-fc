module desenha_x #(
    parameter SCALE = 10
) (
    input wire clk,
    input wire reset,
    input wire [9:0] h_counter, // Contador horizontal
    input wire [9:0] v_counter, // Contador vertical
    input wire [9:0] X_POS_X, // Posição X do X
    input wire [9:0] X_POS_Y, // Posição Y do X
    output reg [7:0] R,
    output reg [7:0] G,
    output reg [7:0] B
);

    // Parâmetros de posição e escalas

    // Padrão do X

    always @(h_counter or v_counter or reset) begin
        integer orig_x;
        integer orig_y;

        if (reset) begin
            R = 8'b0;
            G = 8'b0;
            B = 8'b0;
        end else begin
            // Inicialize a cor para preto
            R = 8'b0;
            G = 8'b0;
            B = 8'b0;
            // Desenhar o X
            if ((h_counter >= X_POS_X) && (h_counter < X_POS_X + 8 * SCALE) && 
                (v_counter >= X_POS_Y) && (v_counter < X_POS_Y + 8 * SCALE)) begin
                // Calcule a posição na grade original de 8x8
                orig_x = (h_counter - X_POS_X) / SCALE;
                orig_y = (v_counter - X_POS_Y) / SCALE;

                // Verifique o bit correspondente no padrão do X
                case (orig_y)
                    0: if (orig_x == 0 || orig_x == 7) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    1: if (orig_x == 1 || orig_x == 6) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    2: if (orig_x == 2 || orig_x == 5) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    3: if (orig_x == 3 || orig_x == 4) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    4: if (orig_x == 3 || orig_x == 4) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    5: if (orig_x == 2 || orig_x == 5) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    6: if (orig_x == 1 || orig_x == 6) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    7: if (orig_x == 0 || orig_x == 7) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                endcase
            end
        end
    end
endmodule