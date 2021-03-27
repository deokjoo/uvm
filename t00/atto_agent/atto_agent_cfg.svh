
//
//
//
//
//

class atto_agent_cfg extends uvm_object;
    `uvm_object_utils(atto_agent_cfg)

    virtual atto_if         _if;
    uvm_active_passive_enum is_active;

    function new(string name="atto_agent_cfg");
        super.new(name);
    endfunction

endclass



