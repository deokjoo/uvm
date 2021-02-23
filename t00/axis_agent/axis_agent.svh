//
//
//
//
//

class axis_agent extends uvm_agent;
    `uvm_component_utils(axis_agent)

    axis_agent_cfg               m_cfg;
    axis_driver                  m_drv;
    axis_monitor                 m_mon;
    uvm_sequencer  #(axis_pixel) m_sqr;

    function new (string name="axis_agent", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

endclass

//
//
function void axis_agent::build_phase (uvm_phase phase);
    super.build_phase(phase);

    //cfg
    if( !uvm_config_db#(axis_agent_cfg)::get(this, "", "cfg", m_cfg) )
        `uvm_fatal(get_full_name(), "cannot find cfg")


    uvm_config_db#(axis_agent_cfg)::set(this,"*", "cfg", m_cfg);

    //instants
    m_mon = axis_monitor::type_id::create("m_mon", this);
    m_drv = axis_driver ::type_id::create("m_drv", this);
    m_sqr = uvm_sequencer#(axis_pixel)::type_id::create("m_sqr", this);

endfunction

//
//
function void axis_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    m_drv.seq_item_port.connect(m_sqr.seq_item_export);

endfunction