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


// engine engine(
//     .clk(clk),
//     .reset(reset),
//     .enemy_vivos(),
//     .jogador_vivo(vivo_jogador),
//     .vitoria_enemy(),
//     .btn_D(btn_D),
//     .restart(restart),
//     .vitoria_jogador(),
//     .bloco_pos_X(),
//     .bloco_pos_Y(),
//     .estado_jogo(estado_jogo),
//     .ID_enemy_tiro()
// );

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

nave nave(
    .h_counter(h_counter),
    .v_counter(v_counter),
	.reset(reset),
	.clk(clk),
	.btn_A(btn_A),
	.btn_B(btn_B),
	.btn_C(btn_C),
	.btn_D(btn_D),
	.posX_Municao2(posX_Municao2),
	.posY_Municao2(posY_Municao2),
	.tiro_ativo_jogador(tiro_ativo_jogador),
	.vivo_jogador(vivo_jogador),
   .posX_Nave(posX_Nave),
   .R(R_nave),
   .G(G_nave),
   .B(B_nave)
);

municao1 municao1(
   .h_counter(h_counter),
   .v_counter(v_counter),
	.reset(reset),
	.clk(clk),
	.tiro_ativo_jogador(tiro_ativo_jogador),
	.btn_D(btn_D),
	.colisao_inimigo(colisao_inimigo),
   .posX_Nave(posX_Nave),
	.posX_Municao1(posX_Municao1),
	.posY_Municao1(posY_Municao1),
   .R(R_municao1),
   .G(G_municao1),
   .B(B_municao1)
);
// Variáveis intermediárias para as cores das naves
//Fios
reg [9:0] posX [7:0];
reg [9:0] posY [7:0];
wire [9:0] h_counter;
wire [9:0] v_counter;
wire [7:0] inimigoR [23:0];
wire [7:0] inimigoG [23:0];
wire [7:0] inimigoB [23:0];


//Fios de comunicação nave munição
/*Posicoes dos modulos*/
wire [10:0] posX_Nave; //liga SpaceInvaders com nave
wire [10:0] posX_Municao1; //liga SpaceInvaders com municao1
wire [10:0] posY_Municao1; //liga SpaceInvaders com municao1
wire [10:0] posX_Municao2; //liga SpaceInvaders com municao2
wire [10:0] posY_Municao2; //liga SpaceInvaders com municao2

wire [1:0] colisao_inimigo; //ALTERAR QUANDO TIVER O INIMIGO
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



// Inicializando as posições das naves
integer i, k;

// Initializing the positions of the spaceships
always @(posedge reset) begin
    for (i = 0; i < 8; i = i + 1) begin
        posX[i] <= 180 + i * 80;
    end
    for (k = 0; k < 3; k = k + 1) begin
        posY[k] <= 40 + k * 50;
    end
end

genvar gv_i, gv_k;
generate
    for (gv_k = 0; gv_k < 3; gv_k = gv_k + 1) begin: row
        for (gv_i = 0; gv_i < 8; gv_i = gv_i + 1) begin: inimigos
            Inimigo1 inimigo_inst (
                .clk(clk),
                .posX(posX[gv_i]),
                .posY(posY[gv_k]),
                .h_counter(h_counter),
                .v_counter(v_counter),
                .reset(reset),
                .R(inimigoR[gv_k * 8 + gv_i]),
                .G(inimigoG[gv_k * 8 + gv_i]),
                .B(inimigoB[gv_k * 8 + gv_i])
            );
        end
    end
endgenerate

// Combinação das saídas das naves usando OR
integer j;
always @(clk) begin
        // Inicialmente, as cores são pretas (fundo)
        VGA_R = 8'b0;
        VGA_G = 8'b0;
        VGA_B = 8'b0;
        
        // Verifica se algum pixel da nave está na posição atual
        for (j = 0; j < 24; j = j + 1) begin
                VGA_R = VGA_R | inimigoR[j];
                VGA_G = VGA_G | inimigoG[j];
                VGA_B = VGA_B | inimigoB[j];
        end

        VGA_R = VGA_R | R_nave | R_municao1;        
        VGA_G = VGA_G | G_nave | G_municao1;
        VGA_B = VGA_B | B_nave | B_municao1;
    end


///Tem que alterar para o inimigo
/*
municao2 municao2(
   .h_counter(h_counter),
   .v_counter(v_counter),
	.reset(reset),
	.clk(clk),
	.tiro_ativo_jogador(tiro_ativo_jogador),
	.btn_D(btn_D),
   .posX_Nave(posX_Nave),
	.posX_Municao2(posX_Municao2),
	.posY_Municao2(posY_Municao2),
   .R(R_municao2),
   .G(G_municao2),
   .B(B_municao2)
);
*/

// Circuitos
reg VGA_CLK2; // 25Mhz
assign VGA_CLK = VGA_CLK2;

always @(posedge clk) begin
    VGA_CLK2 = ~VGA_CLK2;
end

//TESTE NUMERO ALEATORIO
random_number rn_inst (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .min_value(min_value),
    .max_value(max_value),
    .random_output(random_output)
);

display display(
    .entrada(resultado),
    .digito0(HEX0), // digito da direita
    .digito1(HEX1),
    .digito2(HEX2),
    // .digito3(HEX3),
    // .digito4(HEX4),
    // .digito5(HEX5)// digito da esquerda
);

reg enable;
wire [31:0] min_value;
wire [31:0] max_value;
wire [31:0] random_output;
reg [31:0] resultado;
reg [18:0] contador;

assign min_value = 2;
assign max_value = 90;


always @(posedge clk ) begin
    if (reset) begin
        contador = 0;
        resultado = 0;
        enable = 0;
    end
    else begin
    contador = contador + 1;
    enable = ~enable;
    end
    if (contador == 0) begin
        resultado = random_output;
    end


    
end


endmodule