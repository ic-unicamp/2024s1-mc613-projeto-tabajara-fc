module engine #(
    parameter LINHAS, // Define o tamanho padrão do array como 8 bits
    parameter COLUNAS // Define o tamanho padrão do array como 8 bits

) (
    input wire clk,
    input wire reset,
    input wire [(LINHAS * COLUNAS)-1:0] enemy_vivos, //Definir N_enemy como o numero de inimigos
    input wire jogador_vivo,
    input wire vitoria_enemy,
    input wire btn_D,
    output wire restart,
    output wire [9:0] score,
    output reg [5:0] ID_enemy_tiro_X, //Definir N_enemy como o numero de inimigos
    output reg [5:0] ID_enemy_tiro_Y, //Definir N_enemy como o numero de inimigos
    output wire [1:0] estado_jogo // 0 = jogo rodando, 1 = jogador venceu, 2 = jogador perdeu    
    );

localparam ATRASO_X = 26'd10; // Atraso para mudar o x do inimigo atirar
localparam ATRASO_Y = 26'd1000000; // Atraso para mudar o x do inimigo atirar


//Reseta o jogo
assign restart = reset || ~btn_D; //Quando há comando de restart, reset, o jogo reinicia.

//Define estado do jogo
assign estado_jogo = (|vitoria_enemy || ~jogador_vivo) ? 3 : (~|enemy_vivos) ? 2 : 1;

//Numero de inimigos:
assign N_enemy = LINHAS * COLUNAS;

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
        for (j = 0; j < (LINHAS * COLUNAS); j = j + 1) begin
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
    .reset(restart),
    .max_value(N_enemy),
    .random_output(random_output)
);

reg [19:0] contador_x;
wire [8:0] random_output;
reg [9:0] tiro_antigo;
reg procura_y;
reg agora;
wire [9:0] N_enemy;

integer k;
integer i;
integer count;

always @(posedge clk) begin // Atraso da troca de atirador
    if (restart) begin
        contador_x = 0;
        tiro_antigo = 0;
        agora = 0;
        count = 0; // Reinicializar o contador
    end
    else begin
        contador_x = contador_x + 1;
        if (contador_x == ATRASO_X) begin
            contador_x = 0;
            if (enemy_vivos[random_output] == 1) begin
                tiro_antigo = random_output;
                agora = 1;
            end
            else begin
                count = 0; // Reinicializar o contador a cada ciclo
                for (i = random_output + 1; (i < LINHAS * COLUNAS - 1) && count < 240; i = i +1) begin
                    count = count + 1; // Incrementar o contador em cada iteração
                    if ((enemy_vivos[random_output] == 1) & ~agora) begin
                    tiro_antigo = random_output;
                    agora = 1;
                    end
                end
            end
        end
        else begin
            agora = 0;
        end
    end
end

always @(posedge clk) begin
    if (reset) begin
        ID_enemy_tiro_Y = 0;
        procura_y = 0;
        ID_enemy_tiro_X = 0;        
    end
    else if(agora) begin
        ID_enemy_tiro_X = tiro_antigo;
        procura_y = 1;
        for (k = 1; (k < LINHAS + 1) & procura_y; k = k + 1) begin
            if (tiro_antigo < (k * COLUNAS)) begin
                ID_enemy_tiro_Y = (k - 1);
                procura_y = 0;
            end
        end
    end
end

endmodule