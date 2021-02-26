//---------------------------------------------------------
//
//
//
//---------------------------------------------------------
class filter_base_env extends uvm_env;
    `uvm_component_utils(filter_base_env)

    filter_env_cfg m_env_cfg;

    function new(string name="filter_base_env", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    //
    extern virtual function void build_phase (uvm_phase phase);

endclass

//
//
function void filter_base_env::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if( !uvm_config_db#(filter_env_cfg)::get(this, "", "m_env_cfg", m_env_cfg) )
        `uvm_fatal(get_full_name(), "cannot get m_env_cfg");

    
endfunction

//-----------------------------------------------------------------------------
// 
//
//-----------------------------------------------------------------------------
class filter00_env extends filter_base_env;
    `uvm_component_utils(filter00_env)

    axis_agent_cfg  m_axis_m00_cfg;
    axis_agent_cfg  m_axis_s00_cfg;
    
    axis_agent      m_axis_m00    ;
    axis_agent      m_axis_s00    ;
    axis_scbd       m_axis_scbd   ;
    
    filter_seq      m_seq         ;
    filter_sqr      m_sqr         ;

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
    m_axis_m00     = axis_agent    ::type_id::create("m_axis_m00" ,    this);
    m_axis_s00     = axis_agent    ::type_id::create("m_axis_s00" ,    this);
   
    m_axis_scbd    = axis_scbd     ::type_id::create("m_axis_scbd",    this);
    m_seq          = filter_seq    ::type_id::create("m_seq",          this);
    m_sqr          = filter_sqr    ::type_id::create("m_sqr",          this);

    //set config m00
    m_axis_m00_cfg._if = m_env_cfg.axis_if_m00;
    m_axis_m00_cfg.is_active = UVM_ACTIVE;

    uvm_config_db#(axis_agent_cfg)::set(this,"m_axis_m00", "cfg", m_axis_m00_cfg);
    
    //set config s00
    m_axis_s00_cfg._if = m_env_cfg.axis_if_s00;
    m_axis_s00_cfg.is_active = UVM_PASSIVE;

    uvm_config_db#(axis_agent_cfg)::set(this,"m_axis_s00",  "cfg", m_axis_s00_cfg);
    
    //set config seq
    m_seq.m_file_prefix = m_env_cfg.m_file_i;

endfunction

//
//
function void filter00_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    m_axis_m00.m_mon.m_analysys_port.connect(m_axis_scbd.m_analysis_imp);

    // connect sequencer to virtual sequencer
    m_sqr.m_axis_seqr = m_axis_m00.m_sqr;


endfunction

//
//
task filter00_env::run_phase(uvm_phase phase);
    super.run_phase(phase);

    phase.raise_objection(this);

    m_seq.start(m_sqr);

    phase.drop_objection(this);

endtask






















