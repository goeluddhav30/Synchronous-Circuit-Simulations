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

module fsm (
    input [2 : 0] q, // Takes in a 3-bit current state
    input x_in, // Takes the input
    input clk, 
    input reset,
    output [2 : 0] qn, // Returns the next state (3-bit)
    output y_out // Returns the output
);
    wire qnbar [2 : 0], dd [2 : 0];
    //Here, we assign the inputs to D-FFs in terms of the 
    //input x and the current state q :
    assign dd[2] = (q[2] & (~q[0])) | (q[1] & q[0]); 
    assign dd[1] = (q[1] & (~q[0])) | ((~q[2]) & (~q[1]) & q[0]); 
    assign dd[0] = (~q[0]) & (q[2] | q[1] | x_in); 
    //We call the 3 D-FF units as following to implement the FSM:
    dff  D1( dd[2], clk, qn[2], qnbar[2], reset);
    dff  D2( dd[1], clk, qn[1], qnbar[1], reset);
    dff  D3( dd[0], clk, qn[0], qnbar[0], reset);
    assign y_out = (~q[2]) & (~q[1]) & (q[0]);
endmodule