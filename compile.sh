#!/bin/bash

case $OSTYPE in
    darwin*)
	libname=libismabs.dylib
	rm -f $libname
	sed -i.ori "s,local_dir = '.*',local_dir = \'`pwd`\'," ismabs.f90
	echo "initpackage ismabs lmodel.dat "`pwd`"\nquit\ny" | xspec
	;;

    # Fall through to the linux setting
    #linux-gnu)
    *)
	libname=libismabs.so
	rm -f $libname
	sed -i "s,local_dir = '.*',local_dir = \'`pwd`\'," ismabs.f90
	echo "initpackage ismabs lmodel.dat "`pwd`"\nquit\ny" | xspec
	;;

esac

if [ ! -f $libname ]
then
    echo ""
    echo "ERROR: unable to compile model (did not create $libname)"
    echo ""
    exit 1
fi

rm -f *~ *.o
rm -f *FunctionMap.* lpack_*
rm -f *.mod Makefile

echo ""
echo "************************************************************"
echo ""
echo "The ISMabs module has been built."
echo "Use"
echo ""
echo "  lmod ismabs `pwd`"
echo ""
echo "to make the model available in X-Spec."
echo ""
echo "************************************************************"
echo ""
