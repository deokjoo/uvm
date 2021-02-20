//
//
//
//
//
//

`timescale 1ns/1ps


interface axis_if #(
    parameter integer C_AXIS_DARA_WIDTH = 32,
    parameter string  name = "vif"
)
(input ACLK);

    logic a;

endinterface