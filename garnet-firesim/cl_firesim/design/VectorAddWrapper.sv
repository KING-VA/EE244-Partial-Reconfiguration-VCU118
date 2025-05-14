module vector_add_partition_wrapper (
  input         clock,
  input         reset,
  output        io_cmd_ready,
  input         io_cmd_valid,
  input  [4:0]  io_cmd_bits_inst_rd,
  input  [63:0] io_cmd_bits_rs1,
  input  [63:0] io_cmd_bits_rs2,
  input         io_resp_ready,
  output        io_resp_valid,
  output [4:0]  io_resp_bits_rd,
  output [63:0] io_resp_bits_data,
  output        io_busy
);

  // Instantiate the VectorAdd module
  VectorAdd vector_add_inst (
    .clock(clock),
    .reset(reset),
    .io_cmd_ready(io_cmd_ready),
    .io_cmd_valid(io_cmd_valid),
    .io_cmd_bits_inst_rd(io_cmd_bits_inst_rd),
    .io_cmd_bits_rs1(io_cmd_bits_rs1),
    .io_cmd_bits_rs2(io_cmd_bits_rs2),
    .io_resp_ready(io_resp_ready),
    .io_resp_valid(io_resp_valid),
    .io_resp_bits_rd(io_resp_bits_rd),
    .io_resp_bits_data(io_resp_bits_data),
    .io_busy(io_busy)
  );

endmodule
