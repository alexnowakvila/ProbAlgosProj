q=3;
error4 = []
for k = 1:10:kmax
  k
  % Q = randomized_range_finder(M, k ,p);
  [Q, ~] = randomized_subspace_iteration(M, k+p, q);
  [U,S,V] = direct_svd(M, Q);
  error4 = [error4 norm(M - (Q*Q')*M)/norm(M)];
end
% plot(1:10:kmax, error4, '-o', 'DisplayName', strcat('q = ', int2str(q)));