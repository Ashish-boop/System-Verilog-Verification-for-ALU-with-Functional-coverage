package alu_pkg;

  // declaration of number_of_transactions 
  int no_of_transactions = 0;

  // including the files
  `include "alu_trans.sv"
  `include "alu_gen.sv"
  `include "alu_drv.sv"
  `include "alu_mon.sv"
  `include "alu_rm.sv"
  `include "alu_sb.sv"
  `include "alu_env.sv"
  `include "alu_test.sv"


endpackage : alu_pkg
