module dff ( d, clk, qn, qnbar, reset);
    input d, clk, reset;
    output reg qn, qnbar;
    always @(reset == 1) begin // resets the output to 0
        qn = 0; qnbar = 1;
    end
    always @(posedge clk) begin // positive edge triggered clock
        if(d == 0) begin
            qn = 0; qnbar = 1;
        end
        else begin
            qn = 1; qnbar = 0; 
        end
    end
endmodule

module ringctr (
    input [3 : 0] q, // Takes in a 4-bit input
    input clk, 
    input reset,
    output [3 : 0] qn // Returns the next state (4-bit)
);
    wire [3 : 0] qnbar;
    //Here, we assign the inputs to D-FFs in terms of the 
    //input q, and call 4 units of D-FFs as follows :
    dff #1 D1( q[0]^q[1], clk, qn[3], qnbar[3], reset);
    dff #1 D2( q[3], clk, qn[2], qnbar[2], reset);
    dff #1 D3( q[2], clk, qn[1], qnbar[1], reset);
    dff #1 D4( q[1], clk, qn[0], qnbar[0], reset);
endmodule