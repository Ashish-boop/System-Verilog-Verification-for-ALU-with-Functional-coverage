class alu_env;

  // declaration of virtual interfaces
  virtual alu_if.DRV_MP drv_if;
  virtual alu_if.MON_MP mon_if;

  // declaration of the mailboxes
  mailbox #(alu_trans) gen2drv = new();
  mailbox #(alu_trans) mon2rm = new();
  mailbox #(alu_trans) mon2sb = new();
  mailbox #(alu_trans) rm2sb = new();

  // declaration of the handle for the env classes
  alu_gen gen_h;
  alu_drv drv_h;
  alu_mon mon_h;
  alu_sb sb_h;
  alu_rm rm_h;

  // the constructor for the env class
  function new(virtual alu_if.DRV_MP drv_if, virtual alu_if.MON_MP mon_if);
    this.drv_if = drv_if;
    this.mon_if = mon_if;
  endfunction : new

  // the build task for the env class
  virtual task build();
    gen_h = new(gen2drv);
    drv_h = new(drv_if, gen2drv);
    mon_h = new(mon_if, mon2rm, mon2sb);
    rm_h  = new(mon2rm, rm2sb);
    sb_h  = new(mon2sb, rm2sb);
  endtask : build

  // the start task for the env class
  virtual task start();
    fork
      gen_h.start();
      drv_h.start();
      mon_h.start();
      rm_h.start();
      sb_h.start();
    join_none
  endtask : start

  // the run task for the env class
  virtual task run();
    build();
    start();
    // wait for the DONE event from the scoreboard
    @(sb_h.DONE.triggered);
    // report the results
    sb_h.report();
  endtask : run

endclass : alu_env

