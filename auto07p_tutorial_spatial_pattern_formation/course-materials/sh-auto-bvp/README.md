## auto_SH_phase

Run Auto:

```@r auto_SH_phase```

and note the MX error! We will fix this as outlined in the course ...

```@r auto_SH_phase```

and now it works ... We can plot the solution with

```@pp```

and then save the data in b.run1, d.run1, s.run1:

```@sv run1```

Next, change IRS=4, ISW=-1, NMX=20 in c.auto_SH_phase and restart from run1 to compute the solution branch bifurcating at the branch point:

```
@r auto_SH_phase run1
```

and  save the data in a new file:

```
@sv run2
```

Auto can plot only one file at a time; we copy all data obtained to the the files *.run_all to view them together:

```
@cp run1 run_all
@ap run2 run_all
@pp run_all
```

Note that we obtained asymmetric rolls!

## auto_SH_half

Next, we run auto_SH_half:

```
@r auto_SH_half
```

and plot the solutions:

```
@pp
```

We save the data, append them to the old *.run_all data obtained above, plot *.run_all:

```
@sv half1
@ap run_all
@pp run_all
```

Note that the solution profiles do not align: the reason is that the L2 norms are not the same. We could rectify this by adding the integral condition from auto_SH_phase.f to auto_SH_half.f90, normalizing it properly and computing the solutions again.

Note also that the solution spreads out quite a bit over the interval. To remedy this, we continue in L=par(11). Set IRS=12, replace the line for DS 	by "1.01 0.001 10.1 1" to increase DS and DSMAX, and replace the "1 1" in the third line of c.auto_SH_half by "1 11" to continue in par(11) insteadof par(1). Then restart and plot:

```
@r auto_SH_half half1
@pp
```

## spectra

start with a clean directory in c.auto_SH_phase, change ISP=1, ILP=0, NPR=2, DSMAX=0.01 
and run auto:

```
@r auto_SH_phase
@sv run
```

Next, we convert the AUTO07p files to Matlab files:

```
autox to_matlab_sh.xauto run run
```

This command generates the files run_bifur, run_label, and run_solution_* which contain, respectively, the bifurcation diagram, the labels plus par(1), and the individual solutions. In Matlab, run

```
sh_spectrum
```

which computes and plots the spectra of the localized rolls we computed.
