//
//
//
//
class axis_seqs extends uvm_sequence;
    `uvm_object_utils(axis_seqs);

    function new(string name="axis_seqs");
        super.new(name);
    endfunction

    extern virtual task body();

endclass

//
//
task axis_seqs::body();
    axis_pixel item = axis_pixel::type_id::create("item");

    for(int i=0; i<5; i++) begin
        start_item(item);
        finish_item(item);
    end

endtask

