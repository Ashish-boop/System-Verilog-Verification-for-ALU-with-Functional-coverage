interface alu_if (
    input clock
);

  // declaration of the inputs

  logic [ 7:0] a_in;
  logic [ 7:0] b_in;
  logic [ 2:0] op_in;

  // declaration of the output

  logic [15:0] result_out;

  // driver clocking block
  clocking drv_cb @(posedge clock);
    default input #1 output #1;

    output a_in;
    output b_in;
    output op_in;

  endclocking : drv_cb

  // monitor clocking block 
  clocking mon_cb @(posedge clock);
    default input #1 output #1;

    input result_out;
    input a_in;
    input b_in;
    input op_in;

  endclocking : mon_cb

  // driver modport 
  modport DRV_MP(clocking drv_cb);

  // monitor modport
  modport MON_MP(clocking mon_cb);

endinterface : alu_if
