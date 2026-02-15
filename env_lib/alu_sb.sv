
class alu_sb;

  // declaration of the event 
  event DONE;

  // declaration of the properties
  alu_trans trans_mon_h;
  alu_trans trans_ref_h;
  alu_trans cov_data;

  // declaration of the static properties
  static int arith_trans_count = 0;
  static int logic_trans_count = 0;
  static int shift_trans_count = 0;

  // declaration of the mailboxes
  mailbox #(alu_trans) rm2sb;
  mailbox #(alu_trans) mon2sb;

  // declaration of the coverage model
  covergroup alu_cov;
    option.per_instance = 1;

    A_IN: coverpoint cov_data.a_in {
      bins ZERO = {0};
      bins LOW1 = {[1 : 25]};
      bins LOW2 = {[26 : 50]};
      bins MID_LOW = {[51 : 75]};
      bins MID = {[76 : 125]};
      bins MID_HIGH = {[126 : 150]};
      bins HIGH1 = {[151 : 200]};
      bins HIGH2 = {[201 : 224]};
      bins MAX = {225};
    }

    B_IN: coverpoint cov_data.b_in {
      bins ZERO = {0};
      bins LOW1 = {[1 : 25]};
      bins LOW2 = {[26 : 50]};
      bins MID_LOW = {[51 : 75]};
      bins MID = {[76 : 125]};
      bins MID_HIGH = {[126 : 150]};
      bins HIGH1 = {[151 : 200]};
      bins HIGH2 = {[201 : 224]};
      bins MAX = {225};
    }

    OP_IN: coverpoint cov_data.op_in {
      bins ADD = {3'b000};
      bins SUB = {3'b001};
      bins AND = {3'b010};
      bins OR = {3'b011};
      bins XOR = {3'b100};
      bins NOT = {3'b101};
      bins SHL = {3'b110};
      bins SHR = {3'b111};
    }

    cross A_IN, B_IN, OP_IN;

  endgroup : alu_cov

  // declaration of the constructor
  function new(mailbox#(alu_trans) rm2sb, mailbox#(alu_trans) mon2sb);
    this.rm2sb = rm2sb;
    this.mon2sb = mon2sb;
    alu_cov = new();
  endfunction : new

  // declaration of the compare task
  virtual task compare();
    if (trans_mon_h.result_out !== trans_ref_h.result_out) begin
      $display("Mismatch Detected!");
    end
  endtask : compare

  // declaration of the start task
  virtual task start();
    fork
      forever begin
        mon2sb.get(trans_mon_h);
        rm2sb.get(trans_ref_h);
        count_ops();
        compare();
        cov_data = new trans_mon_h;
        alu_cov.sample();
      end
    join
  endtask : start

  virtual task count_ops();
    begin
      if (trans_mon_h.op_in < 3'b010) begin
        arith_trans_count++;
      end else if (trans_mon_h.op_in >= 3'b010 && trans_mon_h.op_in < 3'b110) begin
        logic_trans_count++;
      end else if (trans_mon_h.op_in >= 3'b110) begin
        shift_trans_count++;
      end

      if (no_of_transactions == (arith_trans_count + logic_trans_count + shift_trans_count)) begin
        ->DONE;
      end
    end
  endtask : count_ops


  // declaration of the report task
  virtual task report();
    begin
      $display("----------------------SCOREBOARD REPORT------------------------");
      $display("Arithmetic Operations Count: %0d", arith_trans_count);
      $display("Logical Operations Count: %0d", logic_trans_count);
      $display("Shift Operations Count: %0d", shift_trans_count);
      $display("Total number of transactions : %0d", no_of_transactions);
      $display("----------------------------------------------------------------");
    end
  endtask : report

endclass : alu_sb
