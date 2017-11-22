function [Q] = randomized_range_finder(A, k, p)
% Randomized Range Finder Algorithm
[m, n] = size(A);
Omega = randn(n, k+p);
Y = A * Omega;
Q = CGS(Y);
end
