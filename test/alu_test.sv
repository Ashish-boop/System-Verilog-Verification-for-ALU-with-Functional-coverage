
class alu_trans_1 extends alu_trans;
  constraint A_In_1 {a_in inside {[224 : 225]};}
  constraint B_In_1 {b_in inside {[224 : 225]};}
endclass : alu_trans_1

// declarting extended class for arithematic expression
class alu_trans_2 extends alu_trans;
  constraint A_IN_2 {a_in inside {[0 : 225]};}
  constraint B_IN_2 {b_in inside {[0 : 225]};}
  constraint OP_IN_2 {op_in inside {[0 : 1]};}
endclass : alu_trans_2

// declaration of the extended class for logic expression 
class alu_trans_3 extends alu_trans;
  constraint OP_IN_3 {op_in inside {[2 : 5]};}
endclass : alu_trans_3

// declaration of the extended class for the shift expression and default values
class alu_trans_4 extends alu_trans;
  constraint OP_IN_4 {op_in inside {[6 : 8]};}
endclass : alu_trans_4



// declaration of the base test class
class alu_base_test;

  // declaration of the virtual interface
  virtual alu_if.DRV_MP drv_if;
  virtual alu_if.MON_MP mon_if;

  // declaration of the handle for the env class
  alu_env env_h;

  // the constructor for the test class
  function new(virtual alu_if.DRV_MP drv_if, virtual alu_if.MON_MP mon_if);
    this.drv_if = drv_if;
    this.mon_if = mon_if;
    env_h = new(drv_if, mon_if);
  endfunction : new

  virtual task build();
    env_h.build();
  endtask : build

  virtual task run();
    env_h.run();
  endtask : run


endclass : alu_base_test

class alu_test_extnd1 extends alu_base_test;

  // declaration of the handle for the transaction class
  alu_trans_1 trans_h1;

  // the constructor for the extended test class
  function new(virtual alu_if.DRV_MP drv_if, virtual alu_if.MON_MP mon_if);
    super.new(drv_if, mon_if);
  endfunction : new

  virtual task build();
    super.build();
  endtask : build

  virtual task run();
    trans_h1 = new();
    env_h.gen_h.trans_h = trans_h1;
    super.run();
  endtask : run

endclass : alu_test_extnd1

// declaration of the extended test classes
class alu_test_extnd2 extends alu_base_test;

  // declaration of the handle for the transaction class
  alu_trans_2 trans_h2;

  function new(virtual alu_if.DRV_MP drv_if, virtual alu_if.MON_MP mon_if);
    super.new(drv_if, mon_if);
  endfunction : new

  virtual task build();
    super.build();
  endtask : build

  virtual task run();
    trans_h2 = new();
    env_h.gen_h.trans_h = trans_h2;
    super.run();
  endtask : run

endclass : alu_test_extnd2


class alu_test_extnd3 extends alu_base_test;

  // declaration of the handle for the transaction class
  alu_trans_3 trans_h3;

  function new(virtual alu_if.DRV_MP drv_if, virtual alu_if.MON_MP mon_if);
    super.new(drv_if, mon_if);
  endfunction : new

  virtual task build();
    super.build();
  endtask : build

  virtual task run();
    trans_h3 = new();
    env_h.gen_h.trans_h = trans_h3;
    super.run();
  endtask : run

endclass : alu_test_extnd3

class alu_test_extnd4 extends alu_base_test;

  // declaration of the handle for the transaction class
  alu_trans_4 trans_h4;

  function new(virtual alu_if.DRV_MP drv_if, virtual alu_if.MON_MP mon_if);
    super.new(drv_if, mon_if);
  endfunction : new

  virtual task build();
    super.build();
  endtask : build

  virtual task run();
    trans_h4 = new();
    env_h.gen_h.trans_h = trans_h4;
    super.run();
  endtask : run

endclass : alu_test_extnd4



