module engine (
    input wire clk,
    input wire reset,
    input wire [N:0] enemy_vivos, //Definir N como o numero de inimigos
    input wire jogador_vivo,
    input wire vitoria_enemy,
    input wire btn_D,
    output wire restart,
    output wire [9:0] score,
    output reg [N:0] ID_enemy_tiro, //Definir N como o numero de inimigos
    output wire [1:0] estado_jogo // 0 = jogo rodando, 1 = jogador venceu, 2 = jogador perdeu    
    );

localparam N = 24; // Número de inimigos
localparam ATRASO_TIRO = 25'd 1000000; // Atraso para o inimigo atirar

assign max_value = N;

//Reseta o jogo
assign restart = reset || ~btn_D; //Quando há comando de restart, reset, o jogo reinicia.

//Define estado do jogo
assign estado_jogo = (vitoria_enemy || ~jogador_vivo) ? 2 : (~|enemy_vivos) ? 1 : 0;

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
        ID_enemy_tiro[0]  <= 8'd0;
        ID_enemy_tiro[1]  <= 8'd0;
        ID_enemy_tiro[2]  <= 8'd0;
        ID_enemy_tiro[3]  <= 8'd0;
        ID_enemy_tiro[4]  <= 8'd0;
        ID_enemy_tiro[5]  <= 8'd0;
        ID_enemy_tiro[6]  <= 8'd1;
        ID_enemy_tiro[7]  <= 8'd0;
        ID_enemy_tiro[8]  <= 8'd0;
        ID_enemy_tiro[9]  <= 8'd0;
        ID_enemy_tiro[10] <= 8'd0;
        ID_enemy_tiro[11] <= 8'd0;
        ID_enemy_tiro[12] <= 8'd0;
        ID_enemy_tiro[13] <= 8'd0;
        ID_enemy_tiro[14] <= 8'd0;
        ID_enemy_tiro[15] <= 8'd0;
        ID_enemy_tiro[16] <= 8'd0;
        ID_enemy_tiro[17] <= 8'd0;
        ID_enemy_tiro[18] <= 8'd0;
        ID_enemy_tiro[19] <= 8'd0;
        ID_enemy_tiro[20] <= 8'd0;
        ID_enemy_tiro[21] <= 8'd0;
        ID_enemy_tiro[22] <= 8'd0;
        ID_enemy_tiro[23] <= 8'd0;
    end
    else begin
        ID_enemy_tiro[6]  <= 8'd0;
        if (contador_tiro == ATRASO_TIRO) begin
            tiro_antigo = random_output;
            if (enemy_vivos[tiro_antigo] == 1) begin
                ID_enemy_tiro[tiro_antigo] = 1;
                contador_tiro = 0;
            end
        end
        else begin
            contador_tiro = contador_tiro + 1;
            if (contador_tiro == 1) begin
                ID_enemy_tiro[tiro_antigo] = 0;
            end
        end
    end
end



endmodule