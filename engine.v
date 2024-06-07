module engine (
    input wire clk,
    input wire reset,
    input wire [N:0] enemy_vivos, //Definir N como o numero de inimigos
    input wire jogador_vivo,
    input wire vitoria_enemy,
    input wire btn_D,
    output wire restart,
    output wire [9:0] score,
    output reg [5:0] ID_enemy_tiro, //Definir N como o numero de inimigos
    output wire [1:0] estado_jogo // 0 = jogo rodando, 1 = jogador venceu, 2 = jogador perdeu    
    );

localparam N = 24; // Número de inimigos
localparam ATRASO_TIRO = 25'd 1000000; // Atraso para o inimigo atirar

assign max_value = N;

//Reseta o jogo
assign restart = reset || ~btn_D; //Quando há comando de restart, reset, o jogo reinicia.

//Define estado do jogo
assign estado_jogo = (|vitoria_enemy || ~jogador_vivo) ? 3 : (~|enemy_vivos) ? 2 : 1;

//Define o score atual

reg [9:0] soma_pontos;
integer j;
always @(posedge clk) begin
    if (restart) begin
        soma_pontos = 0;
    end
    else begin
        soma_pontos = 0;
        for (j = 0; j < N; j = j + 1) begin
            if (enemy_vivos[j] == 0) begin
                soma_pontos = soma_pontos + 1;
            end
        end
    end
end

assign score = soma_pontos;

// Define o inimigo que atira
random_number rn_inst (
    .clk(clk),
    .reset(reset),
    .random_output(random_output)
);

reg [19:0] contador_tiro;
wire [31:0] max_value;
wire [31:0] random_output;
reg [31:0] tiro_antigo;
reg [19:0] contador;
reg momento;

integer k;
always @(posedge clk ) begin
    if (restart) begin
        contador_tiro = 0;
        tiro_antigo = 0;
    end
    else begin
        if (contador_tiro == ATRASO_TIRO) begin
            tiro_antigo = random_output;
            if (enemy_vivos[tiro_antigo] == 1) begin
                ID_enemy_tiro = tiro_antigo;
                contador_tiro = 0;
            end
        end
        else begin
            contador_tiro = contador_tiro + 1;
            if (contador_tiro == 1) begin
                ID_enemy_tiro = 24;
            end
        end
    end
end



endmodule