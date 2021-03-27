    //-----------------------------------------------------------------------------
    // 
    //
    //-----------------------------------------------------------------------------
    class atto_env extends uvm_env;
        `uvm_component_utils(atto_env)

        atto_env_cfg    m_env_cfg     ;
        atto_agent_cfg  m_atto_m00_cfg;
        axis_agent_cfg  m_axis_s00_cfg;

        atto_agent      m_atto_m00    ;
        axis_agent      m_axis_s00    ;
        axis_scbd       m_axis_scbd   ;

        filter_seq      m_seq         ;
        filter_sqr      m_sqr         ;

        function new(string name="atto_env", uvm_component parent=null);
            super.new(name, parent);
        endfunction

        //
        extern virtual function void build_phase  (uvm_phase phase);
        extern virtual function void connect_phase(uvm_phase phase);
        extern virtual task          run_phase    (uvm_phase phase);
    endclass

//
// function : build_phase
//
    function void atto_env::build_phase(uvm_phase phase);
        super.build_phase(phase);
    
        if( !uvm_config_db#(atto_env_cfg)::get(this, "", "m_env_cfg", m_env_cfg) )
            `uvm_fatal(get_full_name(), "cannot get m_env_cfg");
    
    //create instance for enviromnet
        m_atto_m00_cfg = atto_agent_cfg::type_id::create("m_atto_m00_cfg", this);
        m_axis_s00_cfg = axis_agent_cfg::type_id::create("m_axis_s00_cfg", this);
        m_atto_m00     = atto_agent    ::type_id::create("m_atto_m00" ,    this);
        m_axis_s00     = axis_agent    ::type_id::create("m_axis_s00" ,    this);
    
        m_axis_scbd    = axis_scbd     ::type_id::create("m_axis_scbd",    this);
        m_seq          = filter_seq    ::type_id::create("m_seq",          this);
        m_sqr          = filter_sqr    ::type_id::create("m_sqr",          this);
    
    //set config m00
        m_atto_m00_cfg._if = m_env_cfg.atto_if_m00;
        m_atto_m00_cfg.is_active = UVM_ACTIVE;
    
        uvm_config_db#(atto_agent_cfg)::set(this,"m_atto_m00", "cfg", m_atto_m00_cfg);
        
    //set config s00
        m_axis_s00_cfg._if = m_env_cfg.axis_if_s00;
        m_axis_s00_cfg.is_active = UVM_PASSIVE;
    
        uvm_config_db#(axis_agent_cfg)::set(this,"m_axis_s00",  "cfg", m_axis_s00_cfg);
    
    //set score board
        uvm_config_db#(string)::set(this,"m_axis_scbd",  "cfg",  m_env_cfg.m_file_o);
        
    //set config seq
        m_seq.m_file_prefix = m_env_cfg.m_file_i;
    
    endfunction

//
// function : connect_phase
    function void atto_env::connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        // m_atto_m00.m_mon.m_analysys_port.connect(m_axis_scbd.m_analysis_imp);

        // connect sequencer to virtual sequencer
        m_sqr.m_axis_seqr = m_atto_m00.m_sqr;


    endfunction

//
//
task atto_env::run_phase(uvm_phase phase);
    super.run_phase(phase);

    phase.raise_objection(this);

    m_seq.start(m_sqr);

    phase.drop_objection(this);

endtask






















