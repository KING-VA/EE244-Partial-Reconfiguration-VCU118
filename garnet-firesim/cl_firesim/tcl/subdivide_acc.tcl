#
# Copyright (C) 2024, Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: X11
#


set project_dir ".."
set CL_DIR "$project_dir"
set garnet_dir "$project_dir/.."

open_checkpoint "$CL_DIR/build/post_route.dcp"
puts "#HD: Subdividing firesim_rp into second-order RPs"
pr_subdivide -cell partition_wrapper -subcells {partition_wrapper/partition/firesim_top/top/sim/target/FireSim_/chiptop0/system/tile_prci_domain/element_reset_domain_rockettile/VecAddRoCC_vectorAdd} ${CL_DIR}/build/post_synth.dcp
write_checkpoint -force "$CL_DIR/build/subdivide_acc.dcp"
puts "	#HD: Completed"
close_project