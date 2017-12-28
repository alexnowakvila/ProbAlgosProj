function [O] = SRFT(n, l)
%
% Subsampled Random Fourier Transform (SRFT).
%   [O] = SRFT(n, l) computes the subsampled random fourier transform (SRFT)
%   of size (n x l)
%
%   Input
%   n:
%     number of rows of the SRFT
%   l:
%     number of columns of the SRFT
%
%   Output
%   O:
%     SRFT of size (n x l)

R = zeros(n, l);
o = 1:l;
for c = 1:l
    u = rand;
    i = ceil(size(o, 2)*u);
    r = o(i);
    R(r, c) = 1;
    o = [o(1:i-1), o(i+1:size(o, 2))];
end
% D matrix, random values on the complex circle
theta = 2*pi*rand(1, n);
D = exp(- 1*i * theta);
% n x n complex Rademacher diagonal matrix
D = diag(D);
% F matrix
F = dftmtx(n);  % from the communications package, NxN FFT
O = sqrt(n/l) * D * F * R;
end
