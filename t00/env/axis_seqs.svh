//
//
//
//

class axis_seqs extends uvm_sequence;
    `uvm_object_utils(axis_seqs)

    function new(string name="axis_seqs");
        super.new(name);
    endfunction

    extern virtual task body();

endclass

//
//
task axis_seqs::body();

    for(int i=0; i<5; i++) begin
        axis_pixel item = axis_pixel::type_id::create("item");
    
        start_item(item);
        
        item.randomize();
        `uvm_info("SEQ", $sformatf("Generate new item : %s", item.convert2str()), UVM_LOW);

        finish_item(item);
    end

endtask

