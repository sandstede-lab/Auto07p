
#Pulses in a bistable partial differential equation

Consider the bistable PDE
u<sub>t</sub> = u<sub>xx</sub> - u + a u<sup>3</sup> with x in R, which admits the standing pulse solution u(x,t)=\sqrt{2} sech(x) when a=1. Compute and continue these pulses numerically in auto07p starting from the exact solution. Experiment with using different truncation intervals and different values of NTST.

##Auto

Type the following in a terminal to run auto07p and plot the solutions:
```
@r pulse
@pp
```

##Matlab

The initial data for 'pulse' are in the file sech.dat. This file was created in Matlab using the commands:
```
x = [-10:0.2:10];
u = sqrt(2)*sech(x);
up = diff(u);
up(101) = 0.0;
A = [x;u;up]';
save('sech.dat','A','-ascii','-double')
```