!----------------------------------------------------------------------
!   circle.f90 - trace out a circle by continuation
!---------------------------------------------------------------------- 

subroutine func(ndim,u,icp,par,ijac,f,dfdu,dfdp)

  implicit none
  integer, intent(in) :: ndim, ijac, icp(*)
  double precision, intent(in) :: u(ndim), par(*)
  double precision, intent(out) :: f(ndim)
  double precision, intent(inout) :: dfdu(ndim,ndim),dfdp(ndim,*)

  double precision x,y

  x    = u(1)
  y    = par(1)
  f(1) = x**2 + y**2 - 1.0

end subroutine func

!---------------------------------------------------------------------- 

subroutine stpnt(ndim,u,par,t)

  implicit none
  integer, intent(in) :: ndim
  double precision, intent(inout) :: u(ndim),par(*)
  double precision, intent(in) :: t

  par(1) = 1.0d0
  u(1)   = 0.0d0
   
end subroutine stpnt

!---------------------------------------------------------------------- 

subroutine pvls			! retrieves additional data
end subroutine pvls

subroutine bcnd			! defines boundary conditions
end subroutine bcnd

subroutine icnd			! defines integral conditions
end subroutine icnd

subroutine fopt			! defines cost functions for optimization
end subroutine fopt

!---------------------------------------------------------------------- 
