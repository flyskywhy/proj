#!/bin/sh

# script for translation ECOS config tools

if [ ! $ECOS_ROOT ]; then 
	echo Please set root for ecos
else

ROOT=$ECOS_ROOT/tools/src/
echo $ROOT
LOG=$ROOT/source/log

echo Deleting directories
[ -d $ROOT/source ] && rm -rf $ROOT/source
[ -d $ROOT/../ecos-tools ] && rm -rf $ROOT/../ecos-tools

# Downloading latest snapshots and source code
#[ -d "./source/cvs" ] || mkdir ./source/cvs
#cd $ROOT/source/cvs
#cvs -z3 -d :pserver:anoncvs@ecos.sourceware.org:/cvs/ecos co ecos ecos-host

# Building for Linux/GTK+
# Configure wxWidgets for static linking without socket support, then build and install:

# wget http://prdownloads.sourceforge.net/wxwindows/wxGTK-2.4.0.tar.bz2
mkdir $ROOT/source
cd $ROOT/source
bunzip2 -c ../pack/wxGTK-2.4.0.tar.bz2 | tar xf -
patch -p0 -d wxGTK-2.4.0 < ../pack/wxGTK-2.4.0-scrolwin.patch
mkdir $ROOT/source/wx-build
cd $ROOT/source/wx-build
echo Configuring wxGTK-2.4.0 ...
../wxGTK-2.4.0/configure --disable-shared --disable-sockets --prefix=../wxGTK-2.4.0 && echo done
echo Make wxGTK-2.4.0 ...
make && make install && echo done

#Configure, build and install the eCos host infrastructure:
mkdir $ROOT/source/infra-build
cd $ROOT/source/infra-build
echo Configuring infra-build ...
$ECOS_REPOSITORY/../host/configure --prefix=$ROOT/../ecos-tools && echo done
echo Make infra-build ...
make && make install && echo done

#Build and install the eCos Configuration Tool (INSTALLDIR must match the eCos host infrastructure prefix):
mkdir $ROOT/source/configtool-build
cd $ROOT/source/configtool-build
echo Make ConfigTools
make -f $ECOS_REPOSITORY/../host/tools/configtool/standalone/wxwin/makefile.gnu \
    install WXDIR=../wxGTK-2.4.0 ECOSSRCDIR=$ECOS_REPOSITORY/../host \
    INSTALLDIR=$ROOT/../ecos-tools && echo done

[ -d $ROOT/source ] && rm -rf $ROOT/source 

fi