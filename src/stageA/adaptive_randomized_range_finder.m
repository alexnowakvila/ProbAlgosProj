function [Q] = adaptive_randomized_range_finder(A, tol, r)
%
% Adaptive Randomized Range Finder Algorithm (Algorithm 4.2).
%     [Q] = adaptive_randomized_range_finder(A, tol, r) with [m, n] = size(A)
%     returns a [m, l] orthonormal matrix Q such that norm(A-Q*Q'*A)<tol
%     with probabilty 1-min(m,n)*10e-r.
%
[m, n] = size(A);
Omega = randn(n, r);
Y = A * Omega;
Y_norms = vecnorm(Y);
j = 0;
Q = [];
while max(Y_norms(j+1:1:j+r)) > tol/(10*sqrt(2/pi))
    j = j + 1;
    if j > 1
        Y(:,j) = (eye(m) - Q*Q')*Y(:,j);
    end
    Q = [Q Y(:,j)/norm(Y(:,j))];
    Omega = [Omega randn(n)];
    % add a new Y vector to check rank
    Y(:,j+r) = (eye(m) - Q*Q')*A*Omega(:,end);
    % orthogonalize all the other Y vectors used to check the rank
    for i=j+1:j+r-1
        Y(:,i) = Y(:,i) - Q(:,j)*(Q(:,j)'*Y(:,i));
    end
    Y_norms = vecnorm(Y);
end
end