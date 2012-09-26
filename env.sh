# Copyright (C) Li Zheng <flyskywhy@gmail.com>

PROJ_ROOT=`pwd`
export PROJ_ROOT

PATH=$PROJ_ROOT/proj:$PATH
PATH=$PROJ_ROOT/tools/eclipse:$PATH
PATH=$PROJ_ROOT/tools/ecos-tools/bin:$PATH
PATH=$PROJ_ROOT/tools/mipsisa32-elf/bin:$PATH
export PATH

ECOS_REPOSITORY=$PROJ_ROOT/ecos/packages
export ECOS_REPOSITORY

echo Your PROJ root is set to \'$PROJ_ROOT\'
