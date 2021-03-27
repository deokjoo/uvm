//---------------------------------------------------------
//
//
//
//---------------------------------------------------------
class atto_agent extends uvm_agent;
    `uvm_component_utils(atto_agent)

    atto_agent_cfg                  m_cfg;
    atto_driver                     m_drv;
    atto_monitor                    m_mon;
    uvm_sequencer#(frame_seq_item)  m_sqr;

    function new (string name="atto_agent", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

endclass

//
//
function void atto_agent::build_phase (uvm_phase phase);
    super.build_phase(phase);

    //cfg
    if( !uvm_config_db#(atto_agent_cfg)::get(this, "", "cfg", m_cfg) )
        `uvm_fatal(get_full_name(), "cannot find cfg")

    uvm_config_db#(atto_agent_cfg)::set(this,"*", "cfg", m_cfg);
    
    //instantsatto_agentem)::type_id::create("m_sqr", this);
//    end

    m_mon = atto_monitor::type_id::create("m_mon", this);


endfunction

//
//
function void atto_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);


    if(m_cfg.is_active == UVM_ACTIVE) begin
        m_drv.seq_item_port.connect(m_sqr.seq_item_export);
    end

endfunction