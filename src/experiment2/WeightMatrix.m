function Wtild = WeightMatrix(image, sigma, cropsize)
% Wtild = WeightMatrix(image, sigma, cropsize)
%   Compute the weight matrix Wtild from the image, with sigma and cropsize.
%   More details on my project report.
%   Wtild is the adjacency matrix of a similarity Graph, with sigma parameter sigma (not squared).
%
%   Applies an inverse exponential (Gaussian) function to
%   the euclidean distance to generate a similarity measure.
%
%   Input
%   image:
%       (m x m) square image
%   sigma2:
%       the sigma value for the exponential function
%   cropsize:
%       the size of the patches to consider
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
    x = size(image, 1);
    y = size(image, 2);
    fullimagesize = x * y;
    X = nlfilter(image, [cropsize cropsize], @(block) {block});
    X = cat(3, X{:});
    X = permute(X, [3, 1, 2]);
    X = reshape(X, [fullimagesize, cropsize^2]);
    % % Compute manually this similarity Graph matrix
    Wtild = zeros(fullimagesize);
    for i = 1:fullimagesize
        for j = 1:fullimagesize
            Wtild(i, j) = exp(-norm(X(i, :) - X(j, :))^2 / sigma^2);
        end
    end
end