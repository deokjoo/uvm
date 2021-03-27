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

//----------------------------------------------------------
//
//----------------------------------------------------------
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
task axis_driver::drive_item(frame_reader reader);
    int pixel;
    int h        = reader.m_item.m_h;
    int w        = reader.m_item.m_w;
    int last_col = w-1;

    repeat(10) @(_if.cb_master);    
    for(int i=0; i<h; i++) begin     
        
        for(int j=0; j<w; j++) begin
            // control signal
            _if.cb_master.axis_tvalid<= 1;            
            if(i==0 && j==0)
                _if.cb_master.axis_tuser <= 1;
            else
                _if.cb_master.axis_tuser <= 0;               
            if(j==last_col)
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