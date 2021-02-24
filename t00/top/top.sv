//
//
//
//
//
//

//`timescale 1ns/1ps

//
//
module top ();

    `include "uvm_macros.svh"

    import uvm_pkg::*;
    import axis_test_pkg::*;

    bit clk;

    always #10 clk = ~clk;

    axis_if axis_m00(clk);
    axis_if axis_s00(clk);

    initial begin
        
        uvm_config_db#(virtual axis_if)::set(null, "", "axis_m00", axis_m00);
        uvm_config_db#(virtual axis_if)::set(null, "", "axis_s00", axis_s00);
        run_test("filter_base_test");

        #1000 $finish;
    end


endmodule
