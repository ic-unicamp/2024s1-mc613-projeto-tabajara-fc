module SpaceInvaders(
	input clk,
	input reset,
	input btn_A,
	input btn_B,
	input btn_C,
	input btn_D, // Será um restart do jogo
    output wire [7:0] VGA_R,
    output wire [7:0] VGA_G,
    output wire [7:0] VGA_B,
    output wire VGA_BLANK_N,
    output wire VGA_SYNC_N,
    output wire VGA_HS,
    output wire VGA_VS,
    output wire VGA_CLK,
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
wire [7:0] R_barra;
wire [7:0] G_barra;
wire [7:0] B_barra;
wire [7:0] R_bola;
wire [7:0] G_bola;
wire [7:0] B_bola;
reg [19:0] contador;
reg [18:0] contador_botao;

//Modulos
reg [3:0] estado_barra;
reg [3:0] estado_bola;

nave nave(
    .h_counter(h_counter),
    .v_counter(v_counter),
	 .reset(reset),
	 .clk(clk),
    .posX(memo_X_nave),
    .R(R_barra),
    .G(G_barra),
    .B(B_barra)
);

/*
bola2 bola(
    .h_counter(h_counter),
    .v_counter(v_counter),
	.reset(reset),
    .mem_X(mem_X_bola),
    .mem_Y(mem_Y_bola),
    .R(R_bola),
    .G(G_bola),
    .B(B_bola)
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


// Circuitos
reg VGA_CLK2; // 25Mhz
assign VGA_CLK = VGA_CLK2;

reg [10:0] memo_X_nave;
reg [10:0] mem_X_nave;
reg [10:0] memo_X_bola;
reg [10:0] memo_Y_bola;
reg [10:0] mem_X_bola;
reg [10:0] mem_Y_bola;
reg [6:0] delta_X_bola;
reg [6:0] delta_Y_bola;

assign VGA_R = R_barra ^ R_bola;
assign VGA_G = G_barra ^ G_bola;
assign VGA_B = B_barra ^ B_bola;


always @(posedge clk) begin
    VGA_CLK2 = ~VGA_CLK2;
end

// Máquina de estados da barra
always @(posedge clk) begin

	if(contador_botao == 0)begin 
	 
    if (~btn_D) begin
        // Resetando posição da barra
        mem_X_nave = 445;
        estado_barra = 3'b000;
		  memo_X_nave = 445;
		  contador_botao = 0;

    end else begin
        case (estado_barra)
        3'b000: begin
            mem_X_nave = memo_X_nave;
            if (~btn_B) begin
              estado_barra = 3'b001;
            end else 
            if (~btn_A) begin
              estado_barra = 3'b010;
            end 
		end
        3'b001: begin
            memo_X_nave = memo_X_nave + 16;					 
			if(memo_X_nave > 765)begin
			    memo_X_nave = memo_X_nave - 16;	 
			end
            estado_barra = 3'b011;
        end
        3'b010: begin
            memo_X_nave = memo_X_nave - 16;	 
			if(memo_X_nave < 134) begin
				memo_X_nave = memo_X_nave + 16;	 
			end	 
            estado_barra = 3'b011;
        end
        default: estado_barra = 3'b000;
        endcase
    end
	 
	end 
	 
	 contador_botao = contador_botao + 1;
end

/*
// Máquina de estados da bola
always @(posedge clk) begin

    if (~btn_D || reset) begin
    // Resetando posição da bola
        mem_X_bola = 464;
        memo_X_bola = 464;
        mem_Y_bola = 275;
        memo_Y_bola = 275;
        delta_X_bola = 2;
        delta_Y_bola = 2;
        estado_bola = 0;
		contador = 0;
        pontuacao = 0;
        if (reset) begin
            record = 0;
        end
    end
    else if (contador == 0) begin // 
        case(estado_bola)
            0: begin // Caindo para esquerda
                memo_X_bola = memo_X_bola - delta_X_bola;
                memo_Y_bola = memo_Y_bola + delta_Y_bola;
					if (memo_Y_bola > 485) begin
						if ((memo_X_bola >= memo_X_barra - 170) && (memo_X_bola <= memo_X_barra )) begin // Verificando as posições da barra
                            pontuacao = pontuacao + 1; // Incrementando a pontuação a cada vez que a bola bate na barra
                            delta_Y_bola = delta_Y_bola + 1;
									delta_X_bola = delta_X_bola + 1;

                            if ((mem_X_bola >= mem_X_barra - 170) && (memo_X_bola <= memo_X_barra - 140)) begin
                                estado_bola = 2;
                                delta_X_bola = delta_X_bola + 1;
                                delta_Y_bola = delta_Y_bola - 1;
                            end
                            else if ((memo_X_bola > memo_X_barra - 140) && (memo_X_bola <= memo_X_barra - 30)) begin
                                estado_bola = 2;
                            end
                            else begin
                                delta_X_bola = delta_X_bola - 1;
                                delta_Y_bola = delta_Y_bola + 1;
                                estado_bola = 3;
                            end
                            if (delta_Y_bola == 0) begin // Capando delta_Y para não chegar a zero
                                delta_Y_bola = 1;
                            end
                            if (delta_Y_bola > 50) begin // Capando delta_Y para não chegar a zero
                                delta_Y_bola = 50;
                            end
                            if (delta_X_bola == 0) begin // Capando delta_Y para não chegar a zero
                                delta_X_bola = 1;
                            end
						end
						else if (memo_Y_bola > 510) begin
                            estado_bola = 4; // Se perdeu, estado_bola de fim de jogo
						end
					end
                    if (memo_X_bola < 150) begin 
                        estado_bola = 1; // Se bateu na esquerda, cai pra direita
                    end
            end
            1: begin // Caindo para direita
                memo_X_bola = memo_X_bola + delta_X_bola;
                memo_Y_bola = memo_Y_bola + delta_Y_bola;
                if (memo_Y_bola > 485) begin
						if ((memo_X_bola >= memo_X_barra - 170) && (memo_X_bola <= memo_X_barra )) begin // Verificando as posições da barra
                            pontuacao = pontuacao + 1; // Incrementando a pontuação a cada vez que a bola bate na barra
                            delta_Y_bola = delta_Y_bola + 1;
									 delta_X_bola = delta_X_bola + 1;

                            if ((mem_X_bola >= mem_X_barra - 170) && (memo_X_bola <= memo_X_barra - 140)) begin
                                estado_bola = 2;
                                delta_X_bola = delta_X_bola - 1;
                                delta_Y_bola = delta_Y_bola + 1;
                            end
                            else if ((memo_X_bola > memo_X_barra - 140) && (memo_X_bola <= memo_X_barra - 30)) begin
                                estado_bola = 3;
                            end
                            else begin
                                delta_X_bola = delta_X_bola + 1;
                                delta_Y_bola = delta_Y_bola - 1;
                                estado_bola = 3;
                            end
                            if (delta_Y_bola == 0) begin // Capando delta_Y para nao chegar a zero
                                delta_Y_bola = 1;
                            end
                            if (delta_Y_bola > 50) begin // Capando delta_Y para nao chegar a zero
                                delta_Y_bola = 50;
                            end
                            if (delta_X_bola == 0) begin // Capando delta_Y para nao chegar a zero
                                delta_X_bola = 1;
                            end
						end

						else if (memo_Y_bola > 510) begin
                            estado_bola = 4; // Se perdeu, estado_bola de fim de jogo
						end
					 end
                if (mem_X_bola > 776) begin
                    estado_bola = 0;
                end
            end
            2: begin // Subindo para esquerda
                memo_X_bola = memo_X_bola - delta_X_bola;
                memo_Y_bola = memo_Y_bola - delta_Y_bola;
                if (mem_X_bola < 150) begin
                    estado_bola = 3; // Se bateu na esquerda, sobe para a direita
                end
                else if (mem_Y_bola < 55) begin // Se bateu em cima, desce para a esquerda
                    estado_bola = 0;
                end
            end
            3: begin // Subindo para direita
                memo_X_bola = memo_X_bola + delta_X_bola;
                memo_Y_bola = memo_Y_bola - delta_Y_bola;
                if (mem_X_bola > 776) begin // Se bateu na direita, sobe para a esquerda
                    estado_bola = 2;
                end
                else if (mem_Y_bola < 55) begin // Se bateu em cima, desce para a esquerda
                    estado_bola = 1;
                end            
            end
            4: begin // Fim de jogo
                if (pontuacao >= record) begin
                    record = pontuacao;
                end
                if (~btn_D) begin
                    estado_bola = 0;
                end
            end
            default: begin
                estado_bola = 0;
            end
        endcase
    end
    mem_X_bola = memo_X_bola;
    mem_Y_bola = memo_Y_bola;
    contador = contador + 1;
end
*/


endmodule