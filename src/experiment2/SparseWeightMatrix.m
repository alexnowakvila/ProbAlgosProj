function W = SparseWeightMatrix(Wtild, nbsparse)
% W = SparseWeightMatrix(Wtild, nbsparse)
%   Forcing to have a sparsity determined by nbsparse (only keeping the 7 highest values).
    sizeW = size(Wtild);
    W = zeros(sizeW);
    for i = 1:sizeW
        aux = Wtild(i, :);
        % Only keep the nbsparse (= 7) largest components
        for s = 1:nbsparse
            [w indice] = max(aux);
            W(i, indice) = w;
            aux = aux([1:(indice-1) (indice+1):size(aux, 2)]);
        end
    end
end