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
%
%   Parcimonie and Compressed Sensing (http://gpeyre.github.io/teaching/) project (Master MVA)
%   Subject: Probabilistic algorithms for constructing approximate matrix decompositions,
%   Advisor: Gabriel Peyré (http://gpeyre.github.io/teaching/) (Gabriel.Peyre at ceremade.dauphine.fr),
%   Where: git repository on bitbucket.org (https://bitbucket.org/lbesson/mva15-project-parcimonie-compressed-sensing),
%   Author: (C), 2015-16, Lilian Besson (http://perso.crans.org/besson/)
%   MIT license (http://lbesson.mit-license.org/).
%

    X = img(:);  % Flatten
    fullimagesize = size(X)

    % % pdist and squareform are from the octave statistics package
    % % Download it from http://octave.sourceforge.net/statistics/
    % % or install it with "pkg install statistics" in Octave
    % Wtild = exp(- squareform( (pdist(X) .^ 2) / sigma^2));
    % % If the matrix X is too big (> 500 × 500), it fails, switch back to the original manual code:

    % Compute manually this similarity Graph matrix
    Wtild = zeros(fullimagesize);
    for i = 1:fullimagesize
        for j = 1:fullimagesize
            Wtild(i, j) = exp(-norm(X(i, :) - X(j, :))^2 / sig^2);
        end
    end
end