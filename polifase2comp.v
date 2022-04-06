module polifase2comp(input clk1, rst, input [15:0] x0,x1, output reg [15:0] y);

	reg paridade;
	
	wire [15:0] next_y;
	
	always @(posedge clk1 or posedge rst)
	begin
		if(rst == 1)
		begin
			y <= 16'd0;
			paridade <= 1'b0;
		end
		else
		begin
			y <= next_y;
			paridade <= ~paridade;
		end
	end
	
	assign next_y = paridade ? x1 : x0;
	
endmodule
