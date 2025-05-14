(* black_box *) module vector_add_partition_wrapper (
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

endmodule
