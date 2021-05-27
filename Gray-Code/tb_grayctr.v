module tb_grayctr;
    reg [3 : 0] q;
    reg clk;
    reg reset;
    wire [3 : 0] qn;
    grayctr DUT( q, clk, reset, qn); // initialise the device under test
    always #5 clk = ~clk;            // and the clock

    initial begin
        $dumpfile("grayctr.vcd");
        $dumpvars(0, tb_grayctr);
        $monitor($time, " Current state = %b  Next state = %b", q, qn);
        clk <= 0;
        reset <=0;
        q <= 4'b0000;
        repeat(1) @(posedge clk) begin //reset the input and the output
            reset <=0;
        end
        repeat(31) @(posedge clk) begin //executes a full cycle of the counter
            q <= qn;
        end
        $finish;
    end
endmodule
