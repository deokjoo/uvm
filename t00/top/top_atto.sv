//----------------------------------------------------------
//
//
//
//
//----------------------------------------------------------

`timescale 1ns/1ps

//
//
module top ();

    `include "uvm_macros.svh"

    import uvm_pkg::*;
    import atto_test_pkg::*;

    bit clk;

    always #10 clk = ~clk;

    axis_if axis_m00(clk);
    axis_if axis_s00(clk);

    string file_i="cruel 3 3 2";
    string file_o="cruel 3 3 2";    


    initial begin
        //uvm_config_db#(string)::set(null, "", "file_i", file_i);
        //uvm_config_db#(string)::set(null, "", "file_o", file_o);    
        //uvm_config_db#(virtual axis_if)::set(null, "", "axis_m00", axis_m00);
        //uvm_config_db#(virtual axis_if)::set(null, "", "axis_s00", axis_s00);
        
        //run_test("filter_base_test");

        //#1000 $finish;
    end


endmodule