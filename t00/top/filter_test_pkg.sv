//
//
//
//
//
//
package filter_test_pkg;
    `include "uvm_macros.svh"
    
    import uvm_pkg::*;

    //utils
    `include "utils.svh"

    //sequnce item
    `include "axis_pixel.svh"
    `include "frame_seq_item.svh"

    //agent 
    `include "axis_driver.svh"
    `include "axis_monitor.svh"
    `include "axis_agent_cfg.svh"
    `include "axis_agent.svh"

    //sequence..
    //`include "frame_seq_cfg.svh"
    //`include "axis_seqs.svh"
    `include "frame_seq.svh"
    `include "filter_seq.svh"
    `include "filter_sqr.svh"
    
    `include "axis_scoreboard.svh"    
    `include "filter_env_cfg.svh"
    `include "filter_env.svh"

    //test
    `include "filter_base_test.svh"

endpackage


