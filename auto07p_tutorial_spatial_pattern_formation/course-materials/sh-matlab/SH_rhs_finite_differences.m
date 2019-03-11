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

function [F,J] = SHeqn_finite(u,P,s,N,LN)
% returns the right-hand side and its Jacobian of Swift-Hohenberg equation

%% linear operator plus quadratic-cubic nonlinearity
F = LN*u - P*u + s*u.^2 - u.^3;

%% Jacobian
if nargout > 1  
    J = LN + sparse(1:N,[1:N],-P + 2*s*u - 3*u.^2,N,N);
end

end
