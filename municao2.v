module municao2(
    input clk,
    input reset,
    input btn_D,
    input btn_C,
    input [10:0] posX_inimigo,
    input [10:0] posY_inimigo, // Novo input para a posição Y da nave
    input [9:0] h_counter,
    input [9:0] v_counter,
    output reg [10:0] posX_Municao2,
    output reg [10:0] posY_Municao2,
    output reg [7:0] R,
    output reg [7:0] G,
    output reg [7:0] B
);

// Variáveis internas
reg [10:0] mem_X_municao;
reg [10:0] mem_Y_municao;
reg [18:0] contador_movimento;
reg [23:0] contador_tiro;
reg tiro_ativo;
reg reset_tiro;

// Parâmetros
localparam Delay_Movimento = 22'd200000; // Ajuste conforme necessário
localparam Delay_Tiro = 24'd50000000; // Ajuste conforme necessário para controlar a frequência dos tiros

// Contador para mover a munição pelo mapa
always @(posedge clk) begin
    if (~(btn_D) || (reset)) begin
        contador_movimento <= 0;
        contador_tiro <= 0;
        tiro_ativo <= 0;
        reset_tiro <= 0;
        mem_X_municao <= 0;
        mem_Y_municao <= 0;
        posX_Municao2 <= 0;
        posY_Municao2 <= 0;
    end else begin
        // Atualiza contador de movimento
        if (contador_movimento < Delay_Movimento) begin
            contador_movimento <= contador_movimento + 1;
        end else begin
            contador_movimento <= 0;
        end

        // Atualiza contador de tiro apenas se não há tiro ativo
        if (~tiro_ativo) begin
            if (contador_tiro < Delay_Tiro) begin
                contador_tiro <= contador_tiro + 1;
            end else begin
                contador_tiro <= 0;
                reset_tiro <= 1; // Ativa o tiro quando o contador atinge o limite
                tiro_ativo <= 0;
            end
        end

        // Parte que trata do movimento da munição
        if (~tiro_ativo && reset_tiro) begin
            if ((mem_Y_municao == 0 || mem_Y_municao >= 540)) begin
                mem_X_municao <= posX_inimigo; // Define a posição inicial da munição
                mem_Y_municao <= posY_inimigo; // Define a posição inicial da munição
                posX_Municao2 <= posX_inimigo; // Atualiza a posição de saída da munição
                posY_Municao2 <= posY_inimigo; // Atualiza a posição de saída da munição
                reset_tiro <= 0;
                tiro_ativo <= 1;
            end
        end
            
        if (contador_movimento == 1 && tiro_ativo) begin
            if (mem_Y_municao + 1 < 540) begin
                mem_Y_municao <= mem_Y_municao + 1;
            end else begin
                mem_Y_municao <= 0; // Reseta a munição quando atinge o limite inferior
                tiro_ativo <= 0; // Desativa o tiro ao atingir o limite inferior
            end
        end

        posX_Municao2 <= mem_X_municao;
        posY_Municao2 <= mem_Y_municao;
    end
end

// Parte que trata de mostrar a munição na tela
always @(posedge clk or posedge reset) begin
    if (reset) begin
        R <= 8'b0;
        G <= 8'b0;
        B <= 8'b0;
    end else if (v_counter <= 2 || h_counter <= 96) begin
        R <= 8'b0;
        G <= 8'b0;
        B <= 8'b0;
    end else if (((mem_X_municao - h_counter) < 1) && ((mem_Y_municao - v_counter) < 20)) begin
        R <= 255;
        G <= 0;
        B <= 0;
    end else begin
        R <= 8'b0;
        G <= 8'b0;
        B <= 8'b0;
    end
end

endmodule
