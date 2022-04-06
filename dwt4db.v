// Modulo principal
module dwt4db(
	input	clk, rst,
	input signed [15:0] x,
	output clk2,
	output signed [15:0] a, d
);

	// Declaracao de fios auxiliares
	wire signed [15:0] x0, x1;
	
	// Declaracao dos registros z^(-1) expandidos
	reg signed [23:0] z01, z02, z03, z04, z11, z12, z13, z14, z15, z16;
	

	// componentes auxiliares RAG e filtros
	wire signed [23:0] x0_9, x0_22, x0_35, x0_85,x0_118,x0_207;
	wire signed [23:0] x1_9, x1_22, x1_35, x1_85,x1_118,x1_207;
	wire signed [23:0] x0h00, x0h10, x1h01, x1h11, ae, de;

	// Modulos externos
	clock2gerente gerente(clk, rst, clk2);
	polifase2dec decomp(clk, clk2, rst, x, x0, x1);
	rag4db rag0(x0, x0_9, x0_22, x0_35, x0_85,x0_118,x0_207);
	rag4db rag1(x1, x1_9, x1_22, x1_35, x1_85,x1_118,x1_207);

	// Sincronismo
	always @ (posedge clk2 or posedge rst) begin
		if (rst == 1) begin
			z01 <= 24'd0;
			z02 <= 24'd0;
			z03 <= 24'd0;
			z04 <= 24'd0;
			z11 <= 24'd0;
			z12 <= 24'd0;
			z13 <= 24'd0;
			z14 <= 24'd0;
			z15 <= 24'd0;
			z16 <= 24'd0;
		end
		else begin
			z01 <= x0_207;
			z02 <= z01 - x0_35;
			z03 <= x0_22;
			z04 <= z03 - x0_118;
			
			z11 <= x1_85;
			z12 <= z11 + x1_118;
			z13 <= z12 - x1_22;
			z14 <= x1_9;
			z15 <= z14 - x1_35;
			z16 <= z15 + x1_207;
		end
	end
	
	// Combinacional
	
	assign x0h00 = x0_9 + z02;
	assign x0h10 = z04 -x0_85;
	assign x1h01 = z13;
	assign x1h11 = z16;
	assign ae = x0h00 + x1h01;
	assign de = x0h10 + x1h11;
	
	// Saida
	
	assign a = ae[23:8];
	assign d = de[23:8];
	
endmodule
