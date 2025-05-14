#-
# Copyright (c) 2020-2021 Jessica Clarke
#
# @BERI_LICENSE_HEADER_START@
#
# Licensed to BERI Open Systems C.I.C. (BERI) under one or more contributor
# license agreements.  See the NOTICE file distributed with this work for
# additional information regarding copyright ownership.  BERI licenses this
# file to you under the BERI Hardware-Software License, Version 1.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at:
#
#   http://www.beri-open-systems.org/legal/license-1-0.txt
#
# Unless required by applicable law or agreed to in writing, Work distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations under the License.
#
# @BERI_LICENSE_HEADER_END@
#

# set ifrequency  [lindex $argv 0]
# set istrategy   [lindex $argv 1]
# set iboard      [lindex $argv 2]

# set desired_host_frequency $ifrequency
# # TODO: this needs to be piped through elsewhere?
# set strategy $istrategy

# set project_dir ".."
# set CL_DIR "$project_dir"
# set CL_BUILD_DIR "$project_dir/build"
# set garnet_dir "$project_dir/.."

set project_name "acc_pm"
set top_module vector_add_partition_wrapper

set_param sta.enableAutoGenClkNamePersistence 0



create_project -force empty -part xcvu9p-flga2104-2L-e
set_property board_part xilinx.com:vcu118:part0:2.4 [current_project]

add_files [list \
    "$CL_DIR/design/FireSim-generated.defines.vh" \
    "$CL_DIR/design/FireSim-generated.sv" \
    "$CL_DIR/design/VectorAddWrapper.sv" \
]

puts $timing_log "Running acc synth..."
set start [clock seconds]
synth_design -top $top_module -mode out_of_context
set end [clock seconds]
puts $timing_log "acc synth source took [expr {$end - $start}] seconds"
flush $timing_log


puts $timing_log "Running acc write_checkpoint..."
set start [clock seconds]
write_checkpoint -force ${CL_BUILD_DIR}/${top_module}_ooc.dcp
set end [clock seconds]
puts $timing_log "acc write_checkpoint source took [expr {$end - $start}] seconds"
flush $timing_log

close_project