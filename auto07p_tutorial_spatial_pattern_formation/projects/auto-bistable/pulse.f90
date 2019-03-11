!---------------------------------------------------------------------- 
!  pulse: computes pulse solution to bistable Nagumo equation
!---------------------------------------------------------------------- 

subroutine func(ndim,u,icp,par,ijac,f,dfdu,dfdp) ! defines vector field

  implicit none
  integer, intent(in) :: ndim, ijac, icp(*)
  double precision, intent(in) :: u(ndim), par(*)
  double precision, intent(out) :: f(ndim)
  double precision, intent(inout) :: dfdu(ndim,*), dfdp(ndim,*)

  integer j

  f(1) = u(2)
  f(2) = u(1) - par(1)*u(1)*u(1)*u(1) + par(9)*u(2)

  do j=1,ndim
     f(j) = par(11)*f(j)
  end do

end subroutine func

!---------------------------------------------------------------------- 

subroutine stpnt(ndim,u,par,t) ! sets initial parameter + solution

  implicit none
  integer, intent(in) :: ndim
  double precision, intent(inout) :: u(ndim), par(*)
  double precision, intent(in) :: t

  double precision x

  par(1)  = 1.0    ! a
  par(9)  = 0.0    ! c
  par(11) = 20.0   ! interval length

!  explicit solution is given below (but not used when commented out):
  x = par(11)*(t-0.3)
  u(1) = sqrt(2.)/cosh(x)
  u(2) = -sqrt(2.)*sinh(x)/cosh(x)/cosh(x)

end subroutine stpnt

!---------------------------------------------------------------------- 

subroutine bcnd(ndim,par,icp,nbc,u0,u1,fb,ijac,dbc)

	implicit none
	integer, intent(in) :: ndim, icp(*), nbc, ijac
	double precision, intent(in) :: par(*), u0(ndim), u1(ndim)
	double precision, intent(out) :: fb(nbc)
	double precision, intent(inout) :: dbc(nbc,*)

	fb(1) = u0(2)  ! Neumann   at t=0
	fb(2) = u1(1)  ! Dirichlet at t=1

end subroutine bcnd

!---------------------------------------------------------------------- 

subroutine icnd(ndim,par,icp,nint,u,uold,udot,upold,fi,ijac,dint)

	implicit none
	integer, intent(in) :: ndim, icp(*), nint, ijac
	double precision, intent(in) :: par(*)
	double precision, intent(in) :: u(ndim), uold(ndim), udot(ndim), upold(ndim)
	double precision, intent(out) :: fi(nint)
	double precision, intent(inout) :: dint(nint,*)

	integer j

	fi(1) = 0.0
	do j=1,2
		fi(1) = fi(1) + upold(j)*(u(j)-uold(j))   ! phase condition
	end do

end subroutine icnd

!---------------------------------------------------------------------- 

subroutine pvls
end subroutine pvls

subroutine fopt
end subroutine fopt

!---------------------------------------------------------------------- 
