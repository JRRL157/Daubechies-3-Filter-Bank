module rag4db(
	input signed [15:0] x,
	output signed [23:0] x9,x22, x35,x85,x118,x207
);

	wire signed [23:0] x11, x59;
	
	// RAG	
	
	assign x35 = (x <<< 5) + (x <<< 1) + x;
	assign x9 = (x <<< 3) + x;
	assign x11 = x9 + (x <<< 1);
	assign x59 = (x <<< 6) - (x <<< 2) - x;
	assign x85 = (x <<< 7) - (x <<< 5) - x11;
	assign x207 = x85 + (x <<< 7) - (x <<< 2) - (x <<< 1);
	
	//Saída
	assign x22 = x11 <<< 1;
	assign x118 = x59 <<< 1;
	
endmodule
