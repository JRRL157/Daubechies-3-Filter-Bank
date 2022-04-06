module polifase2dec(input	clk1, clk2, rst,input [15:0] x, output reg [15:0] x0, x1);

	reg [15:0] z1x0, z1x1;
		
	reg paridade;
		
	wire [15:0] next_z1x0, next_z1x1;	
	
	// Sincronismo clk1
	always @ (posedge clk1 or posedge rst) 
	begin
		if (rst == 1) 
		begin
			z1x0 <= 16'd0;
			z1x1 <= 16'd0;
			paridade <= 1'b1;
		end
		else 
		begin
			z1x0 <= next_z1x0;
			z1x1 <= next_z1x1;
			paridade <= ~paridade;
		end
	end	
	
	assign next_z1x0 = paridade? z1x0 : x;
	assign next_z1x1 = paridade? x : z1x1;
		
	
	// Sincronismo clk2
	always @ (posedge clk2 or posedge rst) 
	begin
		if (rst == 1) 
		begin
			x0 <= 16'd0;
			x1 <= 16'd0;
		end
		else 
		begin
			x0 <= z1x0;
			x1 <= z1x1;
		end
	end
	
endmodule

