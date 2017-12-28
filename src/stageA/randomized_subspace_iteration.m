function [Q, Y] = randomized_subspace_iteration(A, l, q)
%
% Randomized Subspace Iteration (Algorithm 4.4)
%   [Q] = randomized_subspace_iteration(A, l, q) returns
%   a (m x l) orthonormal matrix Q whose range approximates the range of A.
%   Given an (m x n) matrix A, the algorithm computes an (m x l) orthonormal
%   matrix Q whose range approximates the range of A.
%
%   Input
%   A:
%     (m x n) matrix.
%   l:
%     Dimension of the subspace approximating the range of A.
%   q:
%     Number of power iterations applied to the matrix A.
%
%   Output
%   Q:
%     (m x l) matrix whose columns form an orthogonal basis that
%     approximates the range of A.
%   Y:
%     (m x l) matrix whose columns forms a basis that
%     approximates the range of A.

[m, n] = size(A);
Omega = randn(n, l);
Y = A * Omega;
[Q ~] = qr(Y, 0);
for i=1:q
    Y = A'*Q;
    [Q ~] = qr(Y, 0);
    Y = A*Q;
    [Q ~] = qr(Y, 0);
end
end
