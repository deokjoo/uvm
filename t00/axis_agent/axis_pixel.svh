//
//
//
//
//


class axis_pixel extends uvm_sequence_item;
    `uvm_object_utils(axis_pixel)

    rand bit [15:0] v;
    
    virtual function string convert2str();
        return $sformatf("pixel %0x", v);
    endfunction

    function new(string name="axis_pixel");
        super.new(name);
    endfunction


endclass