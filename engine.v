module engine (
    input wire clk,
    input wire reset,
    input wire [N:0] enemy_vivos, //Definir N como o numero de inimigos
    input wire jogador_vivo,
    input wire vitoria_enemy,
    input wire btn_D,
    output wire restart,
    output wire vitoria_jogador,
    output wire [7:0] bloco_pos_X,
    output wire [7:0] bloco_pos_Y,
    output reg [N:0] ID_enemy_tiro, //Definir N como o numero de inimigos
    output wire [1:0] estado_jogo // 0 = jogo rodando, 1 = jogador venceu, 2 = jogador perdeu    
    );

`define N 5 // Número de inimigos
`define ATRASO_TIRO 20'd 1000000 // Atraso para o inimigo atirar

reg [19:0] contador_tiro;

//Reseta o jogo
assign restart = reset || ~btn_D; //Quando há comando de restart, reset, o jogo reinicia.

//Define estado do jogo
assign estado_jogo = (vitoria_enemy || ~jogador_vivo) ? 2 : (~|enemy_vivos) ? 1 : 0;

//Definir a posição do bloco de inimigos



// Define o inimigo que atira
integer i;
integer k;
always @(posedge clk ) begin
    if (restart) begin
        contador_tiro = 0;
    end
    else begin
        if (contador_tiro == ATRASO_TIRO) begin
            k = $urandom_range(N, 0);
            while (enemy_vivos[k] == 0) begin
                k = $urandom_range(N, 0);
            end
            for ( i = 0 ; i < N ; i = i + 1 ) begin
                if (i == k) begin
                    ID_enemy_tiro[i] = 1;
                end
                else begin
                    ID_enemy_tiro[i] = 0;
                end
            end
            contador_tiro = 0; 
        end
        else begin
            contador_tiro = contador_tiro + 1;
        end
    end
end

endmodule