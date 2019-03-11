!---------------------------------------------------------------------- 
!  pp2: basic computations for continuous dynamical systems
!---------------------------------------------------------------------- 

subroutine func(ndim,u,icp,par,ijac,f,dfdu,dfdp) ! defines vector field

  implicit none
  integer, intent(in) :: ndim, ijac, icp(*)
  double precision, intent(in) :: u(ndim), par(*)
  double precision, intent(out) :: f(ndim)
  double precision, intent(inout) :: dfdu(ndim,*), dfdp(ndim,*)

  double precision e
  e = exp(-par(3)*u(1))

  f(1) = par(2)*u(1)*(1-u(1)) - u(1)*u(2) - par(1)*(1-e)
  f(2) = -u(2) + par(4)*u(1)*u(2) 

end subroutine func

!---------------------------------------------------------------------- 

subroutine stpnt(ndim,u,par,t) ! sets initial parameter + solution

  implicit none
  integer, intent(in) :: ndim
  double precision, intent(inout) :: u(ndim), par(*)
  double precision, intent(in) :: t

  par(:4) = (/ 0.0, 3.0, 5.0, 3.0 /)	! sets parameters par(1)-par(4)
  u = 0.0								! set u=(0,0)

end subroutine stpnt

!---------------------------------------------------------------------- 

subroutine pvls(ndim,u,par) ! retrieves additional data

  implicit none
  integer, intent(in) :: ndim
  double precision, intent(in) :: u(ndim)
  double precision, intent(inout) :: par(*)
  double precision getp

  par(9) = getp('bv0',1,u)  ! sets par(9) to u1

end subroutine pvls

!---------------------------------------------------------------------- 

subroutine bcnd			! defines boundary conditions
end subroutine bcnd

subroutine icnd			! defines integral conditions
end subroutine icnd

subroutine fopt			! defines cost functions for optimization
end subroutine fopt

!---------------------------------------------------------------------- 
