module tela_derrota(
    input clk,
    input reset,
    input [9:0] h_counter,
    input [9:0] v_counter,
    output reg [7:0] R,
    output reg [7:0] G,
    output reg [7:0] B
);

// Defina a escala do objeto
localparam SCALE = 1;

// Coordenadas da caveira
localparam SKULL_POS_X = 300; // Posição X inicial da caveira
localparam SKULL_POS_Y = 200;  // Posição Y inicial da caveira

// Padrão da caveira
// Padrão da caveira
// Padrão da caveira
localparam [449:0] SKULL_PATTERN = 450'b000000000000000000000000000000000111100000000000111110000000000111100000000000011110000000111100000000000111110000000000111100000000000011110000000111100000000000111110000000000111100000000000011110000000111100000000000111110000000000111100000000000011110000000111100000000000111110000000000111100000000000011110000000111100000000000111110000000000111100000000000011110000000111111111111111000000111100000111111111111111000000111100000111111111111111000000111100000111111111111111000000111100000111111111111111000000111100000111111111111111000000111100000111111111111111000000111100000000000000000000000000000000;

// Bloco para pintar a caveira na tela
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
        // Desenhar a caveira
        if ((h_counter >= SKULL_POS_X) && (h_counter < SKULL_POS_X + 640 * SCALE) && 
            (v_counter >= SKULL_POS_Y) && (v_counter < SKULL_POS_Y + 480 * SCALE)) begin
            // Calcule a posição na grade original de 8x8
            orig_x = (h_counter - SKULL_POS_X) / SCALE;
            orig_y = (v_counter - SKULL_POS_Y) / SCALE;

            // Verifique o bit correspondente no padrão da caveira
            if (SKULL_PATTERN[orig_y*30 + orig_x]) begin
                // Defina a cor para branco
                R = 255;
                G = 255;
                B = 255;
            end
            else begin
                R = 0;
                G = 0;
                B = 0;
            end
        end
    end
end

endmodule