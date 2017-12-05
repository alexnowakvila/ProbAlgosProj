function [Q, Y] = randomized_power_iteration(A, l, q)
%
% Randomized Power Iteration (Algorithm 4.3)
%   [Q] = randomized_power_iteration(A, l, q) with [m,n] = size(A) returns
%   a [m,l] orthonormal matrix Q whose range approximates the range of A.
%   Given an m*n matrix A, the algorithm computes an m*l orthonormal
%   matrix Q whose range approximates the range of A
%
[m, n] = size(A);
Omega = randn(n, l);
Y = A * Omega;
for i = 1:q
    Y = (A*A')*Y;
end
[Q, ~] = qr(Y, 0);
end
