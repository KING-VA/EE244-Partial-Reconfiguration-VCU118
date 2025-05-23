// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2.2 (lin64) Build 4126759 Thu Feb  8 23:52:05 MST 2024
// Date        : Sun May 11 18:30:35 2025
// Host        : a11 running 64-bit Ubuntu 24.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /scratch/junhak/vector_acc/platforms/xilinx_vcu118/garnet-firesim/cl_xilinx_vcu118-firesim-FireSim-FireSimRocketVectorAddConfig-BaseXilinxVCU118Config/ip/clk_wiz_0_firesim/clk_wiz_0_firesim_stub.v
// Design      : clk_wiz_0_firesim
// Purpose     : Stub declaration of top-level module interface
// Device      : xcvu9p-flga2104-2L-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0_firesim(clk_out1, clk_out2, clk_out3, clk_out4, clk_out5, 
  clk_out6, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="reset,locked,clk_in1" */
/* synthesis syn_force_seq_prim="clk_out1" */
/* synthesis syn_force_seq_prim="clk_out2" */
/* synthesis syn_force_seq_prim="clk_out3" */
/* synthesis syn_force_seq_prim="clk_out4" */
/* synthesis syn_force_seq_prim="clk_out5" */
/* synthesis syn_force_seq_prim="clk_out6" */;
  output clk_out1 /* synthesis syn_isclock = 1 */;
  output clk_out2 /* synthesis syn_isclock = 1 */;
  output clk_out3 /* synthesis syn_isclock = 1 */;
  output clk_out4 /* synthesis syn_isclock = 1 */;
  output clk_out5 /* synthesis syn_isclock = 1 */;
  output clk_out6 /* synthesis syn_isclock = 1 */;
  input reset;
  output locked;
  input clk_in1;
endmodule
