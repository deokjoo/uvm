//---------------------------------------------------------
//
//
//
//---------------------------------------------------------

class frame_seq extends uvm_sequence;
    `uvm_object_utils(frame_seq)


    function new(string name="frame_seq");
        super.new(name);
    endfunction 

endclass

//
//
task frame_seq::body();
    frame_seq_item frame = frame_seq_item::type_id::create("frame");

    start_item(frame);

    frame.m_input_file = "1.txt"
    frame.m_w          = 3;
    frame.m_h          = 3;

    `uvm_info("SEQ", $sformatf("Generate new frame : %s", frame.convert2str()), UVM_LOW);

    finish_item(item);

endtsk

