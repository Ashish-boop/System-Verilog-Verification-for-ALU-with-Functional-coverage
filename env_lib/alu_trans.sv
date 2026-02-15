class alu_trans;

  // declaration of the random logic input signals 
  rand logic [7:0] a_in;
  rand logic [7:0] b_in;
  rand logic [2:0] op_in;

  // declaration of the logic output signal
  logic [15:0] result_out;

  // static int to count the number of transactions
  static int trans_count;

  // constraint
  constraint VALID_OP {op_in inside {[0 : 7]};}
  constraint A_IN {a_in inside {[0 : 225]};}
  constraint B_IN {b_in inside {[0 : 225]};}

  // function to display the transaction information
  virtual function void display(input string msg);
    $display("------------------------------------------");
    $display("Message      : %s", msg);
    $display("A Input      : %0d", a_in);
    $display("B Input      : %0d", b_in);
    $display("Operation    : %0d", op_in);
    $display("Result Output: %0d", result_out);
    $display("------------------------------------------");
  endfunction : display

  // post_random function to increment the transaction count
  function void post_randomize();
    trans_count++;
  endfunction : post_randomize

endclass : alu_trans
