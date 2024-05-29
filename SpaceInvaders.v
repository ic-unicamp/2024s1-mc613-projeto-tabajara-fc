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
   output wire VGA_CLK 

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

// Variáveis intermediárias para as cores das naves
//Fios
reg [9:0] posX [7:0];
reg [9:0] posY [7:0];
wire [9:0] h_counter;
wire [9:0] v_counter;
wire [7:0] inimigoR [23:0];
wire [7:0] inimigoG [23:0];
wire [7:0] inimigoB [23:0];

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
    end

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

endmodule