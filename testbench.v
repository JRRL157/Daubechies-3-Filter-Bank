// ROM
module ROM(
	input [9:0] addr,
	output [15:0] data
);

	// Declare the ROM variable
	reg [15:0] rom[2**10-1:0];

	initial	begin		
		$readmemb("../../xsimulP.txt",rom,0,999);
	end
	
	assign data = rom[addr];
endmodule

// Contador de 1000

module contador1000(
	input clk, reset,
	output reg [9:0] count
);

	always @ (posedge clk or posedge reset) begin
		if (reset)
			count <= 10'd0;
		else if (count >= 10'd999)
			count <= 10'd0;
		else
			count <= count + 1'd1;
	end

endmodule


module testbench;

reg clk, rst;
wire clk2;
wire [9:0] n;
wire signed [15:0] x;

// barramentos

wire signed [15:0] a1, d1, xs;

contador1000 contador1(.clk(clk), .reset(rst), .count(n));
ROM rom1(.addr(n),.data(x));

dwt4db dwt1(clk, rst, x, clk2, a1, d1);
idwt4db idwt1(clk, rst, a1, d1, xs);

initial // Clock generator
  begin
    clk = 0;
    forever #10 clk = !clk;
  end
  
initial // Reset generator
  begin
    rst = 0;
    #20 rst = 1;
	 #10 rst = 0;
  end

endmodule 