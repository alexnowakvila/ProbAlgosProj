function [U,S,V] =  svd_via_row_extraction(A, Q)
% SVD via Row Extraction
% need norm(A - Q*Q'*A)<tol
[m, n] = size(A);
[m, k] = size(Q);
[SK,RD,T] = id(Q',k);
X = [eye(k, k), T]'; % X has size [m, k]
% we have now Q = X*Q(SK, :)
A_J = A(SK,:);
[R, W] = qr(A_J);
Z = X*R';
[U,S,V] = svd(Z);
V = W*V;
end
