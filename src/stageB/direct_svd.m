function [U,S,V] = direct_svd(A, Q)
% Direct SVD (Algorithm 5.1)
%
%   [U,S,V] =  direct_svd(A, Q) computes an approximate singular 
%   value decomposition under the hypothesis that norm(A-Q*Q'*A) is small
%   by computing the SVD of B = Q'*A.
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
B = Q'*A;
[U,S,V] = svd(B);
U = Q*U;
end