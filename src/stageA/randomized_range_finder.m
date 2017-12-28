function [Q] = randomized_range_finder(A, k, p)
%
% Randomized Range Finder Algorithm (Algorithm 4.1).
%   [Q] = randomized_range_finder(A, k, p) with [m, n] = size(A)
%   returns a (m x (k+p)) matrix Q whose columns are orthonormal and 
%   whose range approximates the range of A
%
%   Input
%   A:
%     (m x n) matrix.
%   k:
%     target rank.
%   p:
%     oversampling parameter.
%
%   Output
%   Q:
%     (m x (k+p)) whose columns form an orthogonal basis of a rank-k
%     approximation of the image of A.

[m, n] = size(A);
Omega = randn(n, k+p);
Y = A * Omega;
[Q, R] = qr(Y, 0);
end
