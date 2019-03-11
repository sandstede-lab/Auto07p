function [F,J] = sh_rhs(u,mu,nu,N,LN)

F = LN*u - mu*u + nu*u.^2 - u.^3;

if nargout > 1  
    J = LN + sparse(1:N,[1:N],-mu + 2*nu*u - 3*u.^2,N,N);
end

end
