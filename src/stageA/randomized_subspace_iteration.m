function [Q] = randomized_subspace_iteration(A, l, q)
% Randomized Power Iteration:
% Given an m*n matrix A, the algorithm computes an m*l orthonormal
% matrix Q whose range approximates the range of A
[m, n] = size(A);
Omega = randn(n, l);
Y = A * Omega;
[Q, R] = qr(Y);
for i=1:q
    Y = A'*Q;
    [Q, R] = qr(Y);
    Y = A*Q;
    [Q, R] = qr(Y);
end
end
