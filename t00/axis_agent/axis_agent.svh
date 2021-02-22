//
//
//
//
//

class axis_agent extends uvm_agent;
    `uvm_component_utils(axis_agent)

    axis_agent_cfg m_cfg;
    axis_monitor   m_mon;

    function new (string name="axis_agent", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);

endclass

//
//
function void axis_agent::build_phase (uvm_phase phase);
    super.build_phase(phase);

    if( !uvm_config_db#(axis_agent_cfg)::get(this, "", "cfg", m_cfg) )
        `uvm_fatal(get_full_name(), "cannot find m_cfg")


    m_mon = axis_monitor::type_id::create("m_mon", this);

endfunction

