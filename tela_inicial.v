module tela_inicial(
    input reset,
    input [9:0] h_counter,
    input [9:0] v_counter,
    input troca,
    output wire [7:0] R,
    output wire [7:0] G,
    output wire [7:0] B
);

localparam E_SCALE = 10;
localparam E_RED = 8'hF0;
localparam E_GREEN = 8'h0;
localparam E_BLUE = 8'h0;
localparam E_posX = 600;
localparam E_posY = 220;

localparam N_SCALE = 8;
localparam N_RED = 8'h0;
localparam N_GREEN = 8'hF0;
localparam N_BLUE = 8'h0;
localparam N_posX = 250;
localparam N_posY = 200;

localparam X_SCALE = 6;
localparam X_RED = 8'hF0;
localparam X_GREEN = 8'hF0;
localparam X_BLUE = 8'hF0;
localparam X_posX = 430;
localparam X_posY = 220;

reg [7:0] R_inimigo;
reg [7:0] G_inimigo;
reg [7:0] B_inimigo;
reg [7:0] R_nave;
reg [7:0] G_nave;
reg [7:0] B_nave;
reg [7:0] R_x;
reg [7:0] G_x;
reg [7:0] B_x;

//nave
	 /*Parte que trata de montar a imagem da nave na tela*/
    always @(clk) begin
	 
        integer N_orig_x;
        integer N_orig_y;

        if (reset) begin
            R_nave = 8'b0;
            G_nave = 8'b0;
            B_nave = 8'b0;
        end else begin
            // Inicialize a cor para preto
            R_nave = 8'b0;
            G_nave = 8'b0;
            B_nave = 8'b0;

            // Defina o padrão da nave espacial
            if ((h_counter >= N_posX) && (h_counter < N_posX + 11 * N_SCALE) && 
                (v_counter >= N_posY) && (v_counter < N_posY + 11 * N_SCALE)) begin
                // Calcule a posição na grade original de 11x11
                N_orig_x = (h_counter - N_posX) / N_SCALE;
                N_orig_y = (v_counter - N_posY) / N_SCALE;

                // Verifique o bit correspondente no padrão
                case (N_orig_y)
                    0: if (N_orig_x == 5) begin
                        R_nave = N_RED;
                        G_nave = N_GREEN;
                        B_nave = N_BLUE;
                    end
                    1: if ((N_orig_x >= 4) && (N_orig_x <= 6)) begin
                        R_nave = N_RED;
                        G_nave = N_GREEN;
                        B_nave = N_BLUE;
                    end
                    2: if ((N_orig_x >= 3) && (N_orig_x <= 7)) begin
                        R_nave = N_RED;
                        G_nave = N_GREEN;
                        B_nave = N_BLUE;
                    end
                    3: if ((N_orig_x >= 2) && (N_orig_x <= 4) || (N_orig_x >= 6) && (N_orig_x <= 8)) begin
                        R_nave = N_RED;
                        G_nave = N_GREEN;
                        B_nave = N_BLUE;
                    end
                    4: if ((N_orig_x >= 1) && (N_orig_x <= 3) || (N_orig_x >= 7) && (N_orig_x <= 9)) begin
                        R_nave = N_RED;
                        G_nave = N_GREEN;
                        B_nave = N_BLUE;
                    end
                    5: if ((N_orig_x >= 0) && (N_orig_x <= 10)) begin
                        R_nave = N_RED;
                        G_nave = N_GREEN;
                        B_nave = N_BLUE;
                    end
                    6: if ((N_orig_x >= 0) && (N_orig_x <= 10)) begin
                        R_nave = N_RED;
                        G_nave = N_GREEN;
                        B_nave = N_BLUE;
                    end
                    7: if ((N_orig_x >= 0) && (N_orig_x <= 10)) begin
                        R_nave = N_RED;
                        G_nave = N_GREEN;
                        B_nave = N_BLUE;
                    end
                    8: if ((N_orig_x >= 0) && (N_orig_x <= 10)) begin
                        R_nave = N_RED;
                        G_nave = N_GREEN;
                        B_nave = N_BLUE;
                    end
                    9: if ((N_orig_x == 2) || (N_orig_x == 8)) begin
                        R_nave = N_RED;
                        G_nave = N_GREEN;
                        B_nave = N_BLUE;
                    end
                    10: if ((N_orig_x == 2) || (N_orig_x == 8)) begin
                        R_nave = N_RED;
                        G_nave = N_GREEN;
                        B_nave = N_BLUE;
                    end
                endcase
            end
        end
    end
//fim nave

//inimigo
    // Defina a escala do objeto

    always @(h_counter or v_counter or reset or troca) begin
        integer E_orig_x;
        integer E_orig_y;

        if (reset) begin
            R_inimigo = 8'b0;
            G_inimigo = 8'b0;
            B_inimigo = 8'b0;
        end else begin
            // Inicialize a cor para preto
            R_inimigo = 8'b0;
            G_inimigo = 8'b0;
            B_inimigo = 8'b0;
            // Defina o padrão do alienígena
            if ((h_counter >= E_posX) && (h_counter < E_posX + 8 * E_SCALE) && 
                (v_counter >= E_posY) && (v_counter < E_posY + 8 * E_SCALE)) begin
                // Calcule a posição na grade original de 8x8
                E_orig_x = (h_counter - E_posX) / E_SCALE;
                E_orig_y = (v_counter - E_posY) / E_SCALE;

                // Verifique o bit correspondente no padrão
                case (E_orig_y)
                    0: if ((E_orig_x >= 2) && (E_orig_x <= 5)) begin
                        R_inimigo = E_RED;
                        G_inimigo = E_GREEN;
                        B_inimigo = E_BLUE;
                    end
                    1: if ((E_orig_x >= 1) && (E_orig_x <= 6)) begin
                        R_inimigo = E_RED;
                        G_inimigo = E_GREEN;
                        B_inimigo = E_BLUE;
                    end
                    2: if ((E_orig_x >= 0) && (E_orig_x <= 7)) begin
                        R_inimigo = E_RED;
                        G_inimigo = E_GREEN;
                        B_inimigo = E_BLUE;
                    end
                    3: if ((E_orig_x == 0) || (E_orig_x == 1) || 
                          (E_orig_x == 4) || (E_orig_x == 5) || 
                          (E_orig_x == 6) || (E_orig_x == 7)) begin
                        R_inimigo = E_RED;
                        G_inimigo = E_GREEN;
                        B_inimigo = E_BLUE;
                    end
                    4: if ((E_orig_x >= 0) && (E_orig_x <= 7)) begin
                        R_inimigo = E_RED;
                        G_inimigo = E_GREEN;
                        B_inimigo = E_BLUE;
                    end
                    5: if (troca) begin
                        if ((E_orig_x == 1) || (E_orig_x == 6)) begin
                            R_inimigo = E_RED;
                            G_inimigo = E_GREEN;
                            B_inimigo = E_BLUE;
                        end
                    end else begin
                        if ((E_orig_x == 2) || (E_orig_x == 5)) begin
                            R_inimigo = E_RED;
                            G_inimigo = E_GREEN;
                            B_inimigo = E_BLUE;
                        end
                    end
                    6: if (troca) begin
                        if ((E_orig_x == 0) || (E_orig_x == 2) || 
                            (E_orig_x == 5) || (E_orig_x == 7)) begin
                            R_inimigo = E_RED;
                            G_inimigo = E_GREEN;
                            B_inimigo = E_BLUE;
                        end
                    end else begin
                        if ((E_orig_x == 1) || (E_orig_x == 3) || 
                            (E_orig_x == 4) || (E_orig_x == 6)) begin
                            R_inimigo = E_RED;
                            G_inimigo = E_GREEN;
                            B_inimigo = E_BLUE;
                        end
                    end
                    7: if (troca) begin
                        if ((E_orig_x == 1) || (E_orig_x == 3) || 
                            (E_orig_x == 4) || (E_orig_x == 6)) begin
                            R_inimigo = E_RED;
                            G_inimigo = E_GREEN;
                            B_inimigo = E_BLUE;
                        end
                    end else begin
                        if ((E_orig_x == 0) || (E_orig_x == 2) || 
                            (E_orig_x == 5) || (E_orig_x == 7)) begin
                            R_inimigo = E_RED;
                            G_inimigo = E_GREEN;
                            B_inimigo = E_BLUE;
                        end
                    end
                endcase
            end
        end
    end
//fim inimigo

//x
    // Instanciando o módulo desenha_x
    desenha_x #(X_SCALE) my_desenha_x (
        .clk(clk),
        .reset(reset),
        .h_counter(h_counter),
        .v_counter(v_counter),
        .X_POS_X(X_posX),
        .X_POS_Y(X_posY),
        .R(R_x),
        .G(G_x),
        .B(B_x)
    );
//fim x

assign R = R_inimigo | R_nave | R_x;
assign G = G_inimigo | G_nave | G_x;
assign B = B_inimigo | B_nave | B_x;

endmodule