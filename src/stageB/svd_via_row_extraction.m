function [U,S,V] =  svd_via_row_extraction(A, Q)
%
% SVD via Row Extraction (Algorithm 5.2)
%   [U,S,V] =  svd_via_row_extraction(A, Q) computes an approximate singular 
%   value decomposition under the hypothesis that norm(A-Q*Q'*A) is small.
%
[m, n] = size(A);
[m, k] = size(Q);
[SK,RD,T] = id(Q',k);
X = 0*Q; X(RD, :) = T'; X(SK, :) = eye(k);
% norm(Q - X*Q(SK, :))
% norm(A - Q*Q'*A)
% we have now Q = X*Q(SK, :)
A_J = A(SK,:);
[W, R] = qr(A_J', 0);
Z = X*R';
[U,S,V] = svd(Z, 0);
V = W*V;
end