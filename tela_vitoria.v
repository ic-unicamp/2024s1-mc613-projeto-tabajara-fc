module tela_vitoria(
    input clk,
    input reset,
    input [9:0] h_counter,
    input [9:0] v_counter,
    output reg [7:0] R,
    output reg [7:0] G,
    output reg [7:0] B
);

// Defina a escala do objeto
localparam SCALE = 6;

// Coordenadas da caveira
localparam SKULL_POS_X = 400; // Posição X inicial da caveira
localparam SKULL_POS_Y = 250;  // Posição Y inicial da caveira

// Padrão da caveira
// Padrão da caveira
// Padrão da caveira
localparam [449:0] SKULL_PATTERN = 450'b000000000000000000000000000000000111100000000000111110000000000111100000000000011110000000111100000000000111110000000000111100000000000011110000000111100000000000111110000000000111100000000000011110000000111100000000000111110000000000111100000000000011110000000111100000000000111110000000000111100000000000011110000000111100000000000111110000000000111100000000000011110000000111111111111111000000111100000111111111111111000000111100000111111111111111000000111100000111111111111111000000111100000111111111111111000000111100000111111111111111000000111100000111111111111111000000111100000000000000000000000000000000;

// Bloco para pintar a caveira na tela
always @(clk) begin
	 
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

            // Defina o padrão da nave espacial
            if ((h_counter >= SKULL_POS_X) && (h_counter < SKULL_POS_X + 11 * SCALE) && 
                (v_counter >= SKULL_POS_Y) && (v_counter < SKULL_POS_Y + 11 * SCALE)) begin
                // Calcule a posição na grade original de 11x11
                orig_x = (h_counter - SKULL_POS_X) / SCALE;
                orig_y = (v_counter - SKULL_POS_Y) / SCALE;

                // Verifique o bit correspondente no padrão
                case (orig_y)
                    0: if (orig_x == 5) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    1: if ((orig_x >= 4) && (orig_x <= 6)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    2: if ((orig_x >= 3) && (orig_x <= 7)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    3: if ((orig_x >= 2) && (orig_x <= 4) || (orig_x >= 6) && (orig_x <= 8)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    4: if ((orig_x >= 1) && (orig_x <= 3) || (orig_x >= 7) && (orig_x <= 9)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    5: if ((orig_x >= 0) && (orig_x <= 10)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    6: if ((orig_x >= 0) && (orig_x <= 10)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    7: if ((orig_x >= 0) && (orig_x <= 10)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    8: if ((orig_x >= 0) && (orig_x <= 10)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    9: if ((orig_x == 2) || (orig_x == 8)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    10: if ((orig_x == 2) || (orig_x == 8)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                endcase
            end
        end
    end

endmodule