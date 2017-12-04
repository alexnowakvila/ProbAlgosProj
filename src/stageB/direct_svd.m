function [U,S,V] = direct_svd(A, Q)
%
% Direct SVD (Algorithm 5.1)
%   [U,S,V] = direct_svd(A, Q) computes an approximate singular value
%   decomposition under the hypothesis that norm(A-Q*Q'*A) is small.
%
B = Q'*A;
[U,S,V] = svd(B);
U = Q*U;
end