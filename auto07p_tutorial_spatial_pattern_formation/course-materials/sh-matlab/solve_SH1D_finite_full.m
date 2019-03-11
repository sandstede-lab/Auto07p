% - Solves 1D quadratic-cubic Swift-Hohenberg equation
% - Finds localised pulse in snaking region and computes its stability
% - Uses finite differences and sparse matrices
% - Requires optimization toolbox and external routine SH_rhs_finite_differences.m
%
% Copyright 2007, David JB Lloyd, Daniele Avitabile, Bjorn Sandstede, Alan R Champneys
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

%% setup

global LN;  % Swift-Hohenberg linear operator

P = 0.2;
s = 1.6;

N = 300;    % number of mesh points, must be even! 
L = 100;    % domain truncation
h = L/(N-1); x = (0:N-1)'*h;

%% compute one-dimensional linear Swift-Hohenberg operator differentiation matrix

e = ones(N,1);

% d_x
D = sparse(1:N-1,[2:N-1 N],ones(N-1,1)/2,N,N); 
D = (D - D')/h;
D(1,2) = 0; D(N,N-1) = 0; % Neumann boundary conditions

% d_xx
D2 = sparse(1:N-1,[2:N-1 N],ones(N-1,1),N,N) - sparse(1:N,[1:N],e,N,N);
D2 = (D2 + D2');
D2(1,2) = 2; D2(N,N-1) = 2; % Neumann boundary conditions
D2 = D2/h^2;
e = sparse(1:N,[1:N],e,N,N); % identity matrix

LN = -D2^2 - 2*D2 - e;

%% initial conditions

L1 = 8;
y  = x-L/2;
u  = (-tanh(y-L1) + tanh(y+L1)).*cos(y);

%% solve nonlinear problem using fsolve

% option to display output and use Jacobian
options=optimset('Display','iter','Jacobian','on','MaxIter',50);

% call solve
[uout,fval] = fsolve(@(u) SH_rhs_finite_differences(u,P,s,N,LN),u,options);

%% plot results

figure;
plot(x,uout); % plot solution
title('Pulse on the full line');

%% compute most unstable eigenvalue

J = LN + sparse(1:N,[1:N],-P + 2*s*uout - 3*uout.^2,N,N);
[V1,DD1] = eigs(J,5,1); 
max_eigenvalue = max(diag(DD1))

v1 = V1(:,1);
figure;
plot(x,v1);title('Leading eigenfunction');


%% save computed solution

% auto finite-difference code
uauto = [x uout];
save 'finite_diff_SH_phase.dat' uauto '-double' '-ascii';

% auto boundary-value-problem code
uauto = [x uout D*uout D2*uout D*D2*uout];
save 'auto_SH_phase.dat' uauto '-double' '-ascii';

