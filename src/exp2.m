[U,S,V] = svd(A);
disp('Computed exact SVD');
M = A;
kmax = 100; p=5;
error1 = []
figure(1)
hold on;
for k = 1:10:kmax
    k
    Q = randomized_range_finder(M, k ,p);
    % [Q, ~] = randomized_subspace_iteration(M, k+p, 2);
    [U,S,V] = direct_svd(M, Q);
    error1 = [error1 norm(M - (Q*Q')*M)/norm(M)];
end
plot(1:10:kmax, error1, '-o', 'DisplayName', strcat('q=0'));

q=1;
error2 = []
for k = 1:10:kmax
  k
  % Q = randomized_range_finder(M, k ,p);
  [Q, ~] = randomized_subspace_iteration(M, k+p, q);
  [U,S,V] = direct_svd(M, Q);
  error2 = [error2 norm(M - (Q*Q')*M)/norm(M)];
end
plot(1:10:kmax, error2, '-o', 'DisplayName', strcat('q = ', int2str(q)));

q=2;
error3 = []
for k = 1:10:kmax
  k
  % Q = randomized_range_finder(M, k ,p);
  [Q, ~] = randomized_subspace_iteration(M, k+p, q);
  [U,S,V] = direct_svd(M, Q);
  error3 = [error3 norm(M - (Q*Q')*M)/norm(M)];
end
plot(1:10:kmax, error3, '-o', 'DisplayName', strcat('q = ', int2str(q)));

legend('show')
hold off;