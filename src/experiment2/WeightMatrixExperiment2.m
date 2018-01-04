function Wtild = WeightMatrixExperiment2(img, sig)
% Wtild = WeightMatrixExperiment1(image, sigma)
%   Wtild is the adjacency matrix of a similarity Graph, with sigma parameter sigma (not squared).
%
%   Applies an inverse exponential (Gaussian) function to
%   the euclidean distance to generate a similarity measure.
%
%   Input
%   image:
%       (m x m) square image
%   sigma:
%       the sigma value for the exponential function
%
%   Output
%   similarities:
%       (n x n) dimensional matrix containing the
%       similarities between each pair of patches.

    X = img(:);  % Flatten
    fullimagesize = size(X);
    Wtild = zeros(fullimagesize);
    for i = 1:fullimagesize
        for j = 1:fullimagesize
            Wtild(i, j) = exp(-norm(X(i, :) - X(j, :))^2 / sig^2);
        end
    end
end