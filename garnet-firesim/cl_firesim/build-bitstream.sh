#!/bin/bash

# This script is called by FireSim's bitbuilder to create a bit file

# exit script if any command fails
set -e
set -o pipefail

usage() {
    echo "usage: ${0} [OPTIONS]"
    echo ""
    echo "Options"
    echo "   --cl_dir    : Custom logic directory to build Vivado bitstream from"
    echo "   --frequency : Frequency in MHz of the desired FPGA host clock."
    echo "   --strategy  : A string to a precanned set of build directives.
                          See aws-fpga documentation for more info/.
                          For this platform TIMING and AREA supported."
    echo "   --board     : FPGA board {au250,au280}."
    echo "   --help      : Display this message"
    exit "$1"
}

CL_DIR="/scratch/junhak/vector_acc/platforms/xilinx_vcu118/garnet-firesim/cl_xilinx_vcu118-firesim-FireSim-FireSimRocketVectorAddConfig-BaseXilinxVCU118Config"
FREQUENCY="90"
STRATEGY="TIMING"
BOARD="xilinx_vcu118"
BUILD=""
ABSTRACT="default"

# getopts does not support long options, and is inflexible
while [ "$1" != "" ];
do
    case $1 in
        --help)
            usage 1 ;;
        --cl_dir )
            shift
            CL_DIR=$1 ;;
        --strategy )
            shift
            STRATEGY=$1 ;;
        --frequency )
            shift
            FREQUENCY=$1 ;;
        --board )
            shift
            BOARD=$1 ;;
        --build )
            shift
            BUILD=$1 ;;
        --abstract )
            shift
            ABSTRACT=$1 ;;
        * )
            echo "invalid option $1"
            usage 1 ;;
    esac
    shift
done

if [ -z "$CL_DIR" ] ; then
    echo "no cl directory specified"
    usage 1
fi

if [ -z "$FREQUENCY" ] ; then
    echo "No --frequency specified"
    usage 1
fi

if [ -z "$STRATEGY" ] ; then
    echo "No --strategy specified"
    usage 1
fi

if [ -z "$BOARD" ] ; then
    echo "No --board specified"
    usage 1
fi

cd $CL_DIR/../
make ip

# run build
cd $CL_DIR/build

# if [ "$ABSTRACT" = "default" ]; then
#     if [ "$BUILD" = "default" ]; then
#         vivado -mode batch -source ./build-pr-abs.tcl -tclargs $FREQUENCY $STRATEGY $BOARD
#     else; then
#         vivado -mode batch -source ./build-abs.tcl -tclargs $FREQUENCY $STRATEGY $BOARD
#     fi
# else; then
#     if [ "$BUILD" = "default" ]; then
#         vivado -mode batch -source ./build-pr.tcl -tclargs $FREQUENCY $STRATEGY $BOARD
#     else; then
#         vivado -mode batch -source ./build.tcl -tclargs $FREQUENCY $STRATEGY $BOARD
#     fi
# fi

vivado -mode batch -source ../tcl/build-abs.tcl -tclargs $FREQUENCY $STRATEGY $BOARD

# vivado -source ../tcl/build.tcl -tclargs $FREQUENCY $STRATEGY $BOARD

# TODO: remove later. this is for temporary compatibility with u250 flow
# in manager
mkdir -p ../vivado_proj
# cp example_pblock_partition_partial.bit ../vivado_proj/firesim.bit
# cp ../../shell/prebuilt/empty_primary.mcs ../vivado_proj/firesim.mcs
# cp ../../shell/prebuilt/empty_secondary.mcs ../vivado_proj/firesim_secondary.mcs