
class alu_drv;

  // declaration of the class properties
  alu_trans trans_h;
  mailbox #(alu_trans) gen2drv;

  // declaration of the virtual interface
  virtual alu_if.DRV_MP drv_if;

  // declaration of the constructor
  function new(virtual alu_if.DRV_MP drv_if, mailbox#(alu_trans) gen2drv);
    this.drv_if  = drv_if;
    this.gen2drv = gen2drv;
  endfunction

  // declaration of the drive task
  virtual task drive;
    begin
      // drive the interface signals
      @(drv_if.drv_cb);
      drv_if.drv_cb.a_in  <= trans_h.a_in;
      drv_if.drv_cb.b_in  <= trans_h.b_in;
      drv_if.drv_cb.op_in <= trans_h.op_in;
      @(drv_if.drv_cb);
    end
  endtask : drive

  // declaration of the start task
  virtual task start;
    fork
      forever begin
        gen2drv.get(trans_h);
        drive();
      end
    join_none
  endtask : start

endclass : alu_drv

