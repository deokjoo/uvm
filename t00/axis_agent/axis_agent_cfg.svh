
//
//
//
//
//

class axis_agent_cfg extends uvm_object;
    `uvm_object_utils(axis_agent_cfg)

    virtual axis_if _if;

    function new(string name="axis_agent_cfg");
        super.new(name);
    endfunction

endclass



