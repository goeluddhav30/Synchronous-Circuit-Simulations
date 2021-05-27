module tb_ringctr;
    reg [3 : 0] q;
    reg clk;
    reg reset;
    wire [3 : 0] qn;
    ringctr DUT( q, clk, reset, qn);
    //initialise the device under test
    //and the clock
    always #5 clk = ~clk;
    
    initial begin
        $dumpfile("ringctr.vcd");
        $dumpvars(0, tb_ringctr);
        $monitor($time, " Current state = %b  Next state = %b", q, qn);
        //print the multiple states as outputs on positive clock edges
        clk <= 0;
        reset <= 0;
        q <= 4'b0001;
        //initialise the clk, reset, and input q
        repeat(1) @(posedge clk) begin
            reset <= 1;
        end
        //execute a full cycle of the counter as follows:
        repeat(30) @(posedge clk) begin
            q <= qn;
        end
        $finish;
    end
endmodule