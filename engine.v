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
    output wire [1:0] estado_jogo, // 0 = jogo rodando, 1 = jogador venceu, 2 = jogador perdeu    
    output wire [31:0] resultado
    );

localparam N = 24; // Número de inimigos
localparam ATRASO_TIRO = 20'd 100000; // Atraso para o inimigo atirar

reg [19:0] contador_tiro;

//Reseta o jogo
assign restart = reset || ~btn_D; //Quando há comando de restart, reset, o jogo reinicia.

//Define estado do jogo
assign estado_jogo = (vitoria_enemy || ~jogador_vivo) ? 2 : (~|enemy_vivos) ? 1 : 0;

//Define a posição do bloco de inimigos

//Definir a posição do bloco de inimigos

//TESTE NUMERO ALEATORIO
random_number rn_inst (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .max_value(max_value),
    .random_output(resultado)
);


wire [31:0] max_value;
wire [31:0] random_output;
reg [19:0] contador;
reg seleciona;
reg certo;
reg enable;
reg momento;

assign max_value = N;
// Define o inimigo que atira
integer k;
always @(posedge clk ) begin
    if (restart) begin
        contador_tiro = 0;
        seleciona = 0;
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
            seleciona = 1;
            if (certo) begin
                seleciona = 0;
                ID_enemy_tiro[k] = 1;
                contador_tiro = 0; 
            end
        end
        else begin
            contador_tiro = contador_tiro + 1;
            // ID_enemy_tiro[k] = 0;
        end
    end
end


always @(posedge clk) begin
    if (reset) begin
        certo = 0;
        momento = 0;
    end
    else begin
        if (seleciona) begin
            if (~momento) begin
                enable = 1; 
            end
            else begin //segundo momento
                k = random_output;
                enable = 0;
                if (enemy_vivos[k] == 1) begin
                    certo = 1;
                end
                else begin
                    certo = 0;
                end
            end
            momento = ~momento;
        end
    end
end


endmodule