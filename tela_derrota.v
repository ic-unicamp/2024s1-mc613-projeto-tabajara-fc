module tela_derrota #(
    parameter SCALE = 2
) (
    input clk,
    input reset,
    input [9:0] h_counter,
    input [9:0] v_counter,
    input [9:0] posX,
	input [9:0] posY,
    input troca,
    output reg [7:0] R,
    output reg [7:0] G,
    output reg [7:0] B
);
    // Defina a escala do objeto
    localparam RED = 8'hF0;

always @(h_counter or v_counter or reset or troca) begin
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
        // Defina o padrão do alienígena
        if ((h_counter >= posX) && (h_counter < posX + 8 * SCALE) && 
            (v_counter >= posY) && (v_counter < posY + 8 * SCALE)) begin
            // Calcule a posição na grade original de 8x8
            orig_x = (h_counter - posX) / SCALE;
            orig_y = (v_counter - posY) / SCALE;

            // Verifique o bit correspondente no padrão
            case (orig_y)
                0: if ((orig_x >= 2) && (orig_x <= 5)) begin
                    R = RED;
                    G = 8'h00;
                    B = 8'h00;
                end
                1: if ((orig_x >= 1) && (orig_x <= 6)) begin
                    R = RED;
                    G = 8'h00;
                    B = 8'h00;
                end
                2: if ((orig_x >= 0) && (orig_x <= 7)) begin
                    R = RED;
                    G = 8'h00;
                    B = 8'h00;
                end
                3: if ((orig_x == 0) || (orig_x == 1) || 
                      (orig_x == 4) || (orig_x == 5) || 
                      (orig_x == 6) || (orig_x == 7)) begin
                    R = RED;
                    G = 8'h00;
                    B = 8'h00;
                end
                4: if ((orig_x >= 0) && (orig_x <= 7)) begin
                    R = RED;
                    G = 8'h00;
                    B = 8'h00;
                end
                5: if (troca) begin
                    if ((orig_x == 1) || (orig_x == 6)) begin
                        R = RED;
                        G = 8'h00;
                        B = 8'h00;
                    end
                end else begin
                    if ((orig_x == 2) || (orig_x == 5)) begin
                        R = RED;
                        G = 8'h00;
                        B = 8'h00;
                    end
                end
                6: if (troca) begin
                    if ((orig_x == 0) || (orig_x == 2) || 
                        (orig_x == 5) || (orig_x == 7)) begin
                        R = RED;
                        G = 8'h00;
                        B = 8'h00;
                    end
                end else begin
                    if ((orig_x == 1) || (orig_x == 3) || 
                        (orig_x == 4) || (orig_x == 6)) begin
                        R = RED;
                        G = 8'h00;
                        B = 8'h00;
                    end
                end
                7: if (troca) begin
                    if ((orig_x == 1) || (orig_x == 3) || 
                        (orig_x == 4) || (orig_x == 6)) begin
                        R = RED;
                        G = 8'h00;
                        B = 8'h00;
                    end
                end else begin
                    if ((orig_x == 0) || (orig_x == 2) || 
                        (orig_x == 5) || (orig_x == 7)) begin
                        R = RED;
                        G = 8'h00;
                        B = 8'h00;
                    end
                end
            endcase
        end
    end
end

endmodule