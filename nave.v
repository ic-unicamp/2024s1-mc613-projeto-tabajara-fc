/*modulo da nave*/
module nave #(
    parameter START_Y = 490 // Modifique este valor para ajustar a posição vertical
) (
    input clk,
	 input reset,
	 input btn_A,
	 input btn_B,
	 input btn_C,
	 input btn_D,
    input [9:0] h_counter,
    input [9:0] v_counter,
	 input [10:0] posX_Municao2, //liga SpaceInvaders com municao2
	 input [10:0] posY_Municao2, //liga SpaceInvaders com municao2
	 output reg [1:0] vivo_jogador,
    output reg [10:0] posX_Nave,
	 output reg [1:0] tiro_ativo_jogador,
    output reg [7:0] R,
    output reg [7:0] G,
    output reg [7:0] B
);

	//variaveis internas
	reg [10:0] memo_X_nave;
	reg [10:0] mem_X_nave;
	reg [18:0] contador_botao;
	reg [25:0] contador_botao_c;   
	reg [3:0] estado_nave;

    // Defina a escala do objeto
    localparam SCALE = 2;
    localparam DELAY_TIRO = 40000000;

    // Defina a posição vertical inicial do objeto

	 
localparam BOTAO_DELAY = 20'd100000; // Ajuste este valor conforme necessário

always @(posedge clk) begin
	 /*Reseta a nave e contador para impedir que os botoes sejam pressionados muitas vezes*/
    if (~(btn_D) || (reset)) begin
        contador_botao = 0;
		  contador_botao_c = 0;
		  tiro_ativo_jogador = 0;
    end else if (contador_botao < BOTAO_DELAY) begin
        contador_botao <= contador_botao + 1;
    end else begin
        contador_botao = 0;
    end
	 
	 /*Contador para impedir multiplos tiros*/
	 if (~btn_C && tiro_ativo_jogador == 0) begin
		  tiro_ativo_jogador <= 1;
		  contador_botao_c = 0;
		  
	 end else if (tiro_ativo_jogador == 1) begin
		  contador_botao_c = contador_botao_c + 1;
		  
		  if(contador_botao_c >= DELAY_TIRO)begin
				contador_botao_c = 0;
				tiro_ativo_jogador = 0;
		  end
	end
end

/*Parte que trata o movimento da nave*/
always @(posedge clk) begin

	 posX_Nave = mem_X_nave;

    if (~(btn_D) || (reset)) begin
        mem_X_nave <= 445;
        estado_nave <= 3'b000;
        memo_X_nave <= 445;
	 
    end else if (contador_botao == BOTAO_DELAY) begin
		//tiro_ativo_jogador = 0;
        case (estado_nave)
            3'b000: begin
                mem_X_nave <= memo_X_nave;
                if (~btn_B) begin
                    estado_nave <= 3'b001;
                end else if (~btn_A) begin
                    estado_nave <= 3'b010;
                end
            end
            3'b001: begin
                if ((memo_X_nave + 2) < 765) begin
                    memo_X_nave <= memo_X_nave + 2;
                end
                estado_nave <= 3'b011;
            end
            3'b010: begin
                if ((memo_X_nave - 2) > 134) begin
                    memo_X_nave <= memo_X_nave - 2;
                end
                estado_nave <= 3'b011;
            end
            default: estado_nave <= 3'b000;
        endcase
    end
end


/*Parte que trata se o jogador ainda esta vivo*/
always @(posedge clk) begin
	
	if (~(btn_D) || (reset)) begin
		  vivo_jogador <= 1;
	end else if(posY_Municao2 >= 489 && (posX_Municao2 > mem_X_nave -2 && posX_Municao2 < mem_X_nave + 23))begin 
		  vivo_jogador <= 0;
	end 

end
	
	 /*Parte que trata de montar a imagem da nave na tela*/
    always @(clk) begin
	 
        integer orig_x;
        integer orig_y;

        if (reset) begin
            R = 8'b0;
            G = 8'b0;
            B = 8'b0;
        end else begin
            // Inicialize a cor para preto
            R = 8'b0;
            G = 8'b0;
            B = 8'b0;

            // Defina o padrão da nave espacial
            if ((h_counter >= mem_X_nave) && (h_counter < mem_X_nave + 11 * SCALE) && 
                (v_counter >= START_Y) && (v_counter < START_Y + 11 * SCALE)) begin
                // Calcule a posição na grade original de 11x11
                orig_x = (h_counter - mem_X_nave) / SCALE;
                orig_y = (v_counter - START_Y) / SCALE;

                // Verifique o bit correspondente no padrão
                case (orig_y)
                    0: if (orig_x == 5) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    1: if ((orig_x >= 4) && (orig_x <= 6)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    2: if ((orig_x >= 3) && (orig_x <= 7)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    3: if ((orig_x >= 2) && (orig_x <= 4) || (orig_x >= 6) && (orig_x <= 8)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    4: if ((orig_x >= 1) && (orig_x <= 3) || (orig_x >= 7) && (orig_x <= 9)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    5: if ((orig_x >= 0) && (orig_x <= 10)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    6: if ((orig_x >= 0) && (orig_x <= 10)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    7: if ((orig_x >= 0) && (orig_x <= 10)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    8: if ((orig_x >= 0) && (orig_x <= 10)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    9: if ((orig_x == 2) || (orig_x == 8)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                    10: if ((orig_x == 2) || (orig_x == 8)) begin
                        R = 8'hFF;
                        G = 8'hFF;
                        B = 8'hFF;
                    end
                endcase
            end
        end
    end
endmodule