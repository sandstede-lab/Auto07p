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

% 1D quadratic/cubic Swift-Hohenberg equation
% loads Auto07p solutions and computes spectra

global LN;

%% parameters

	label = load('run_label');

	nu = 1.6;	% parameter nu
	N  = 400;	% number of mesh points
	L  = 100;	% interval length
	h  = L/(N-1);
	x  = (0:N-1)'*h;
	neig = 10;	% number of eigenvalues to compute

%% compute linear PDE operator
	e = ones(N,1);

	% d_x
	D = sparse(1:N-1,[2:N-1 N],ones(N-1,1)/2,N,N); 
	D = (D - D')/h;
	D(1,2) = 0; D(N,N-1) = 0;		% Neumann

	% d_xx
	D2 = sparse(1:N-1,[2:N-1 N],ones(N-1,1),N,N) - sparse(1:N,[1:N],e,N,N);
	D2 = (D2 + D2');
	D2(1,2)=2;D2(N,N-1)=2;			% Neumann
	D2 = D2/h^2;
	e = sparse(1:N,[1:N],e,N,N);	% identity matrix
	
	% linear operator
	LN = - D2^2 - 2*D2 - e;

%% loop over solutions

for j=1:length(label);

	%% load solution and interpolate
	data = load(['run_solution_' num2str(label(j,1))]);
	xin = L*data(:,1);
	uin = data(:,2);
	u   = interp1(xin,uin,x,'spline');
	mu  = label(j,2);
	
	%% newton
	options = optimset('Display','off','Jacobian','on','MaxIter',50);
	uout = fsolve(@(u) sh_rhs(u,mu,nu,N,LN),u,options);	% call fsolve

	%% compute PDE spectrum
	J = LN + sparse(1:N,[1:N],-mu + 2*nu*uout - 3*uout.^2,N,N);
	eval  = eigs(J,neig,1);
	
	if (j==1)	evals = eval';
	else		evals = [ evals; eval' ];
	end

end

%% plot spectra

figure(1);
for j=1:length(label);
	for k=1:neig
		plot(j,evals(j,k),'*');
		hold on;
	end
end
hold off;
