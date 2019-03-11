
## solve_SH1D_finite_full.m and solve_SH1D_finite_half.m

The Matlab routines solve_SH1D_finite_full and solve_SH1D_finite_phase find localized roll structures of the Swift-Hohenberg equation on the interval [0,L] that are centered at x=L/2 and x=0, respectively. They use a centered finite-difference approximation of the underlying equation and employ the Matlab Newton solver fsolve to find solutions from explicit expressions are rough approximations of localized rolls. The discretized right-hand side is stored in SH_rhs_finite_differences.m. To run these routines:
* start Matlab
* run solve_SH1D_finite_full or solve_SH1D_finite_phase in Matlab.

## finite_diff_test

This routine tests the finite difference scheme used to discretize the Swift-Hohenberg equation.
