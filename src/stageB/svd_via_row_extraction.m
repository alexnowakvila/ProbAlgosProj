function [U,S,V] =  svd_via_row_extraction(A, Q)

% SVD via Row Extraction (Algorithm 5.2)
%
%   [U,S,V] =  svd_via_row_extraction(A, Q) computes an approximate singular 
%   value decomposition under the hypothesis that norm(A-Q*Q'*A) is small
%   by factorizing Q via row extraction.
%
%   Input
%   A:
%     (m x n) matrix.
%   Q:
%     (m x k) matrix whose columns form an orthogonal basis that
%     approximates the range of A. I.e, norm(A-Q*Q'*A) is small.
%
%   Output
%   U:
%     Left singular vectors of the low-rank approximation.
%   S:
%     Diagonal matrix of singular values.
%   V:
%     Right singular vectors of the low-rank approximation.

[m, n] = size(A);
[m, k] = size(Q);
[SK,RD,T] = id(Q',k);
X = 0*Q; X(RD, :) = T'; X(SK, :) = eye(k);
error = norm(Q - X*Q(SK, :))
error = norm(A - Q*Q'*A)
% we have now Q = X*Q(SK, :)
A_J = A(SK,:);
[W, R] = qr(A_J', 0);
Z = X*R';
[U,S,V] = svd(Z, 0);
V = W*V;
end
