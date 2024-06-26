module tela_derrota(
    input [9:0] h_counter,
    input reset,
    input [9:0] v_counter,
    input [10:0] mem_X_barra,
    output reg [7:0] R,
    output reg [7:0] G,
    output reg [7:0] B
);

    // Defina a escala do objeto
    localparam SCALE = 10;

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

        // Defina o padrão da nave espacial
        if ((h_counter >= 400) && (h_counter < 400 + 11 * SCALE) && 
            (v_counter >= 200) && (v_counter < 200 + 11 * SCALE)) begin
            // Calcule a posição na grade original de 11x11
            orig_x = (h_counter - 400) / SCALE;
            orig_y = (v_counter - 200) / SCALE;

            // Verifique o bit correspondente no padrão
            case (orig_y)
                0: if (orig_x >= 1 && orig_x <= 9) begin
                    R = 8'hFF;
                    G = 8'hFF;
                    B = 8'hFF;
                end
                1: if (orig_x >= 0 && orig_x <= 10) begin
                    R = 8'hFF;
                    G = 8'hFF;
                    B = 8'hFF;
                end
                2: if (orig_x == 0 || orig_x == 10 || (orig_x >= 4 && orig_x <= 6)) begin
                    R = 8'hFF;
                    G = 8'hFF;
                    B = 8'hFF;
                end
                3: if (orig_x == 0 || orig_x == 10 || (orig_x >= 4 && orig_x <= 6)) begin
                    R = 8'hFF;
                    G = 8'hFF;
                    B = 8'hFF;
                end
                4: if (orig_x == 0 || orig_x == 10 || (orig_x >= 4 && orig_x <= 6)) begin
                    R = 8'hFF;
                    G = 8'hFF;
                    B = 8'hFF;
                end
                5: if (orig_x >= 0 && orig_x <= 10) begin
                    R = 8'hFF;
                    G = 8'hFF;
                    B = 8'hFF;
                end
                6: if (orig_x !=5) begin
                    R = 8'hFF;
                    G = 8'hFF;
                    B = 8'hFF;
                end
                7: if (orig_x >= 0 && orig_x <= 10) begin
                    R = 8'hFF;
                    G = 8'hFF;
                    B = 8'hFF;
                end
                8: if (orig_x >= 1 && orig_x <= 9) begin
                    R = 8'hFF;
                    G = 8'hFF;
                    B = 8'hFF;
                end
                9: if (orig_x == 2 || orig_x == 4 || orig_x == 6 || orig_x == 8) begin
                    R = 8'hFF;
                    G = 8'hFF;
                    B = 8'hFF;
                end
                10: if (orig_x == 2 || orig_x == 4 || orig_x == 6 || orig_x == 8) begin
                    R = 8'hFF;
                    G = 8'hFF;
                    B = 8'hFF;
                end
            endcase
        end
    end
end

endmodule