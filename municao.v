module municao(
    input [9:0] h_counter,
	input reset,
    input [9:0] v_counter,
	input [10:0] mem_X_barra,
    output reg [7:0]R,
    output reg [7:0]G,
    output reg [7:0]B
);
	 
always @(h_counter) begin
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
			
			////////////////////////////////////para mover cima ou para baixo so alterar 509 - v_counter
        else if (((mem_X_barra - h_counter) < 1) && ((509 - v_counter) < 20)) begin
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