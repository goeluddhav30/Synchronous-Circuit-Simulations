module srff ( q, qbar, qcur, s, r, clk, reset);
    input s, r, clk, qcur, reset;
    output reg q, qbar;
    always @(reset == 1) begin  // resets the output to 0
        q = 0; qbar = 1;
    end
    always @(posedge clk) begin //positive edge triggered clock
        if(s == 1 & r == 0) begin
            q = 1; qbar = 0;
        end
        else if (s == 0 & r == 1) begin
            q = 0; qbar = 1;
        end
        else if (s == 0 & r == 0) begin
            q = qcur; qbar = ~qcur;
        end
    end
endmodule

module grayctr (
    input [3 : 0] q,   //Takes in the 4-bit current state
    input clk,
    input reset,
    output [3 : 0] qn   //Counter outputs the next state 
);
    wire qdash[0 : 3], s[0 : 3], r[0 : 3];
    //Now we assign the inputs to SR-FFs in terms of the input q.
    assign s[3] = q[2] & (~q[1]) & (~q[0]);
    assign r[3] = (~q[2]) & (~q[1]) & (~q[0]);
    assign s[2] = (~q[3]) & q[1] & (~q[0]);
    assign r[2] = q[3] & q[1] & (~q[0]);
    assign s[1] = q[0] & (~(q[2] ^ q[3]));
    assign r[1] = q[0] & (q[2] ^ q[3]);
    assign s[0] = (~(q[3] ^ q[2] ^ q[1]));
    assign r[0] = (q[3] ^ q[2] ^ q[1]);
    //To implement the gray code counter, we call 4 SR-FF units as follows :
    srff FF1(qn[3], qdash[3], q[3], s[3], r[3], clk, reset);
    srff FF2(qn[2], qdash[2], q[2], s[2], r[2], clk, reset);
    srff FF3(qn[1], qdash[1], q[1], s[1], r[1], clk, reset);
    srff FF4(qn[0], qdash[0], q[0], s[0], r[0], clk, reset);
endmodule
