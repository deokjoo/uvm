//---------------------------------------------------------
//
//
//
//---------------------------------------------------------
class frame_reader extends uvm_object;
    `uvm_object_utils(frame_reader)

    int            m_fd  ;

    function new(string name="frame_reader");
        super.new(name);
    endfunction

    //
    function int open(frame_seq_item item);
        `uvm_info("DRV", $sformatf("open file: %0d %s", $time, item.m_input_file), UVM_LOW);        
        m_fd = $fopen(item.m_input_file,"r");
        if(!m_fd) begin
            `uvm_fatal(get_full_name(), "file open failed")
            return 0;
        end

        return 1;

    endfunction

    function int close();
        $fclose(m_fd);
    endfunction

    function int read();
        int pixel;
        assert($fscanf(m_fd, "%h", pixel) == 1);        
        return pixel;
    endfunction 

endclass

//---------------------------------------------------------
//
//
//
//---------------------------------------------------------
class axis_driver extends uvm_driver #(frame_seq_item);
    `uvm_component_utils(axis_driver);        
    axis_agent_cfg m_cfg;
    virtual axis_if _if ;

    function  new(string name="axis_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    //
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
    extern virtual task drive_item(frame_reader reader);

endclass

//
//
function void axis_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if( !uvm_config_db#(axis_agent_cfg)::get(this, "", "cfg", m_cfg) )
        `uvm_fatal(get_full_name(), "cannot find cfg")

    _if = m_cfg._if;

endfunction

//
//
task axis_driver::run_phase(uvm_phase phase);
    frame_seq_item item ;
    frame_reader reader = new();        
    super.run_phase(phase);    
    forever begin
        seq_item_port.get_next_item(item);

        reader.open(item);
        drive_item(reader);
        reader.close();        
        seq_item_port.item_done();
    end

endtask

//
//
//
task axis_driver::drive_item(frame_reader reader);
    int pixel;

    repeat(10) @(_if.cb_master);    
    for(int i=0; i<3; i++) begin     
        for(int j=0; j<3; j++) begin
            // control signal
            _if.cb_master.axis_tvalid<= 1;            
            if(i==0 && j==0)
                _if.cb_master.axis_tuser <= 1;
            else
                _if.cb_master.axis_tuser <= 0;               
            if(j==2)
                _if.cb_master.axis_tlast <= 1;
            else
                _if.cb_master.axis_tlast <= 0;                                     
            //data    
            pixel = reader.read();
            _if.cb_master.axis_tdata <= pixel;               
            @(_if.cb_master);
        end

        _if.cb_master.axis_tvalid<= 0;
        _if.cb_master.axis_tlast <= 0;
        @(_if.cb_master);
    end

    @(_if.cb_master)

    //
    repeat(10) @(_if.cb_master);

endtask