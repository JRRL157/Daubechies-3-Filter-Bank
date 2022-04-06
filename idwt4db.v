// Modulo principal
module idwt4db(
	input	clk, rst,
	input signed [15:0] a, d,
	output signed [15:0] x
);

	// Declaracao de fios auxiliares
	wire signed [15:0] x0, x1;
	
	// Declaracao dos registros z^(-1) expandidos
	reg signed [23:0] z01, z02, z03, z04,z05, z11, z12, z13, z14, z15;

	// componentes auxiliares RAG e filtros
	wire signed [23:0] a_9, a_22, a_35, a_85, a_118, a_207;
	wire signed [23:0] d_9, d_22, d_35, d_85, d_118, d_207;
	wire signed [23:0] ag00, ag01, dg10, dg11, x0e, x1e;

	// Modulos externos
	rag4db rag0(a, a_9, a_22, a_35, a_85, a_118, a_207);
	rag4db rag1(d, d_9, d_22, d_35, d_85, d_118, d_207);
	polifase2comp policomp(.clk1(clk),.rst(rst),.x0(x0),.x1(x1),.y(x));

	// Sincronismo
	always @ (posedge clk or posedge rst) begin
		if (rst == 1) begin
			z01 <= 24'd0;
			z02 <= 24'd0;
			z03 <= 24'd0;
			z04 <= 24'd0;
			z05 <= 24'd0;
			z11 <= 24'd0;
			z12 <= 24'd0;
			z13 <= 24'd0;
			z14 <= 24'd0;
			z15 <= 24'd0;			
		end
		else begin
			z01 <= -a_22;
			z02 <= z01 + a_118;
			z03 <= a_9;
			z04 <= z03 - a_35;
			z05 <= z04 + a_207;
			
			z11 <= d_22;
			z12 <= z11 - d_118;
			z13 <= d_9;
			z14 <= z13 - d_35;
			z15 <= z14 + d_207;
		end
	end
	
	// Combinacional
	
	assign ag00 = z02 + a_85;
	assign dg10 = z12 - d_85 ;
	assign ag01 = z05;
	assign dg11 = z15;
	assign x0e = ag00 + dg10;
	assign x1e = ag01 + dg11;
	
	assign x0 = x0e[23:8];
	assign x1 = x1e[23:8];
	
endmodule
