//
//
//
//
//

class axis_monitor extends uvm_monitor;
    `uvm_component_utils(axis_monitor)

    axis_agent_cfg m_cfg;
    uvm_analysis_port #(axis_pixel) m_analysys_port;

    //
    function new(string name="axis_monitor", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    //
    extern virtual function void build_phase(uvm_phase phase);
    // extern virtual task run_phase(uvm_phase phase);
endclass

//
function void axis_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if( !uvm_config_db#(axis_agent_cfg)::get(this, "", "cfg", m_cfg) )
        `uvm_fatal(get_full_name(), "cannot find cfg")

    m_analysys_port = new("m_analysys_port", this);

endfunction

//
// task axis_monitor::run_phase(uvm_phase phase);
//     super.run_phase(phase);

//     forever begin
//         @(posedge m_cfg._if);

//         `uvm_info(get_full_name(), "HI", UVM_LOW);
//     end
// endtask