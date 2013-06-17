# Copyright (C) Li Zheng <flyskywhy@gmail.com>

PROJ_ROOT=$(cd "${BASH_ARGV[0]%/*}/.."; pwd)
export PROJ_ROOT

PATH=$PROJ_ROOT/proj:$PATH
PATH=$PROJ_ROOT/ecos/scripts:$PATH
PATH=$PROJ_ROOT/ecos/examples:$PATH
PATH=$PROJ_ROOT/tools/ecos-tools/bin:$PATH
PATH=$PROJ_ROOT/tools/eclipse:$PATH
PATH=$PROJ_ROOT/tools/mipsisa32-elf/bin:$PATH
PATH=$PROJ_ROOT/tools/microblazeel-unknown-linux-gnu/bin:$PATH
PATH=$PROJ_ROOT/tools/i386-elf/bin:$PATH
PATH=$PROJ_ROOT/tools/arm-eabi/bin:$PATH
export PATH

. $PROJ_ROOT/ecos/scripts/envsetup.sh

# On all modern variants of Windows (including Cygwin and Wine)
# the OS environment variable is defined to 'Windows_NT'
if [ ! 777${OS} = 777"Windows_NT" ]; then
. /opt/Xilinx/13.1/ISE_DS/settings32.sh
fi

echo
echo "PROJ_ROOT: $PROJ_ROOT"
echo
