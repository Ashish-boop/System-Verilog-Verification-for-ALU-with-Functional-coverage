
class alu_rm;

  // declaration of the transaction handle
  alu_trans trans_h;

  // declaration of the mailboxes
  mailbox #(alu_trans) mon2rm;
  mailbox #(alu_trans) rm2sb;


  // declaration of the constructor
  function new(mailbox#(alu_trans) mon2rm, mailbox#(alu_trans) rm2sb);
    this.mon2rm = mon2rm;
    this.rm2sb = rm2sb;
    trans_h = new();
  endfunction : new

  // declaration of the alu_ref_model function
  virtual function automatic logic [15:0] alu_ref_model(logic [7:0] a_in, logic [7:0] b_in,
                                                        logic [2:0] op_in);
    case (op_in)
      3'b000:  return a_in + b_in;  // addition
      3'b001:  return a_in - b_in;  // subtraction
      3'b010:  return {8'b0, a_in & b_in};  // bitwise AND
      3'b011:  return {8'b0, a_in | b_in};  // bitwise OR
      3'b100:  return {8'b0, a_in ^ b_in};  // bitwise XOR
      3'b101:  return {8'b0, ~a_in};  // bitwise NOT a
      3'b110:  return {8'b0, a_in << 1};  // Left Shift
      3'b111:  return {8'b0, a_in >> 1};  // Right Shift
      default: return 16'b0;
    endcase
  endfunction : alu_ref_model


  // declaration of the task to put the reference model result in the transaction handle
  virtual task ref_result();
    trans_h.result_out = alu_ref_model(trans_h.a_in, trans_h.b_in, trans_h.op_in);
  endtask : ref_result

  // declaration of the start task
  virtual task start();
    fork
      forever begin
        mon2rm.get(trans_h);
        trans_h.display("Ref Monitor");
        ref_result();
        rm2sb.put(trans_h);
      end
    join
  endtask : start

endclass : alu_rm
