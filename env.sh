# Copyright (C) Li Zheng <flyskywhy@gmail.com>

PROJ_ROOT=`pwd`
export PROJ_ROOT

PATH=$PROJ_ROOT/proj:$PATH
PATH=$PROJ_ROOT/ecos/scripts:$PATH
PATH=$PROJ_ROOT/ecos/examples:$PATH
PATH=$PROJ_ROOT/tools/ecos-tools/bin:$PATH
PATH=$PROJ_ROOT/tools/microblazeel-unknown-linux-gnu/bin:$PATH
PATH=$PROJ_ROOT/tools/i386-elf/bin:$PATH
export PATH

ECOS_REPOSITORY=$PROJ_ROOT/ecos/packages
export ECOS_REPOSITORY

ECOS_BSP="ecos_v2_00_a"
export ECOS_BSP

# On all modern variants of Windows (including Cygwin and Wine)
# the OS environment variable is defined to 'Windows_NT'
if [ ! 777${OS} = 777"Windows_NT" ]; then
. /opt/Xilinx/13.1/ISE_DS/settings32.sh
fi

echo Your PROJ root is set to \'$PROJ_ROOT\'
