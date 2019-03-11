
#The Auto pp2 demo

Consider the predator-prey model
```
u' = bu(1−u)−uv−a(1−e−cu)
v' = −v+duv
```
where u, v ≥ 0 and a, b, c, d > 0. This system is used for the auto demo pp2 for which details are given in the auto manual. To run this demo, follow the instructions below.

##Auto

Type the following in a terminal to run Auto and plot the solutions and bifurcation diagrams:
```
cp c.pp2.equilibria c.pp2
@r pp2
@sv equilibria
@sv pp2
@pp pp2
```
Note that Auto found one saddle-node bifurcation (LP) and one Hopf bifurcation point (HB).

To compute and continue the periodic orbits that bifurcate at the Hopf point, use the following commands:
```
cp c.pp2.hopf c.pp2
@r pp2 equilibria
@sv hopf
@ap pp2
@pp pp2
```
To continue curves of saddle-node and Hopf bifurcations in par(1) and par(2), use the following commands (after following the steps above):
```
@r pp2 equilibria pp2.cont_fold
@sv cont
@r pp2 equilibria pp2.cont_hopf
@ap cont
@pp cont
```

##Matlab

To plot solutions or bifurcation diagrams in Matlab, type the following in the terminal:
```	autox to_matlab.xauto hopf periodic ```
	
Then open Matlab and type:
```
soln=load('periodic_solution_11');
plot(soln(:,2),soln(:,3));
```