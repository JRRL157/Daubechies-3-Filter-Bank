module clock2gerente(input clk1, rst, output reg clk2);

	always @(negedge clk1 or posedge rst)
	begin
		if(rst == 1)
			clk2 <= 1'b0;
		else
			clk2 <= ~clk2;	
	end

endmodule
