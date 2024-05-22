module bola(
    input [9:0] h_counter,
	input reset,
    input [9:0] v_counter,
	input wire [1:0] btn,
	input [10:0] mem_X,
    input [10:0] mem_Y,
    output reg [7:0]R,
    output reg [7:0]G,
    output reg [7:0]B
);
	 
reg [30:0]Raio;	 
	 
	 
always @(h_counter) begin
	if(reset)begin 
		R = 8'b0;
		G = 8'b0;
		B = 8'b0;
	end
	
	Raio = (mem_X - h_counter)*(mem_X - h_counter) + (mem_Y - v_counter)*(mem_Y - v_counter);
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
			
        else if (Raio <= 40) begin
		  
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
