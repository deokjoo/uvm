//---------------------------------------------------------
//
//
//
//--------------------------------------------------------
class filter_seq extends uvm_sequence;
    `uvm_object_utils(filter_seq)
    `uvm_declare_p_sequencer(filter_sequencer);

    frame_seq   m_frame_seq;

    //
    function new(string name="filter_seq");
        super.new(filter_seq);
    endfunction

    //
    extern virtual task pre_body();
    extern virtual task body();
endclass


//
//
task filter_seq::pre_body()
    m_frame_seq = frame_seq::type_id::create("frame_seq");


endtask

//
//
task filter_seq::body()
    m_frame_seq.start(p_sequencer.m_axis_seqr)    
endtask