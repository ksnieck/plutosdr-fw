set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR
source /opt/Xilinx/SDK/2018.2/settings64.sh
export CROSS_COMPILE=arm-linux-gnueabihf
#export PATH=$PATH:/opt/Xilinx/SDK/2018.2/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin
export VIVADO_SETTINGS=/opt/Xilinx/Vivado/2018.2/settings64.sh
make
