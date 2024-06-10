/*modulo municao*/ module municao1(
	input clk,
	input reset,
	input btn_D,
	input btn_C,
	input [1:0] tiro_ativo_jogador,
	input [10:0] posX_Nave,
	input [9:0] h_counter,
	input [9:0] v_counter,
	input colisao_inimigo, 
	output reg [10:0] posX_Municao1,
	output reg [10:0] posY_Municao1,
   output reg [7:0]R,
   output reg [7:0]G,
   output reg [7:0]B
);

//variaveis internas
reg [10:0] mem_X_municao;
reg [10:0] mem_Y_municao;
reg [1:0] verifica_tiro;
reg [18:0] contador;

localparam Delay = 17'd200000; // Ajuste este valor conforme necessário

//contador para mover a municao pelo mapa
always @(posedge clk) begin
    if (~(btn_D) || (reset)) begin
        contador = 0;
    end else if (contador < Delay) begin
        contador <= contador + 1;
    end else begin
        contador = 0;
    end
end

/*Parte que trata do movimento da municao*/
always @(posedge clk) begin
	 posX_Municao1 = mem_X_municao;
	 posY_Municao1 = mem_Y_municao;

    if (~(btn_D) || (reset)) begin
        mem_X_municao = 0;
		  mem_Y_municao = 0;
		  verifica_tiro = 0;
	// end else if(mem_Y_municao <= 200 && mem_Y_municao != 0) begin /////ALTERAR AQUI PARA AS COLISOES
	end else if(colisao_inimigo == 1) begin
		  mem_X_municao = 0;
		  mem_Y_municao = 0;
		  verifica_tiro = 2;
	 end else if(verifica_tiro == 0 && tiro_ativo_jogador == 1) begin
			mem_X_municao = posX_Nave + 10;
			mem_Y_municao = 489;
			verifica_tiro = 1;
    end else if(tiro_ativo_jogador == 1) begin
		 if (contador == Delay) begin
				
				if(mem_Y_municao - 1 > 20)begin 
					mem_Y_municao = mem_Y_municao - 1;
				end
		 
		 end
	 
    end else begin
		  mem_X_municao = 0;
		  mem_Y_municao = 0;
		  verifica_tiro = 0;
	end
end
	
/*Parte que trata de mostrar a municao na tela*/
always @(posedge clk) begin
	if(reset)begin 
		R = 8'b0;
		G = 8'b0;
		B = 8'b0;
	end
	if (v_counter <= 2) begin
        R = 8'b0;
        G = 8'b0;
        B = 8'b0;
    end else begin
        if (h_counter <= 96) begin
            R = 8'b0;
            G = 8'b0;
            B = 8'b0;
    end
        else if (((mem_X_municao - h_counter) < 1) && ((mem_Y_municao - v_counter) < 20)) begin
			R = 255;
         G = 255;
         B = 255;
        end
    else begin
            R = 8'b0;
            G = 8'b0;
            B = 8'b0;
        end
    end 
end

endmodule