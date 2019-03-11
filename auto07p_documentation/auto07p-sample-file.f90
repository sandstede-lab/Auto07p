!----------------------------------------------------------------------
!   aut.f90: model auto-equations file
!----------------------------------------------------------------------

      subroutine func(ndim,u,icp,par,ijac,f,dfdu,dfdp)

      implicit none
      integer, intent(in) :: ndim, ijac, icp(*)
      double precision, intent(in) :: u(ndim), par(*)
      double precision, intent(out) :: f(ndim)
      double precision, intent(inout) :: dfdu(ndim,ndim),dfdp(ndim,*)

! evaluates the algebraic equations or ode right-hand side
! input arguments :
!      ndim   :   dimension of the algebraic or ode system 
!      u      :   state variables
!      icp    :   array indicating the free parameter(s)
!      par    :   equation parameters
! values to be returned :
!      f      :   equation or ode right hand side values
! normally unused jacobian arguments : ijac, dfdu, dfdp (see manual)

       f(1) = ....
       f(2) = ....

      end subroutine func

!----------------------------------------------------------------------

      subroutine stpnt(ndim,u,par)

      implicit none
      integer, intent(in) :: ndim
      double precision, intent(inout) :: u(ndim),par(*)
      double precision, intent(in) :: t

! input arguments :
!      ndim   :   dimension of the algebraic or ode system 
! values to be returned :
!      u      :   a starting solution vector
!      par    :   the corresponding equation-parameter values
! note : for time- or space-dependent solutions this subroutine has
!        arguments (ndim,u,par,t), where the scalar input parameter t
!        contains the varying time or space variable value.

! initialize the equation parameters
       par(1) = ....
       par(2) = ....

! initialize the solution
       u(1) = ....
       u(2) = ....

      end subroutine stpnt

!----------------------------------------------------------------------

      subroutine bcnd(ndim,par,icp,nbc,u0,u1,fb,ijac,dbc)

      implicit none
      integer, intent(in) :: ndim, icp(*), nbc, ijac
      double precision, intent(in) :: par(*), u0(ndim), u1(ndim)
      double precision, intent(out) :: fb(nbc)
      double precision, intent(inout) :: dbc(nbc,*)

! boundary conditions
! input arguments :
!      ndim   :   dimension of the ode system 
!      par    :   equation parameters
!      icp    :   array indicating the free parameter(s)
!      nbc    :   number of boundary conditions
!      u0     :   state variable values at the left boundary
!      u1     :   state variable values at the right boundary
! values to be returned :
!      fb     :   the values of the boundary condition functions 
! normally unused jacobian arguments : ijac, dbc (see manual)

!     fb(1) =
!     fb(2) =

      end subroutine bcnd

!----------------------------------------------------------------------

      subroutine icnd(ndim,par,icp,nint,u,uold,udot,upold,fi,ijac,dint)

      implicit none
      integer, intent(in) :: ndim, icp(*), nint, ijac
      double precision, intent(in) :: par(*)
      double precision, intent(in) :: u(ndim), uold(ndim), udot(ndim), upold(ndim)
      double precision, intent(out) :: fi(nint)
      double precision, intent(inout) :: dint(nint,*)

! integral conditions
! input arguments :
!      ndim   :   dimension of the ode system 
!      par    :   equation parameters
!      icp    :   array indicating the free parameter(s)
!      nint   :   number of integral conditions
!      u      :   value of the vector function u at `time' t
! the following input arguments, which are normally not needed,
! correspond to the preceding point on the solution branch
!      uold   :   the state vector at 'time' t
!      udot   :   derivative of uold with respect to arclength
!      upold  :   derivative of uold with respect to `time'
! normally unused jacobian arguments : ijac, dint
! values to be returned :
!      fi     :   the value of the vector integrand 

!     fi(1) =

      end subroutine icnd

!----------------------------------------------------------------------

      subroutine fopt(ndim,u,icp,par,ijac,fs,dfdu,dfdp)

      implicit none
      integer, intent(in) :: ndim, icp(*), ijac
      double precision, intent(in) :: u(ndim), par(*)
      double precision, intent(out) :: fs
      double precision, intent(inout) :: dfdu(ndim),dfdp(*)

! defines the objective function for algebraic optimization problems
! supplied variables :
!      ndim   :   dimension of the state equation
!      u      :   the state vector
!      icp    :   indices of the control parameters
!      par    :   the vector of control parameters
! values to be returned :
!      fs      :   the value of the objective function
! normally unused jacobian argument : ijac, dfdp

!     fs =

      end subroutine fopt

!----------------------------------------------------------------------

      subroutine pvls(ndim,u,par)

      implicit none
      integer, intent(in) :: ndim
      double precision, intent(in) :: u(ndim)
      double precision, intent(inout) :: par(*)

! parameters set in this subroutine should be considered as ``solution 
! measures'' and be used for output purposes only.
! 
! they should never be used as `true'' continuation parameters. 
!
! they may, however, be added as ``over-specified parameters'' in the 
! parameter list associated with the auto-constant nicp, in order to 
! print their values on the screen and in the ``p.xxx file.
!
! they may also appear in the list associated with auto-constant nuzr.
!
!---------------------------------------------------------------------- 
! for algebraic problems the argument u is, as usual, the state vector.
! for differential equations the argument u represents the approximate 
! solution on the entire interval [0,1]. in this case its values must 
! be accessed indirectly by calls to getp, as illustrated below.
!---------------------------------------------------------------------- 
!
! set par(2) equal to the l2-norm of u(1)
!       par(2)=getp('nrm',1,u)
!
! set par(3) equal to the minimum of u(2)
!       par(3)=getp('min',2,u)
!
! set par(4) equal to the value of u(2) at the left boundary.
!       par(4)=getp('bv0',2,u)
!
! set par(5) equal to the pseudo-arclength step size used.
!       par(5)=getp('stp',1,u)
!
!---------------------------------------------------------------------- 
! the first argument of getp may be one of the following:
!        'nrm' (l2-norm),     'max' (maximum),
!        'int' (integral),    'bv0 (left boundary value),
!        'min' (minimum),     'bv1' (right boundary value).
!
! also available are
!   'stp' (pseudo-arclength step size used).
!   'fld' (`fold function', which vanishes at folds).
!   'bif' (`bifurcation function', which vanishes at singular points).
!   'hbf' (`hopf function'; which vanishes at hopf points).
!   'spb' ( function which vanishes at secondary periodic bifurcations).
!   'eig' ( obtains eigenvalues and floquet multipliers:
!            index 1, 3, 5,... obtain the real parts of ev's
!              and 2, 4, 6,... the imaginary parts
!            eigenvalues are ordered by real part.
!            floquet multipliers are ordered by distance from |z|=1)
!   'nbc' ( gets the active nbc).
!   'nint' ( gets the active nint).
!   'ntst' ( gets the active ntst).
!   'ncol' ( gets the active ncol).
!   'ndim' ( get the dimension of the extended system).
!   'mxt' ( gets t value for maximum of component).
!   'mnt' ( gets t value for minumum of component).
!   'win' ( gets weight for integral; 0<=i<=ncol).
!   'dtm' ( gets value for delta t array 1<=i<=ntst).
!---------------------------------------------------------------------- 

      end subroutine pvls

!----------------------------------------------------------------------
