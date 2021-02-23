//
//
//
//
//
class filter_env extends uvm_env;
    `uvm_component_utils(filter_env)

    filter_env_cfg m_env_cfg;

    function new(string name="filter_env", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    //
    extern virtual function void build_phase (uvm_phase phase);

endclass

//
//
function void filter_env::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if( !uvm_config_db#(filter_env_cfg)::get(this, "", "m_env_cfg", m_env_cfg) )
        `uvm_fatal(get_full_name(), "cannot get m_env_cfg");

    
endfunction


//-----------------------------------------------------------------------------
// 
//
//-----------------------------------------------------------------------------
class filter00_env extends filter_env;
    `uvm_component_utils(filter00_env)

    axis_agent_cfg  m_axis_m00_cfg;
    axis_agent_cfg  m_axis_s00_cfg;
    
    axis_agent      m_axis_m00    ;
    axis_agent      m_axis_s00    ;
    axis_scbd       m_axis_scbd   ;
    axis_seqs       m_seqs        ;

    function new(string name="filter00_env", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    //
    extern virtual function void build_phase  (uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    extern virtual task          run_phase    (uvm_phase phase);
endclass

//
//
function void filter00_env::build_phase(uvm_phase phase);
    super.build_phase(phase);

    m_axis_m00_cfg = axis_agent_cfg::type_id::create("m_axis_m00_cfg", this);
    m_axis_s00_cfg = axis_agent_cfg::type_id::create("m_axis_s00_cfg", this);
    m_seqs         = axis_seqs     ::type_id::create("m_seqs",         this);
    m_axis_m00     = axis_agent    ::type_id::create("m_axis_m00" ,    this);
    m_axis_s00     = axis_agent    ::type_id::create("m_axis_s00" ,    this);
    m_axis_scbd    = axis_scbd     ::type_id::create("m_axis_scbd",    this);

    //set config
    m_axis_m00_cfg._if = m_env_cfg.axis_if_m00;
    
    uvm_config_db#(axis_agent_cfg)::set(this,"m_axis_m00*", "cfg", m_axis_m00_cfg);
    uvm_config_db#(axis_agent_cfg)::set(this,"m_axis_s00", "cfg", m_axis_s00_cfg);

endfunction

//
//
function void filter00_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    m_axis_m00.m_mon.m_analysys_port.connect(m_axis_scbd.m_analysis_imp);

endfunction

//
//
task filter00_env::run_phase(uvm_phase phase);
    super.run_phase(phase);

    phase.raise_objection(this);

    m_seqs.start(m_axis_m00.m_sqr);

    phase.drop_objection(this);

endtask






















