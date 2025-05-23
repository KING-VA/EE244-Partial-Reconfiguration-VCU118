//-
// Copyright (c) 2020-2021 Jessica Clarke
//
// @BERI_LICENSE_HEADER_START@
//
// Licensed to BERI Open Systems C.I.C. (BERI) under one or more contributor
// license agreements.  See the NOTICE file distributed with this work for
// additional information regarding copyright ownership.  BERI licenses this
// file to you under the BERI Hardware-Software License, Version 1.0 (the
// "License"); you may not use this file except in compliance with the
// License.  You may obtain a copy of the License at:
//
//   http://www.beri-open-systems.org/legal/license-1-0.txt
//
// Unless required by applicable law or agreed to in writing, Work distributed
// under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
//
// @BERI_LICENSE_HEADER_END@
//

module decouple_pipeline #(
  parameter integer DEPTH = 1
) (
  input clk,
  input resetn,

  input decouple_control,
  output decouple_status
);

  (* SHREG_EXTRACT = "NO" *)
  reg rg_pipe [DEPTH-1:0];

  integer i;

  always @(posedge clk) begin
    if (!resetn) begin
      for (i = 0; i < DEPTH; i = i + 1)
        rg_pipe[i] <= 1'b1;
    end
    else begin
      rg_pipe[0] <= decouple_control;

      for (i = 1; i < DEPTH; i = i + 1)
        rg_pipe[i] <= rg_pipe[i-1];
    end
  end

  assign decouple_status = rg_pipe[DEPTH-1];

endmodule
