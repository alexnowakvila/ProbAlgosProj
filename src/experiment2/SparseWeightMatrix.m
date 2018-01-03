function W = SparseWeightMatrix(Wtild, nbsparse)
% W = SparseWeightMatrix(Wtild, nbsparse)
%   Forcing to have a sparsity determined by nbsparse (only keeping the 7 highest values).
%
%   Parcimonie and Compressed Sensing (http://gpeyre.github.io/teaching/) project (Master MVA)
%   Subject: Probabilistic algorithms for constructing approximate matrix decompositions,
%   Advisor: Gabriel Peyré (http://gpeyre.github.io/teaching/) (Gabriel.Peyre at ceremade.dauphine.fr),
%   Where: git repository on bitbucket.org (https://bitbucket.org/lbesson/mva15-project-parcimonie-compressed-sensing),
%   Author: (C), 2015-16, Lilian Besson (http://perso.crans.org/besson/)
%   MIT license (http://lbesson.mit-license.org/).
%
    % x = size(image, 1);
    % y = size(image, 2);
    % fullimagesize = x * y;
    % W = zeros(fullimagesize);
    % Build the full Laplacian matrix (non-sparse !)
    % Wtild = WeightMatrix(image, sigma, cropsize);
    sizeW = size(Wtild);
    W = zeros(sizeW);
    % Starting to fill this W
    for i = 1:sizeW
        aux = Wtild(i, :);
        % Only keep the nbsparse (= 7) largest components
        for s = 1:nbsparse
            [w indice] = max(aux);
            W(i, indice) = w;
            aux = aux([1:(indice-1) (indice+1):size(aux, 2)]);
        end
        % XXX do this by sorting and avoiding this loop on s (and chaneg on aux) ?
    end
    % XXX Experimental : goes to a *true* sparse data-structure (memory efficient)
    % Wsparse = sparse(W);
end