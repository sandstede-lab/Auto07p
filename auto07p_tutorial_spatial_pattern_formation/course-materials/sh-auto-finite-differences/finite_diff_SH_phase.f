c---------------------------------------------------------------------- 
c  finite_diff_sh_phase.f
c  - solves 1d swift-hohenberg equation with finite-differences in x 
c  - parameters used:
c    - number of mesh points in x = ndim-1
c    - par(3)=l stores the length of the x domain [0,l]
c  - neumann boundary conditions (u_x=u_xxx=0) are applied at x=0 and x=l.
c  - pulse centered at x=l/2 in the middle of the domain
c  - phase condition added as equation f(ndim)
c---------------------------------------------------------------------- 

c right-hand side function
      subroutine func(ndim,u,icp,par,ijac,f,dfdu,dfdp) 

      include 'param.in' 
      implicit double precision (a-h,s-z) 
      double precision u(ndim),par(*),f(ndim),dfdu(ndim,ndim)
      double precision dfdp(ndim,*)
      double precision u1(ndim-1),u1x(ndim-1),u2x(ndim-1),u4x(ndim-1)
      double precision mu,nu,lx,hx,c,uin(nx),uinx(nx)
      integer i
      common / a / uin,uinx ! store previously computed solution for phase condition

      mu = par(1)
      nu = par(2)
      lx = par(3)
      c  = u(ndim)
      
      hx = lx/(ndim-2)

      do i = 1,ndim-1
         u1(i) = u(i)
      enddo

      call ux(nx,hx,u1,u1x)
      call uxx(nx,hx,u1,u2x)
      call uxxxx(nx,hx,u1,u4x)

      do i=1,ndim-1
         f(i) = -u4x(i) - 2*u2x(i) - (1+mu)*u(i) 
     $        + nu*u(i)*u(i) - u(i)*u(i)*u(i)
     $        + c*u1x(i)
      end do   

c phase condition using trapezoid rule, reference solution - finite_diff_sh_phase.dat
c - we don't multiply by hx as this introduces numerical instabilities
c - we don't bother adding the limits in the trapezoid rule since these terms are zero

      f(ndim) = 0.0
      do i = 1,ndim-1
         f(ndim) = f(ndim) + uinx(i)*(uin(i) - u(i))
      enddo

      return 
      end 

c----------------------------------------------------------------------

c initialisation routine
      subroutine stpnt(ndim,u,par) 
     
      include 'param.in' 
      implicit double precision (a-h,s-z) 
      double precision u(ndim),par(*),uin(nx),uinx(nx)
      double precision x(nx),lx
      integer i
      common / a / uin,uinx
      
      par(1)  = 0.2d0           !mu
      par(2)  = 1.6d0           !nu
      par(3)  = 100d0           !lx

      open(unit=18, file='finite_diff_sh_phase.dat')
      read(18,*) (x(i),u(i),i=1,nx)
      close(unit=18)

      u(ndim) = 0.0d0           !c

      hx = par(3)/(ndim-2d0)

      call initialise(nx,hx,uin,uinx)

      return 
      end 

c----------------------------------------------------------------------
c solution measures routine
      double precision function getu2(u,ndx,ntst,ncol,i)

      integer, intent(in) :: ndx,ncol,ntst,i
      double precision, intent(in) :: u(ndx,0:ncol*ntst)
      
      getu2 = u(i,0)
      
      end function getu2
c----------------------------------------------------------------------------
      
      subroutine pvls(ndim,u,par)

      integer, intent(in) :: ndim
      double precision, intent(in) :: u(ndim)
      double precision, intent(inout) :: par(*)
      
      double precision, external :: getp,getu2
      integer ndx,ncol,ntst,i
      include 'param.in' 
      double precision hx,uin(nx),uinx(nx),lx,c,mu,nu
      common / a / uin,uinx
      
      ndx=nint(getp('ndx',0,u))
      ntst=nint(getp('ntst',0,u))
      ncol=nint(getp('ncol',0,u))
      par(4) = getu2(u,ndx,ntst,ncol,ndim)	! c - should be zero
      par(5) = nint(getp('sta',0,u))		! par(5) - number of stable eigenvalues
      
      lx = par(3)
      hx = lx/(ndim-2)
       
      do i=1,ndim-1
         uin(i) = getu2(u,ndx,ntst,ncol,i)
      enddo
      call ux(nx,hx,uin,uinx)

      end subroutine pvls

c----------------------------------------------------------------------

      subroutine bcnd
      return
      end

      subroutine icnd
	  return
      end 
     
      subroutine fopt 
      return 
      end 

c----------------------------------------------------------------------

c initialisation routine
      subroutine initialise(nx,hx,uin,uinx)

      double precision x(nx), uin(nx),uinx(nx), hx
      integer nx,i

      open(unit=18, file='finite_diff_sh_phase.dat')
      read(18,*) (x(i),uin(i),i=1,nx)
      close(unit=18)

      call ux(nx,hx,uin,uinx)

      return
      end

c------------------------------------------------------------------------

c differentiation routines for ux, uxx and uxxxx
      subroutine ux(nx,hx,u,u1x)      

      implicit double precision(a-h,o-y)
      integer i,j,nx
      double precision u(nx),u1x(nx),hx

c     central second order finite differences
      do i = 2,nx-1
         u1x(i) = (u(i+1) - u(i-1))/hx
      enddo
      
      return
      end

c----------------------------------------------------------------------
      subroutine uxx(nx,hx,u,u2x)      

      implicit double precision(a-h,o-y)
      integer i,j,nx
      double precision u(nx),u2x(nx),hx2

      hx2 = hx*hx

c     neumann bcs
      u2x(1)    = 2*(u(2) - u(1))/hx2
      u2x(nx) = 2*(u(nx-1) - u(nx))/hx2

c     central second order finite differences
      do i = 2,nx-1
         u2x(i) = (u(i+1) - 2*u(i) + u(i-1))/hx2
      enddo
      
      return
      end

c--------------------------------------------------------------

      subroutine uxxxx(nx,hx,u,u4x)

      implicit double precision(a-h,o-y)
      integer i,j,nx
      double precision u(nx),u4x(nx),hx4

      hx4 = hx*hx*hx*hx

c     neumann bcs
      u4x(1)     = (2*u(3) - 8*u(2) + 6*u(1))/hx4
      u4x(2)     = (u(4) - 4*u(3) + 7*u(2) - 4*u(1))/hx4
      u4x(nx-1)= (u(nx-3) - 4*u(nx-2) + 7*u(nx-1)-4*u(nx))/hx4
      u4x(nx)  = (2*u(nx-2) - 8*u(nx-1) + 6*u(nx))/hx4
      
c     central second order finite differences
      do i = 3,nx-2
         u4x(i) = (u(i+2) - 4*u(i+1) + 6*u(i) - 4*u(i-1) + u(i-2))/hx4
      enddo
      
      return
      end
c-----------------------------------------------------------
