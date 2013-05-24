#!/bin/sh

# script for translation ECOS config tools

if [ ! $PROJ_ROOT ]; then 
	echo Please set root for proj
	exit
fi

ROOT=$PROJ_ROOT/proj
echo $ROOT
LOG=$ROOT/source/log

echo Deleting directories ...
[ -d $ROOT/source ] && rm -rf $ROOT/source
[ -d $ROOT/../tools/ecos-tools ] && rm -rf $ROOT/../tools/ecos-tools

# Building for Linux/GTK+

# Configure wxWidgets for static linking without socket support, then build and install:
mkdir -p $ROOT/source/wx-build
cd $ROOT/source/wx-build
echo Configuring wxGTK ...
$ROOT/../tools/wxWidgets/configure --disable-shared --disable-sockets --prefix=$ROOT/source/wxGTK && echo done
echo Makeing wxGTK ...
make -j8 && echo done
echo Installing wxGTK ...
make install && echo done

# Build wx/gizmos, e.g. wx/gizmos/splittree.h:
echo Makeing wx/gizmos ...
cd $ROOT/source/wx-build/contrib/src/gizmos
make -j8 && echo done
echo Installing wx/gizmos ...
make install && echo done

# Configure, build and install the eCos host infrastructure:
mkdir -p $ROOT/source/infra-build
cd $ROOT/source/infra-build
echo Configuring infra-build ...
$ECOS_REPOSITORY/../host/configure --prefix=$ROOT/../tools/ecos-tools && echo done
echo Makeing infra-build ...
make -j8
echo Installing infra-build ...
make install && echo done

# Build and install the eCos Configuration Tool (INSTALLDIR must match the eCos host infrastructure prefix):
mkdir -p $ROOT/source/configtool-build
cd $ROOT/source/configtool-build
echo Makeing ConfigTools ...
make -j8 -f $ECOS_REPOSITORY/../host/tools/configtool/standalone/wxwin/makefile.gnu \
    install WXDIR=$ROOT/source/wxGTK ECOSSRCDIR=$ECOS_REPOSITORY/../host \
    INSTALLDIR=$ROOT/../tools/ecos-tools && echo done

[ -d $ROOT/source ] && rm -rf $ROOT/source 

cd $PROJ_ROOT
