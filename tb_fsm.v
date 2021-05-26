module tb_fsm;
    reg [2 : 0] q;
    reg x_in;
    reg clk;
    reg reset;
    wire y_out;
    wire [2 : 0] qn;
    fsm DUT( q, x_in, clk, reset, qn, y_out);
    //initialise the device under test
    //and the clock
    always #5 clk = ~clk;
    always #40 x_in = ~x_in;
    
    initial begin
        $dumpfile("fsm.vcd");
        $dumpvars(0, tb_fsm);
        $monitor($time, " Current state = %b  Next state = %b", q, qn);
        //print the multiple states as outputs on positive clock edges
        clk <= 0;
        x_in <= 1;
        reset <= 0;
        q <= 3'b000;
        //initialise the clk, reset, and input q
        repeat(30) @(posedge clk) begin
            q <= qn;
        end
        $finish;
    end
endmodule