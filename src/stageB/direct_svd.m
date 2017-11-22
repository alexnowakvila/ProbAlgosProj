function [U,S,V] = direct_svd(A, Q)
% Direct SVD
% Need norm(A - Q*Q'*A) small
B = Q'*A;
[U,S,V] = svd(B);
U = Q*U;
end