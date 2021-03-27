//---------------------------------------------------------
//
//
//
//---------------------------------------------------------
class atto_driver extends uvm_driver #(frame_seq_item);
    `uvm_component_utils(atto_driver);        
    atto_agent_cfg m_cfg;
    virtual atto_if _if ;

    function  new(string name="atto_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    //
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
    extern virtual task drive_item(frame_reader reader);

endclass

//
//
function void atto_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if( !uvm_config_db#(atto_agent_cfg)::get(this, "", "cfg", m_cfg) )
        `uvm_fatal(get_full_name(), "cannot find cfg")

    _if = m_cfg._if;

endfunction

//----------------------------------------------------------
//
//----------------------------------------------------------
task atto_driver::run_phase(uvm_phase phase);
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
task atto_driver::drive_item(frame_reader reader);
    int pixel;
    int h        = reader.m_item.m_h;
    int w        = reader.m_item.m_w;
    int last_col = w-1;

    repeat(10) @(_if.cb_master);    
    for(int i=0; i<h; i++) begin     
        
        for(int j=0; j<w; j++) begin
            // control signal
        end
    end
    //
    repeat(10) @(_if.cb_master);

endtask