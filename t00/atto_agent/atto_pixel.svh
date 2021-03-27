//
//
//
//
//


class atto_pixel extends uvm_sequence_item;
    `uvm_object_utils(atto_pixel)

    rand bit [14-1:0] v;
    
    virtual function string convert2str();
        return $sformatf("pixel %0x", v);
    endfunction

    function new(string name="atto_pixel");
        super.new(name);
    endfunction


endclass