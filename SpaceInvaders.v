module SpaceInvaders(
	input clk,
	input reset,
	input btn_A,
	input btn_B,
	input btn_C,
	input btn_D,
   output reg [7:0] VGA_R,
   output reg [7:0] VGA_G,
   output reg [7:0] VGA_B,
   output wire VGA_BLANK_N,
   output wire VGA_SYNC_N,
   output wire VGA_HS,
   output wire VGA_VS,
   output wire VGA_CLK,

   /*LEDs*/
    output [6:0] HEX0, // digito da direita
    output [6:0] HEX1,
    output [6:0] HEX2,
    output [6:0] HEX3,
    output [6:0] HEX4,
    output [6:0] HEX5 // digito da esquerda

);

engine engine(
    .clk(clk),
    .reset(reset),
    .enemy_vivos(vivo_inimigo),
    .N_enemy(N_enemy),
    .jogador_vivo(vivo_jogador),
    .vitoria_enemy(game_over),
    .btn_D(btn_D),
    .restart(),
    .score(resultado), // VOLTAR AQUI DPS
    .ID_enemy_tiro_X(ID_enemy_tiro_X),
    .ID_enemy_tiro_Y(ID_enemy_tiro_Y),
    .estado_jogo()
);

vga vga(
    .VGA_CLK2(VGA_CLK2),
    .reset(reset),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .VGA_BLANK_N(VGA_BLANK_N),
    .VGA_SYNC_N(VGA_SYNC_N),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS)
);

tela_derrota tela_derrota(
    .clk(clk),
    .reset(reset),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .R(R_derrota),
    .G(G_derrota),
    .B(B_derrota)
);

tela_vitoria tela_vitoria(
    .clk(clk),
    .reset(reset),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .R(R_vitoria),
    .G(G_vitoria),
    .B(B_vitoria)
);

nave nave(
    .h_counter(h_counter),
    .v_counter(v_counter),
	.reset(reset),
	.clk(clk),
	.btn_A(p_btn_A),
	.btn_B(p_btn_B),
	.btn_C(p_btn_C),
	.btn_D(p_btn_D),
	.posX_Municao2(posX_Municao2),
	.posY_Municao2(posY_Municao2),
	.tiro_ativo_jogador(tiro_ativo_jogador),
	.vivo_jogador(vivo_jogador),
   .posX_Nave(posX_Nave),
   .R(R_nave),
   .G(G_nave),
   .B(B_nave)
);

// MUNIÇÃO 1 - NAVE
municao1 municao1(
   .h_counter(h_counter),
   .v_counter(v_counter),
	.reset(reset),
	.clk(clk),
	.tiro_ativo_jogador(tiro_ativo_jogador),
	.btn_D(btn_D),
	.colisao_inimigo(matar_bala),
   .posX_Nave(posX_Nave),
	.posX_Municao1(posX_Municao1),
	.posY_Municao1(posY_Municao1),
   .R(R_municao1),
   .G(G_municao1),
   .B(B_municao1)
);

// MUNIÇÃO 2 - INIMIGO
municao2 municao2(
   .h_counter(h_counter),
   .v_counter(v_counter),
	.reset(reset),
	.clk(clk),
	.btn_D(btn_D),
   .posX_inimigo(posX_tiro_inimigo),
   .posY_inimigo(posY_tiro_inimigo),
	.posX_Municao2(posX_Municao2),
	.posY_Municao2(posY_Municao2),
   .R(R_municao2),
   .G(G_municao2),
   .B(B_municao2)
);

reg [5:0] ID_enemy_tiro_X;
reg [5:0] ID_enemy_tiro_Y;
wire [31:0] N_enemy;
assign N_enemy = COLUNAS * LINHAS;

// Variáveis intermediárias para as cores das naves
//Fios
reg [9:0] posX [LINHAS * COLUNAS:0];
reg [9:0] posY [LINHAS:0];
wire [9:0] h_counter;
wire [9:0] v_counter;
wire derrota;

// INIMIGO 
reg [(LINHAS* COLUNAS):0] vivo_inimigo;
reg [(LINHAS* COLUNAS):0] colisao_inimigo;
reg [10:0] posX_tiro_inimigo;
reg [10:0] posY_tiro_inimigo;
wire matar_bala;
reg [(LINHAS* COLUNAS):0] game_over;
wire [7:0] inimigoR [(LINHAS* COLUNAS):0];
wire [7:0] inimigoG [(LINHAS* COLUNAS):0];
wire [7:0] inimigoB [(LINHAS* COLUNAS):0];

//Fios de comunicação nave munição
/*Posicoes dos modulos*/
wire [10:0] posX_Nave; //liga SpaceInvaders com nave
wire [10:0] posX_Municao1; //liga SpaceInvaders com municao1
wire [10:0] posY_Municao1; //liga SpaceInvaders com municao1
wire [10:0] posX_Municao2; //liga SpaceInvaders com municao2
wire [10:0] posY_Municao2; //liga SpaceInvaders com municao2

wire [1:0] tiro_ativo_jogador;
wire [1:0] vivo_jogador;

//variaveis de controle
wire restart;
wire [1:0] estado_jogo;


// Variáveis intermediárias para as cores das naves
wire [7:0] R_nave;
wire [7:0] G_nave;
wire [7:0] B_nave;
wire [7:0] R_municao1;
wire [7:0] G_municao1;
wire [7:0] B_municao1;

//alterar se quiser
wire [7:0] R_municao2;
wire [7:0] G_municao2;
wire [7:0] B_municao2;

wire [7:0] R_derrota;
wire [7:0] G_derrota;
wire [7:0] B_derrota;

wire [7:0] R_vitoria;
wire [7:0] G_vitoria;
wire [7:0] B_vitoria;

// Inicializando as posições das naves inimigas
integer i, k, l;

reg [20:0] contador_movimento;
reg [4:0] contador_velocidade;
reg mov_v;
reg direction; // 0: direita; 1: esquerda
localparam DELTA_X = 1;
localparam DELTA_Y = 50;
localparam COLUNAS = 13;
localparam LINHAS = 5;
localparam DIST_COLUNAS = 30;
localparam DIST_LINHAS = 30;

// MOVIMENTO
reg [10:0] max_x, min_x;
always @(posedge clk) begin
    if (reset || ~btn_D) begin
        contador_movimento = 1;
        contador_velocidade = 0;
        mov_v = 0;
        direction = 0;
        for (k = 0; k < LINHAS; k = k + 1) begin
            posY[k] <= 40 + k * DIST_LINHAS;
            for (i = 0; i < COLUNAS; i = i + 1) begin
                posX[k * COLUNAS + i] <= 150 + i * DIST_COLUNAS;
            end
        end
    end
    else if(estado == 1 && contador_movimento == 0) begin

        max_x = 0;
        min_x = 900;
        for (i = 0; i < (LINHAS * COLUNAS); i = i + 1) begin
            if (posX[i] > max_x && vivo_inimigo[i] == 1) begin
                max_x = posX[i];
            end
            else if (posX[i] < min_x && vivo_inimigo[i] == 1) begin
                min_x = posX[i];
            end
        end
        if (mov_v) begin
            for (k = 0; k < LINHAS; k = k + 1) begin
                posY[k] <= posY[k] + DELTA_Y;
            end
            mov_v = 0;
            contador_velocidade = contador_velocidade + 1;
        end
        else begin
            if (direction == 0) begin
                if (max_x + DIST_COLUNAS <= 760) begin
                    for (i = 0; i < (LINHAS * COLUNAS); i = i + 1) begin
                        posX[i] <= posX[i] + (DELTA_X + contador_velocidade);
                    end
                end
                else begin
                    direction = ~direction;
                    mov_v = 1;
                end
            end
            else begin
                if (min_x - DIST_COLUNAS > 120) begin
                    for (i = 0; i < (LINHAS * COLUNAS); i = i + 1) begin
                        posX[i] <= posX[i] - (DELTA_X + contador_velocidade);
                    end
                end
                else begin
                    direction = ~direction;
                    mov_v = 1;
                end
            end
        end
    end
    contador_movimento = contador_movimento + 1;
end

reg [23:0] contador_tiro;
reg [6:0] contador_inimigo;
  
// always @(posedge clk) begin
//     if (reset || ~btn_D) begin
//         contador_tiro = 1;
//         contador_inimigo = 0;
//         ID_enemy_tiro = 0;
//     end
//     else if (estado == 1 && contador_tiro == 0) begin
//         if (vivo_inimigo[contador_inimigo]) begin
//             ID_enemy_tiro = contador_inimigo;
//         end
//         contador_inimigo = contador_inimigo + 1;
//     end
//     contador_tiro = contador_tiro + 1;
//     if (contador_inimigo == 23) begin
//         contador_inimigo = 0;
//     end
//     if (contador_tiro == 10000000) begin
//         contador_tiro = 0;
//     end
// end

reg [23:0] contador_troca;
reg troca;
always @(posedge clk) begin
    if (reset || ~btn_D) begin
        contador_troca = 0;
        troca = 0;
    end
    else begin
        if (contador_troca == 0) begin
            troca = ~troca;
        end
        contador_troca = contador_troca + 1;
    end
end

assign matar_bala = (|colisao_inimigo);

genvar gv_i, gv_k;
generate
    for (gv_k = 0; gv_k < LINHAS; gv_k = gv_k + 1) begin: row
        for (gv_i = 0; gv_i < COLUNAS; gv_i = gv_i + 1) begin: inimigos
            Inimigo1 inimigo_inst (
                .clk(clk),
                .posX(posX[gv_k * COLUNAS + gv_i]),
                .posY(posY[gv_k]),
                .h_counter(h_counter),
                .v_counter(v_counter),
                .reset(reset),
                .btn_D(btn_D),
                .troca(troca),
                .posX_municao_player(posX_Municao1),
                .posY_municao_player(posY_Municao1),
                .R(inimigoR[gv_k * COLUNAS + gv_i]),
                .G(inimigoG[gv_k * COLUNAS + gv_i]),
                .B(inimigoB[gv_k * COLUNAS + gv_i]),
                .colisao(colisao_inimigo[gv_k * COLUNAS + gv_i]),
                .vivo(vivo_inimigo[gv_k * COLUNAS + gv_i]),
                .venceu(game_over[gv_k * COLUNAS + gv_i]),
            );
        end
    end
endgenerate


//Máquina de estados do jogo
reg p_btn_A, p_btn_B, p_btn_C, p_btn_D;
integer j;
reg [1:0] estado;
reg anterior;
always @(posedge clk) begin
    if (reset) begin
        estado = 0;
        anterior = 1;
    end 
    else begin
        case (estado)
            0: begin    // Pré-jogo
                // Inicialmente, as cores são pretas (fundo)
                VGA_R = R_vitoria;
                VGA_G = ~G_vitoria;
                VGA_B = B_vitoria;
                p_btn_A = 1;
                p_btn_B = 1;
                p_btn_C = 1;
                p_btn_D = 0;
                if ((~anterior & btn_D)) begin
                    estado = 1;
                end
                anterior = btn_D;
            end
            1: begin    // Jogo em andamento
                //Saida das cores: VGA_R, VGA_G, VGA_B
                // Inicialmente, as cores são pretas (fundo)
                p_btn_A = btn_A;
                p_btn_B = btn_B;
                p_btn_C = btn_C;
                p_btn_D = btn_D;
                posX_tiro_inimigo = posX[ID_enemy_tiro_X] + 10;
                posY_tiro_inimigo = posY[ID_enemy_tiro_Y-1] +1;
                VGA_R = 8'b0;
                VGA_G = 8'b0;
                VGA_B = 8'b0;
                // Verifica se algum pixel da nave está na posição atual
                for (j = 0; j < (LINHAS * COLUNAS); j = j + 1) begin
                    if (vivo_inimigo[j] == 1) begin
                        VGA_R = VGA_R | inimigoR[j];
                        VGA_G = VGA_G | inimigoG[j];
                        VGA_B = VGA_B | inimigoB[j];
                    end
                end
                VGA_R = VGA_R | R_nave | R_municao1 | R_municao2;        
                VGA_G = VGA_G | G_nave | G_municao1 | G_municao2;
                VGA_B = VGA_B | B_nave | B_municao1 | B_municao2;            
                if ((vivo_jogador == 0) || (|game_over)) begin
                    estado = 3;
                end
                if (~|vivo_inimigo) begin
                    estado = 2;
                end
            end
            2: begin
                // Vitória jogador
                VGA_R = R_vitoria;
                VGA_G = G_vitoria;
                VGA_B = ~B_vitoria;
                if (~anterior & btn_D) begin
                    estado = 0;
                end
                anterior = btn_D;
            end
            3: begin
                // Derrota jogador
                VGA_R = R_derrota;
                VGA_G = G_derrota;
                VGA_B = B_derrota;
                if (~anterior & btn_D) begin
                    estado = 0;
                end
                anterior = btn_D;
            end
            default: estado = 0; 
        endcase
    end
end



// Circuitos
reg VGA_CLK2; // 25Mhz
assign VGA_CLK = VGA_CLK2;

always @(posedge clk) begin
    VGA_CLK2 = ~VGA_CLK2;
end

display display1(
    .entrada(ID_enemy_tiro_X),
    .digito0(HEX0), // digito da direita
    .digito1(HEX1),
    .digito2(HEX2),
    // .digito3(HEX3),
    // .digito4(HEX4),
    // .digito5(HEX5)// digito da esquerda
);

display display2(
    .entrada(ID_enemy_tiro_Y),
    .digito0(HEX3), // digito da direita
    .digito1(HEX4),
    .digito2(HEX5),
    // .digito3(HEX3),
    // .digito4(HEX4),
    // .digito5(HEX5)// digito da esquerda
);


reg [31:0] resultado;

integer contador;
endmodule