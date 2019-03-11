
%% setup

Nx = 200;
Lx = 20;

x   = linspace(0,Lx,Nx);
hx  = x(2);
hx2 = hx.^2;
hx4 = hx.^4;

%% example functions

u     =  sech(x);
ux    = -sech(x).*tanh(x);
uxx   =  sech(x).*tanh(x).^2-sech(x).*(1-tanh(x).^2);
uxxx  = -sech(x).*tanh(x).^3+5*sech(x).*tanh(x).*(1-tanh(x).^2);
uxxxx =  sech(x).*tanh(x).^4-18*sech(x).*tanh(x).^2.*(1-tanh(x).^2)+5*sech(x).*(1-tanh(x).^2).^2;

%% uxx finite-differences

% Neumann boundary conditions
u2x(1)  = 2*(u(2) - u(1))/hx2;
u2x(Nx) = 2*(u(Nx-1) - u(Nx))/hx2;

% central second-order finite differences
for i = 2:Nx-1
    u2x(i) = (u(i+1) - 2*u(i) + u(i-1))/hx2;
end

%% uxxxx finite-differences

% Neumann boundary conditions
u4x(1)    = (2*u(3) - 8*u(2) + 6*u(1))/hx4;
u4x(2)    = (u(4) - 4*u(3) + 7*u(2) - 4*u(1))/hx4;
u4x(Nx-1) = (u(Nx-3) - 4*u(Nx-2) + 7*u(Nx-1)-4*u(Nx))/hx4;
u4x(Nx)   = (2*u(Nx-2) - 8*u(Nx-1) + 6*u(Nx))/hx4;
     
% central second-order finite differences
for i = 3:Nx-2
    u4x(i) = (u(i+2) - 4*u(i+1) + 6*u(i) - 4*u(i-1) + u(i-2))/hx4;
end

%% plot comparison

plot(x,uxx,'b',x,u2x,'r*',x,uxxxx,'b',x,u4x,'r*');
