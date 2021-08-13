# Auto07p installation

Auto07p version 0.9.2 requires Python, a Fortran 95 compiler, and the auto07p source code.

## Installing python, gfortran, and auto07p
* Python: Auto07p 0.9.2 or later supports Python 3. I installed Python 3.6 using [Anaconda](https://www.anaconda.com), a free package manager that can be used to install and switch between different python installations on Linux, Mac, and Windows.
* gfortran: gfortran binaries for Linux, Mac, and Windows can be downloaded from (http://gcc.gnu.org/wiki/GFortran).
* Download the [Auto07p source code and manual](https://github.com/auto-07p/auto-07p/releases/) on Github and continue with the steps below for your specific operating system.

## Linux
Follow the instruction on pages 12-13 of the auto07p manual

## Mac OS X
* Install Xcode (free) from the App Store
  * Open a terminal (in /Applications/Utilities) and type ```make```. If an alert pops up about missing command line tools, follow the instructions in the alert.
* Install auto07p following the instructions on page 11 of the auto07p manual.

## Windows
Use one of the following instructions.
* Install Ubuntu under Windows and follow the instructions for Linux above.
* Proceed as follows:
  * Install MinGW, including msys, msys-base, gcc, and gfortran. The msys shell can be found in ```C:\MinGW\msys\1.0\msys.bat``` and the home directory is located in ```C:\MinGW\msys\1.0\home```.
  * Add the path ```C:\MinGW\bin``` to the user environment variables under ```MyComputer:Advanced Tab``` using the ```PATH``` variable.
  * Configure and compile auto07p.
  * Download a text editor such as [vim](http://www.vim.org).

## Legacy
* Auto07p 0.9.1 or earlier requires Python 2.7, Matplotlib 1.5.3 (higher versions of Matplotlib will _not_ work), and Numpy. It is easiest to use [Anaconda](https://www.anaconda.com), a free package manager that can be used to install and switch between different python installations on Linux, Mac, and Windows. If Anaconda is installed, use the terminal command ```conda create -n python_for_auto python=2.7 matplotlib=1.5.3 numpy``` to create a Python 2.7 environment specifically for Auto07p that can be activated with ```conda activate python_for_auto```. Download gfortran and the [Auto07p 0.9.1 source code and manual](http://sourceforge.net/projects/auto-07p/files/Auto07p/) and proceed as above depending on your operating system.
