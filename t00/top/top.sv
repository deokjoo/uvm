//
//
//
//
//
//

`timescale 1ns/1ps

//
//
module top ();

    `include "uvm_macros.svh"

    import uvm_pkg::*;
    import axis_test_pkg::*;

    bit clk;

    always #10 clk = ~clk;

    axis_if axis_if0(clk);

    initial begin
        $display("hello");

        run_test();


        #100 $finish;
    end


endmodule
