# Auto07p

[AUTO](http://cmvl.cs.concordia.ca/auto/) is a versatile continuation package for solving boundary-value problems written by [Eusebius Doedel](http://users.encs.concordia.ca/~doedel/) and his collaborators.

## Installing auto07p

Auto07p requires Python 2.7, a Fortran 95 compiler, and the auto07p source code.
* Python: auto07p requires Python 2.7 with Matplotlib 1.5.3 (higher versions of Matplotlib will _not_ work) and Numpy. It is easiest to use [Anaconda](https://www.anaconda.com), a free package manager that can be used to install and switch between different python installations on Linux, Mac, and Windows. If Anaconda is installed, use the terminal command

     ```conda create -n python_for_auto python=2.7 matplotlib=1.5.3 numpy```

     to create a Python 2.7 environment specifically for Auto07p that can be activated with

     ```conda activate python_for_auto```
* gfortran: gfortran binaries for Linux, Mac, and Windows can be downloaded from (http://gcc.gnu.org/wiki/GFortran).
* Download the [auto07p source code and manual](http://sourceforge.net/projects/auto-07p/files/Auto07p/) and continue with the steps below for your specific operating system:
    * Linux: Follow the instruction on pages 12-13 of the auto07p manual
    * Mac OS X:
        * Install Xcode (free) from the App Store
        * Open a terminal (in /Applications/Utilities) and type ```make```. If an alert pops up about missing command line tools, follow the instructions in the alert.
        * Install auto07p following the instructions on page 11 of the auto07p manual.
    * Windows: Use one of the following instructions.
        1. Download [Massimiliano Grosso's installation guide](http://people.unica.it/massimilianogrosso/auto-on-windows/) and follow the instructions there.
        1. Install Ubuntu under Windows and follow the instructions for Linux above.
        1. Proceed as follows:
            * Install MinGW, including msys, msys-base, gcc, and gfortran. The msys shell can be found in ```C:\MinGW\msys\1.0\msys.bat``` and the home directory is located in ```C:\MinGW\msys\1.0\home```.
            * Add the path ```C:\MinGW\bin``` to the user environment variables under ```MyComputer:Advanced Tab``` using the ```PATH``` variable.
            * Configure and compile auto07p.
            * Download a text editor such as [vim](http://www.vim.org).

## Auto07p tutorial for the computation of spatial patterns

This tutorial provides an introduction to computing spatial patterns using auto07p. The tutorial was developed by [David Lloyd](http://personal.maths.surrey.ac.uk/st/D.J.Lloyd/David_Lloyd/Welcome.html) and [Bjorn Sandstede](http://www.dam.brown.edu/people/sandsted) for the mini-course _Using AUTO for Stability Problems_, which ran as part of the workshop [Stability of coherent structures and patterns](http://depts.washington.edu/bdecon/workshop2012/) that was held during 11-12 June 2012 at the University of Washington in Seattle.
* Download the [courses notes in PDF format](auto07p_tutorial_spatial_pattern_formation.pdf)
* Download the [source code and documentation as a zip archive](auto07p_tutorial_spatial_pattern_formation.zip)

## HomCont

HomCont, developed by [Alan Champneys](http://www.enm.bris.ac.uk/anm/staff/arc.html) (University of Bristol), [Yuri A Kuznetsov](http://www.math.uu.nl/people/kuznet) (Utrecht University), and [Bjorn Sandstede](http://www.dam.brown.edu/people/sandsted) (Brown University), is a numerical toolbox for homoclinic bifurcation analysis designed for use with AUTO. HomCont deals with continuation of codimension-one heteroclinic and homoclinic orbits to hyperbolic and saddle-node equilibria, including the detection of many codimension-two singularities and the continuation of these singularities in three or more parameters. HomCont has been incorporated into AUTO and [XPP](http://www.math.pitt.edu/~bard/xpp/xpp.html).
