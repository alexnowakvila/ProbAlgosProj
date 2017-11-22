function [Q] = adaptive_randomized_range_finder(A, tol, r)
% Adaptive Randomized Range Finder Algorithm:
% Algorithm based on Lemma 4.1
[m, n] = size(A);
Omega = randn(n, r);
Y = A * Omega;
Y_norms = vecnorm(Y);
j = 0;
Q = [];
while max(Y_norms(j+1:1:j+r)) > tol/(10*sqrt(2/pi))
    j = j + 1;
    Y(:,j) = (eye(m) - Q*Q')*Y(:,j);
    Q = [Q Y(:,j)/norm(Y(:,j))];
    Omega = [Omega randn(n)];
    % add a new Y vector to check rank
    Y(:,j+r) = (eye(m) - Q*Q')*A*omega;
    % orthogonalize all the other Y vectors used to check the rank
    for i=j+1:j+r-1
        Y(:,i) = Y(:,i) - Q(:,j)(Q(:,j)'*Y(:,i));
    end
end
end