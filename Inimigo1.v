module Inimigo1(
    input clk,
    input [9:0] posX,
	input [9:0] posY,
    input [9:0] h_counter,
    input [9:0] v_counter,
    input [9:0] posX_municao_player,
    input [9:0] posY_municao_player,
    input reset,
    input btn_D,
    output reg [7:0] R,
    output reg [7:0] G,
    output reg [7:0] B,
    output reg colisao,
    output reg vivo,
    output reg venceu
);

    // Defina a escala do objeto
    localparam SCALE = 3;

    // Bloco para pintar o inimigo na tela
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
            // Defina o padrão do alienígena
            if ((h_counter >= posX) && (h_counter < posX + 8 * SCALE) && 
                (v_counter >= posY) && (v_counter < posY + 8 * SCALE)) begin
                // Calcule a posição na grade original de 8x8
                orig_x = (h_counter - posX) / SCALE;
                orig_y = (v_counter - posY) / SCALE;

                // Verifique o bit correspondente no padrão
                case (orig_y)
                    0: if ((orig_x >= 2) && (orig_x <= 5)) begin
                        R = 8'hFF;
                        G = 8'h00;
                        B = 8'h00;
                    end
                    1: if ((orig_x >= 1) && (orig_x <= 6)) begin
                        R = 8'hFF;
                        G = 8'h00;
                        B = 8'h00;
                    end
                    2: if ((orig_x >= 0) && (orig_x <= 7)) begin
                        R = 8'hFF;
                        G = 8'h00;
                        B = 8'h00;
                    end
                    3: if ((orig_x == 0) || (orig_x == 1) || 
                          (orig_x == 4) || (orig_x == 5) || 
                          (orig_x == 6) || (orig_x == 7)) begin
                        R = 8'hFF;
                        G = 8'h00;
                        B = 8'h00;
                    end
                    4: if ((orig_x >= 0) && (orig_x <= 7)) begin
                        R = 8'hFF;
                        G = 8'h00;
                        B = 8'h00;
                    end
                    5: if ((orig_x == 2) || (orig_x == 5)) begin
                        R = 8'hFF;
                        G = 8'h00;
                        B = 8'h00;
                    end
                    6: if ((orig_x == 1) || (orig_x == 3) || 
                          (orig_x == 4) || (orig_x == 6)) begin
                        R = 8'hFF;
                        G = 8'h00;
                        B = 8'h00;
                    end
                    7: if ((orig_x == 0) || (orig_x == 2) || 
                          (orig_x == 5) || (orig_x == 7)) begin
                        R = 8'hFF;
                        G = 8'h00;
                        B = 8'h00;
                    end
                endcase
            end
        end
    end

// Bloco para verificar colisão entre inimigo e bala
always @(posedge clk) begin
    if ((reset) || ~(btn_D)) begin
        vivo <= 1;
        venceu <= 0;
        colisao <= 0;
    end else begin
        // Verifique a colisão se o inimigo está vivo
        if (vivo && 
            (posX_municao_player >= posX) && (posX_municao_player < posX + 8 * SCALE) && 
            (posY_municao_player >= posY) && (posY_municao_player < posY + 8 * SCALE)) begin
            colisao <= 1;
            vivo <= 0;
        end else begin
            colisao <= 0;
        end
        // Verifique se o jogador venceu (condição pode ser ajustada conforme necessário)
        if (posY >= 480 && vivo) begin
            venceu <= 1'b1;
        end
    end
end

endmodule