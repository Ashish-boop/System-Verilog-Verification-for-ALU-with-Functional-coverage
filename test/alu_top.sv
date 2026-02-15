import alu_pkg::*;

module alu_top ();

  // declaration of the clock
  bit clock;

  // declaration of the interface instances
  alu_if DUV_IF (clock);

  // declaration of the handle for the test class
  alu_base_test   test_h;

  // declaration of the handle for the extended test class
  alu_test_extnd1 test_extnd1;
  alu_test_extnd2 test_extnd2;
  alu_test_extnd3 test_extnd3;
  alu_test_extnd4 test_extnd4;

  // declaration of the DUV instance
  alu DUV (
      .a_in(DUV_IF.a_in),
      .b_in(DUV_IF.b_in),
      .op_in(DUV_IF.op_in),
      .result_out(DUV_IF.result_out),
      .clock(clock)
  );

  // clock generation
  initial begin
    clock = 0;
    forever #10 clock = ~clock;
  end

  // initial block for the test
  initial begin

    if ($test$plusargs("TEST1")) begin
      test_h = new(DUV_IF.DRV_MP, DUV_IF.MON_MP);
      no_of_transactions = 500;
      // running the test
      test_h.run();
      // finishing the simulation
      $finish;
    end

    if ($test$plusargs("TEST2")) begin
      test_extnd1 = new(DUV_IF.DRV_MP, DUV_IF.MON_MP);
      no_of_transactions = 500;
      test_extnd1.build();
      test_extnd1.run();
      $finish;
    end

    if ($test$plusargs("TEST3")) begin
      test_extnd2 = new(DUV_IF.DRV_MP, DUV_IF.MON_MP);
      no_of_transactions = 500;
      test_extnd2.build();
      test_extnd2.run();
      $finish;
    end

    if ($test$plusargs("TEST4")) begin
      test_extnd3 = new(DUV_IF.DRV_MP, DUV_IF.MON_MP);
      no_of_transactions = 500;
      test_extnd3.build();
      test_extnd3.run();
      $finish;
    end

    if ($test$plusargs("TEST5")) begin
      test_extnd4 = new(DUV_IF.DRV_MP, DUV_IF.MON_MP);
      no_of_transactions = 500;
      test_extnd4.build();
      test_extnd4.run();
      $finish;
    end
  end

endmodule : alu_top
