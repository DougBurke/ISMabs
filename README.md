
# Note: this is not the official version of the ISMabs model

This is an 
[X-Spec user model](http://heasarc.nasa.gov/docs/xanadu/xspec/newmodels.html).
Is is a fork of the official code, which can be obtained from
<http://hea-www.cfa.harvard.edu/~javier/ismabs/>. This version has some
small improvements:

 - prints a warning message if there are problems reading in the
   cross-section data (`atomic_data/AtomicData.fits`)

 - add the `ISMABSROOT` 
   [xset variable](http://heasarc.nasa.gov/xanadu/xspec/manual/XSxset.html)
   that allows users to override the compiled-in path to the
   cross-section data file

 - the compilation script has seen some minor improvements

The main reason for this fork is to act as an example of using a
distributed version control system for such code, so that 

 - we do not have to rely on University web pages to access the code

 - there is easy access to previous versions

 - it can make it easier for other users to contribute changes or
   take over development and maintenance 

For this example I picked git and GitHub, but could have used one of
the other systems.

------------------------------------------------------------------------

# ISMabs

ISMabs is an X-ray photoabsorption model for the interstellar medium
that takes into account both neutral and ionized species from H, He,
N, O, Ne, Mg, Si, S, Ar, Ca, Fe, Ni and Zn.  Particularly we include
in our model the following cross sections, as described in
[Gatuzz et al. (2014b)](http://adslabs.org/adsabs/abs/2014ApJ...790..131G/):

- Neutral states of Si, S, Ar and Ca from Verner et al. (1995)
- Singly and doubly ionized states of Si, S, Ar and Ca
  from Witthoeft et al. (2009) and Witthoeft et al. (2011)
- Neutral, singly and doubly ionized states of N from
  Garcia et al. (2009)
- Neutral states of O from Gorczyca et al. (2013)
- Singly and doubly ionized states of O from Garcia et al. (2005),
  including corrections applied by Gatuzz et al. (2013)
- Neutral state of Ne from Gorczyca et al. (2000)
- Singly and doubly ionized states of Ne from Gorczyca et al. (2005)
- For the Fe-L edge region we use the measurement of metallic 
  iron by Kortright & Kim (2000)
- Neutral, singly and doubly ionized states of Mg from
  Hasoglu et al. (2014).

Compared with previous photoabsorption models, which solely rely on
neutral species, the inclusion of ions leads to improvements of the
spectral fits. Fit parameters comprise the column densities of
abundant contributors that allow direct estimates of ionization
states.

# Obtaining ISMabs

As of this writing, the ISMabs package is not included as 
part of the standard xspec software, either within heasoft 
or as part of standalone xspec.  Instead, it must be downloaded 
and installed separately from
<http://hea-www.cfa.harvard.edu/~javier/ismabs/>
(official version) or via git for this version:

    git clone https://github.com/DougBurke/ISMabs.git
    cd ISMabs

The contents of the tarfile include:

 * `atomic_data/AtomicData.fits`

    Atomic database binary fits file.  This should reside in the
    directory atomic_data inside the folder where the model is
    located, although it can be moved by setting the `ISMABSROOT`
    xset variable, as described below in the Atomic Data
    section below.

 * `ismabs.f90`

    Source code for ISMabs.

 * `lmodel.dat`

    Local model definition file needed by xspec.  

 * `compile.sh`

    Installation script written on bash.

 * `README.md`

    This file.

# Installation

You can use the compile.sh file to install the model by doing

    sh compile.sh

The script does two things

 - change the code so that it looks for the cross section
   data in the current working directory

 - compiles the model using X-Spec

In the  model folder or you can setting up and using this 
model is as described in the xspec manual:

0) You need to have the heasoft package installed on your 
   machine, but it must be built from source.  Local models 
   cannot be installed from a binary installation.

1) untar this directory somewhere in your user area

2) setup your headas environment; e.g.

        setenv HEADAS /path/to/architecture
        source $HEADAS/headas-init.csh

3) start up xspec, and in response to the prompt type 

        initpackage xstarmod lmodel.dat <path-to-current-directory>

where `<path-to-current-directory>` is the full path of the current
directory .

After the build is complete type 

    lmod ismabs <path-to-current-directory>

In subsequent  sessions you don't neet to do the initpackage 
step again, just the lmod.

# Atomic data

With the default set up - that is, if you have run `compile.sh`,
the model will look for the cross-section data file in 
`atomic_data/AtomicData.fits`, relative to the directory in which
the module is located.

The X-Spec XSET command can be used to set the ISMABSROOT variable;
if this is set then it is used instead of the path to the module. So
after

    xset ISMABSROOT /data/ismabs/

then the model will use the file /data/ismabs/atomic_data/AtomicData.fits
(so the ISMABSROOT refers to the directory containing the atomic_data/
directory). Note that ISMABSROOT over-rides any changes made by
running `compile.sh` when building the model.

The location of the file can be found by setting the X-Spec chatter
level to 20 or higher - e.g.

    chatter 20

*before* evaluating the model.

# Parameters

Inside of xspec, the model can be invoked by typing 

    mo ismabs*pow

or variations on that.

The input parameters included the elemental column 
densities and redshift.

NOTE that the HeI column density is not a free parameter 
due to the constraining imposed to the model:

    HeI = 0.1 * H

See
[Gatuzz et al. (2014b)](http://adslabs.org/adsabs/abs/2014ApJ...790..131G/)
for details.

# Contact (original code)

This package is still being tested. Please contact me with 
any reports or questions.

egatuzz@ivic.gob.ve

# Contact (fork)

Please use the [Issues Page](https://github.com/DougBurke/ISMabs/issues)
if you have any problems with this code.
