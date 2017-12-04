function [Q] = randomized_range_finder(A, k, p)
%
% Randomized Range Finder Algorithm (Algorithm 4.1).
%     [Q] = randomized_range_finder(A, k, p) with [m, n] = size(A)
%     returns a [m, k+p] matrix Q whose columns are orthonormal and 
%     whose range approximates the range of A
%
[m, n] = size(A);
Omega = randn(n, k+p);
Y = A * Omega;
[Q, R] = qr(Y, 0);
end
