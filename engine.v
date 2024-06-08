module engine #(
    parameter WIDTH // Define o tamanho padrão do array como 8 bits
) (
    input wire clk,
    input wire reset,
    input wire [WIDTH-1:0] enemy_vivos, //Definir N_enemy como o numero de inimigos
    input wire [31:0] N_enemy,
    input wire jogador_vivo,
    input wire vitoria_enemy,
    input wire btn_D,
    output wire restart,
    output wire [9:0] score,
    output reg [5:0] ID_enemy_tiro_X, //Definir N_enemy como o numero de inimigos
    output reg [5:0] ID_enemy_tiro_Y, //Definir N_enemy como o numero de inimigos
    output wire [1:0] estado_jogo // 0 = jogo rodando, 1 = jogador venceu, 2 = jogador perdeu    
    );

localparam ATRASO_X = 26'd1000000; // Atraso para mudar o x do inimigo atirar
localparam ATRASO_Y = 26'd1000000; // Atraso para mudar o x do inimigo atirar


//Reseta o jogo
assign restart = reset || ~btn_D; //Quando há comando de restart, reset, o jogo reinicia.

//Define estado do jogo
assign estado_jogo = (|vitoria_enemy || ~jogador_vivo) ? 3 : (~|enemy_vivos) ? 2 : 1;

//Define o score atual
reg [9:0] soma_pontos;
reg [9:0] pontuacao;
integer j;
always @(posedge clk) begin
    if (restart) begin
        soma_pontos = 0;
        pontuacao = 0;
    end
    else begin
        soma_pontos = 0;
        for (j = 0; j < WIDTH; j = j + 1) begin
            if (enemy_vivos[j] == 0) begin
                soma_pontos = soma_pontos + 1;
            end
        end
        pontuacao = soma_pontos;
    end
end

assign score = pontuacao;


// Define o inimigo que atira
random_number rn_inst (
    .clk(clk),
    .reset(reset),
    .max_value(N_enemy),
    .random_output(random_output)
);

reg [19:0] contador_x;
// wire [31:0] N_enemy;
wire [31:0] random_output;
reg [31:0] tiro_antigo;
reg [19:0] contador_y;
reg momento;

integer k;
always @(posedge clk ) begin
    if (restart) begin
        contador_x = 0;
        tiro_antigo = 0;
        ID_enemy_tiro_X = 0;
        ID_enemy_tiro_Y = 0;
    end
    else begin
        if (contador_x == ATRASO_X) begin
            tiro_antigo = random_output;
            if (enemy_vivos[tiro_antigo] == 1) begin
                ID_enemy_tiro_X = tiro_antigo;
                if (tiro_antigo < 13) begin
                    ID_enemy_tiro_Y = 0;
                end
                else if (tiro_antigo < 26) begin
                    ID_enemy_tiro_Y = 1;
                end
                else if (tiro_antigo < 39) begin
                    ID_enemy_tiro_Y = 2;
                end
                else if (tiro_antigo < 52) begin
                    ID_enemy_tiro_Y = 3;
                end
                else begin
                    ID_enemy_tiro_Y = 4;
                end
                contador_x = 0;
            end
        end
        else begin
            contador_x = contador_x + 1;
        end
    end
end
endmodule