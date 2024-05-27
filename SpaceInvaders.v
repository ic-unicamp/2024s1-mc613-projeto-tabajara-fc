/*modulo principal*/
module SpaceInvaders(
	input clk,
	input reset,
	input btn_A,
	input btn_B,
	input btn_C,
	input btn_D,
	
	/*Posicoes dos modulos*/
	output wire [10:0] posX_Nave, //liga SpaceInvaders com nave
	output wire [10:0] posX_Municao1, //liga SpaceInvaders com municao1
	output wire [10:0] posY_Municao1, //liga SpaceInvaders com municao1
	output wire [10:0] posX_Municao2, //liga SpaceInvaders com municao2
	output wire [10:0] posY_Municao2, //liga SpaceInvaders com municao2
	//output wire [1:0] colisao_inimigo, //ALTERAR QUANDO TIVER O INIMIGO
	output wire [1:0] tiro_ativo_jogador,
	
	output wire [1:0] vivo_jogador,
    
	/*Partes do VGA*/
	output wire [7:0] VGA_R,
    output wire [7:0] VGA_G,
    output wire [7:0] VGA_B,
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

//Fios
wire [9:0] h_counter;
wire [9:0] v_counter;
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

/*
// Display

reg [11:0] pontuacao;
reg [11:0] record;
wire [11:0] placar_atual;
wire [11:0] placar_record;

assign placar_atual = pontuacao;
assign placar_record = record;


display display1(
    .entrada(placar_atual),
    .digito0(HEX0), // digito da direita
    .digito1(HEX1),
    .digito2(HEX2)// digito da esquerda
);

display display2(
    .entrada(placar_record),
    .digito0(HEX3), // digito da direita
    .digito1(HEX4),
    .digito2(HEX5)// digito da esquerda
);
*/

// Circuitos
reg VGA_CLK2; // 25Mhz
assign VGA_CLK = VGA_CLK2;

//Liga os fios
assign VGA_R = R_nave ^ R_municao1 ^ R_municao2;
assign VGA_G = G_nave ^ G_municao1 ^ G_municao2;
assign VGA_B = B_nave ^ B_municao1 ^ B_municao2;

always @(posedge clk) begin
    VGA_CLK2 = ~VGA_CLK2;
	 
	 ///////Teste vida jogador
	 
	 /*
	 if(vivo_jogador == 1)begin
			HEX0[0] = 1;
	 end else begin
			HEX0[0] = 0;
	 end
	 */
end


endmodule