c---------------------------------------------------------------------- 
c  finite_diff_SH_half.f
c  - solves 1D Swift-Hohenberg equation with finite-differences in x 
c  - parameters used:
c    - number of mesh points in x = ndim
c    - par(3)=L stores the length of the x domain [0,L]
c  - Neumann boundary conditions (u_x=u_xxx=0) are applied at x=0 and x=L.
c  - pulse centered at x=0, so no phase condition needed
c---------------------------------------------------------------------- 

c Right-hand side function
      subroutine func(ndim,u,icp,par,ijac,f,dfdu,dfdp) 

      implicit double precision (a-h,s-z) 
      double precision u(ndim),par(*),f(*),dfdu(ndim,ndim),dfdp(ndim,*)
      double precision u4x(ndim),u2x(ndim)
      double precision mu,nu,Lx,hx
      integer i

      mu = par(1)
      nu = par(2)
      Lx = par(3)
      
      hx = Lx/(ndim-1)

      call uxx(ndim,hx,u,u2x)
      call uxxxx(ndim,hx,u,u4x)
c      print *,22
      do i=1,ndim
c         print *,u(i)
         f(i) = -u4x(i) - 2*u2x(i) - (1+mu)*u(i) 
     $        + nu*u(i)*u(i) - u(i)*u(i)*u(i)
      end do   

      return 
      end 

c----------------------------------------------------------------------
c Initialisation routine
      subroutine stpnt(ndim,u,par) 
     
      implicit double precision (a-h,s-z) 
      double precision u(*),par(*)
      double precision x(ndim),hx,u2x(ndim),u4x(ndim),y
      integer i
      
      par(1)  = 0.2d0           !mu
      par(2)  = 1.6d0           !nu
      par(3)  = 100d0           !Lx

      open(unit=18, file='finite_diff_SH_half.dat')
      read(18,*) (x(i),u(i),i=1,ndim)
      close(unit=18)

      return 
      end 

c----------------------------------------------------------------------
c solution measures routine
      subroutine pvls(ndim,u,par)

      implicit double precision (a-h,o-z) 
      double precision u(*),par(*)
      return
      end

c----------------------------------------------------------------------
c boundary conditions routine
      subroutine bcnd(ndim,par,icp,nbc,u0,u1,fb,ijac,dbc)
      
      implicit double precision (a-h,o-z) 
      double precision u0(*),u1(*),fb(*),par(*),dbc(nbc,*)
      integer i

      return
      end

c----------------------------------------------------------------------
c integral conditions routine
      subroutine icnd(ndim,par,icp,nint,u,uold,udot,upold,fi,ijac,dint) 

      implicit double precision (a-h,o-z) 
      double precision u(*),fi(*),par(*),dint(nint,*)
		      
!      fi(1) = 0.0d0
!      do i = 1,nn
!         fi(1) = fi(1) + upold(i)*(u(i)-uold(i))
!      end do	
      
      return 
      end 

c----------------------------------------------------------------------
     
      subroutine fopt 
      return 
      end 

c----------------------------------------------------------------------
c differentiation routines for uxx and uxxxx
      subroutine uxx(ndim,hx,u,u2x)      

      implicit double precision(a-h,o-y)
      integer i,j
      double precision u(ndim),u2x(ndim),hx2

      hx2 = hx*hx

c     Neumann bcs
      u2x(1)    = 2*(u(2) - u(1))/hx2
      u2x(ndim) = 2*(u(ndim-1) - u(ndim))/hx2

c     central second order finite differences
      do i = 2,ndim-1
         u2x(i) = (u(i+1) - 2*u(i) + u(i-1))/hx2
      enddo
      
      return
      end

c--------------------------------------------------------------

      subroutine uxxxx(ndim,hx,u,u4x)

      implicit double precision(a-h,o-y)
      integer i,j
      double precision u(ndim),u4x(ndim),hx4

      hx4 = hx*hx*hx*hx

c     Neumann bcs
      u4x(1)     = (2*u(3) - 8*u(2) + 6*u(1))/hx4
      u4x(2)     = (u(4) - 4*u(3) + 7*u(2) - 4*u(1))/hx4
      u4x(ndim-1)= (u(ndim-3) - 4*u(ndim-2) + 7*u(ndim-1)-4*u(ndim))/hx4
      u4x(ndim)  = (2*u(ndim-2) - 8*u(ndim-1) + 6*u(ndim))/hx4
      
c     central second order finite differences
      do i = 3,ndim-2
         u4x(i) = (u(i+2) - 4*u(i+1) + 6*u(i) - 4*u(i-1) + u(i-2))/hx4
      enddo
      
      return
      end
c-----------------------------------------------------------
