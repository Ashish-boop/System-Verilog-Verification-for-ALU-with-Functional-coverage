class alu_gen;

  // declaration of the class properties
  alu_trans trans_h;
  mailbox #(alu_trans) gen2drv;
  integer i;

  // declaration of the constructor
  function new(mailbox#(alu_trans) gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  // declaration of the start task
  virtual task start;
    fork
      for (i = 0; i < no_of_transactions; i++) begin
        trans_h = new();
        // randomize the transaction
        assert (trans_h.randomize());
        gen2drv.put(trans_h);
      end
    join_none
  endtask : start

endclass : alu_gen
