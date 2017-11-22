function [Q] = randomized_power_iteration(A, l, q)
% Randomized Power Iteration:
% Given an m*n matrix A, the algorithm computes an m*l orthonormal
% matrix Q whose range approximates the range of A
[m, n] = size(A);
Omega = randn(n, l);
Y = A * Omega;
for i=1:q
    Y = (A*A')*Y;
end
Q = CGS(Y);
end
