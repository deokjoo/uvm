//---------------------------------------------------------
//
//
//
//---------------------------------------------------------
class frame_seq extends uvm_sequence;
    `uvm_object_utils(frame_seq)

    //
    string      m_prefix;
    int         m_nr    ;
    
    //
    function new(string name="frame_seq");
        super.new(name);
    endfunction 
    
    //
    extern virtual task body();

endclass

//
//
task frame_seq::body();
    frame_seq_item frame;

    for(int i=0; i < m_nr; i++) begin 
        frame = frame_seq_item::type_id::create("frame");

        start_item(frame);
    
        frame.m_input_file = $sformatf("%s_%02d.txt", m_prefix, i);
        frame.m_w          = 3;
        frame.m_h          = 3;

        `uvm_info("SEQ", $sformatf("Generate new frame : %s", frame.convert2str()), UVM_LOW);

        finish_item(frame);
    end

endtask

