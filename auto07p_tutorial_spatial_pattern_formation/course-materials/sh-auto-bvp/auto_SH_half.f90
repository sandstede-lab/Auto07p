!
! localized pulses of the quadratic-cubic Swift-Hohenberg equation
! 			0 = -(1+Delta)^2 u - mu u + nu u^2 - u^3
!

subroutine func(ndim,u,icp,par,ijac,f,dfdu,dfdp)

	implicit none
	integer, intent(in) :: ndim, ijac, icp(*)
	double precision, intent(in) :: u(ndim), par(*)
	double precision, intent(out) :: f(ndim)
	double precision, intent(inout) :: dfdu(ndim,*), dfdp(ndim,*)

	double precision mu,nu
	integer j
  
	mu = par(1)
	nu = par(2)
  
	f(1) = u(2);
	f(2) = u(3);
	f(3) = u(4);
	f(4) = -(1+mu)*u(1) + nu*u(1)*u(1) - u(1)*u(1)*u(1) - 2*u(3)

	do j=1,ndim
		f(j) = par(11)*f(j)
	end do

end subroutine func

!---------------------------------------------------------------------- 

subroutine stpnt(ndim,u,par,t)

	implicit none
	integer, intent(in) :: ndim
	double precision, intent(inout) :: u(ndim), par(*)
	double precision, intent(in) :: t

	par(1)  = 0.2		! mu
	par(2)  = 1.6		! nu
	par(11) = 100.0		! period

end subroutine stpnt

!---------------------------------------------------------------------- 

subroutine bcnd(ndim,par,icp,nbc,u0,u1,fb,ijac,dbc)

	implicit none
	integer, intent(in) :: ndim, icp(*), nbc, ijac
	double precision, intent(in) :: par(*), u0(ndim), u1(ndim)
	double precision, intent(out) :: fb(nbc)
	double precision, intent(inout) :: dbc(nbc,*)

	! Neumann boundary conditions
	fb(1) = u0(2)
	fb(2) = u0(4)
	fb(3) = u1(2)
	fb(4) = u1(4)

end subroutine bcnd

!---------------------------------------------------------------------- 

subroutine icnd
end subroutine icnd

subroutine pvls
end subroutine pvls

subroutine fopt
end subroutine fopt

!---------------------------------------------------------------------- 
