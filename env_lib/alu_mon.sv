class alu_mon;

  // declaration of the properties
  alu_trans trans_h;
  alu_trans trans_rm_h;
  alu_trans trans_sb_h;

  mailbox #(alu_trans) mon2rm;
  mailbox #(alu_trans) mon2sb;

  // declaration of the virtual interface
  virtual alu_if.MON_MP mon_if;

  // constructor
  function new(virtual alu_if.MON_MP mon_if, mailbox#(alu_trans) mon2rm,
               mailbox#(alu_trans) mon2sb);
    this.mon_if = mon_if;
    this.mon2rm = mon2rm;
    this.mon2sb = mon2sb;
    trans_h = new();
  endfunction : new

  // main monitoring task
  virtual task monitor();
    @(mon_if.mon_cb);
    trans_h.a_in = mon_if.mon_cb.a_in;
    trans_h.b_in = mon_if.mon_cb.b_in;
    trans_h.op_in = mon_if.mon_cb.op_in;
    trans_h.result_out = mon_if.mon_cb.result_out;
    @(mon_if.mon_cb);
  endtask : monitor

  // task to send transaction to scoreboard and ref model
  virtual task start();
    fork
      forever begin
        monitor();
        trans_rm_h = new trans_h;
        trans_sb_h = new trans_h;
        mon2rm.put(trans_rm_h);
        mon2sb.put(trans_sb_h);
      end
    join_none
  endtask : start

endclass : alu_mon
