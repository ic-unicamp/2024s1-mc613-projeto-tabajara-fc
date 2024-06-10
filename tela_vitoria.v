module tela_vitoria(
    input reset,
    input [9:0] h_counter,
    input [9:0] v_counter,
    output reg [7:0] R,
    output reg [7:0] G,
    output reg [7:0] B
);

    // Defina a escala do objeto
    localparam SCALE = 10;
    localparam RED = 8'hF0;
    localparam GREEN = 8'hF0;
    localparam BLUE = 8'h0;

always @(h_counter or v_counter or reset) begin
    integer orig_x;
    integer orig_y;

    if (reset) begin
        R = 0;
        G = 0;
        B = 0;
    end else begin
        // Inicialize a cor para preto
        R = 0;
        G = 0;
        B = 0;

        // Defina o padrão da nave espacial
        if ((h_counter >= 400) && (h_counter < 400 + 11 * SCALE) && 
            (v_counter >= 200) && (v_counter < 200 + 11 * SCALE)) begin
            // Calcule a posição na grade original de 11x11
            orig_x = (h_counter - 400) / SCALE;
            orig_y = (v_counter - 200) / SCALE;
				
          // Verifique o bit correspondente no padrão
            case (orig_y)
                0: if (orig_x >= 2 && orig_x <= 8) begin
                    R = RED;
                    G = GREEN;
                    B = BLUE;
                end
                1: if (orig_x >= 0 && orig_x <= 10) begin
                    R = RED;                    
                    G = GREEN;                
                    B = BLUE;
                end
                2: if ((orig_x == 0 || orig_x == 10) || (orig_x >= 2 && orig_x <= 8)) begin
                    R = RED;                    
                    G = GREEN;                
                    B = BLUE;
                end
                3: if ((orig_x == 0 || orig_x == 10) || (orig_x >= 2 && orig_x <= 8)) begin
                    R = RED;
                    G = GREEN;
                    B = BLUE;
                end
                4: if (orig_x >= 0 && orig_x <= 10) begin
                    R = RED;
                    G = GREEN;
                    B = BLUE;
                end
                5: if (orig_x >= 2 && orig_x <= 8) begin
                    R = RED;
                    G = GREEN;
                    B = BLUE;
                end
                6: if (orig_x >= 4 && orig_x <= 6) begin
                    R = RED;
                    G = GREEN;
                    B = BLUE;
                end
                7: if (orig_x >= 4 && orig_x <= 6) begin
                    R = RED;
                    G = GREEN;
                    B = BLUE;
                end
                8: if (orig_x >= 4 && orig_x <= 6) begin
                    R = RED;
                    G = GREEN;
                    B = BLUE;
                end
                9: if (orig_x >= 4 && orig_x <= 6) begin
                    R = RED;
                    G = GREEN;
                    B = BLUE;
                end
                10: if (orig_x >= 2 && orig_x <= 8) begin
                    R = RED;
                    G = GREEN;
                    B = BLUE;
                end
            endcase
        end
    end
end

endmodule