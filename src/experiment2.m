% clear all;
addpath('stageA/');
addpath('stageB/');
addpath('utils/');

mnist_filename = '/home/alexnowak/Downloads/mnist/t10k-images.idx3-ubyte';
M = loadMNISTImages(mnist_filename)';
[U0,S0,V0] = svd(M);
p = 5;
kmax = 100;
error_m1 = [];
figure(1)
hold on;
disp('Applying Randomized Power Iteration with q = 0.');
for k = 1:2:kmax
    Q = randomized_range_finder(M, k ,p);
    % [Q, ~] = randomized_subspace_iteration(M, k+p, 2);
    [U,S,V] = direct_svd(M, Q);
    error_m1 = [error_m1 norm(M - (Q*Q')*M)/norm(M)];
end
plot(1:2:kmax, error_m1, '-o', 'DisplayName', strcat('q=0'));
disp('Applying Randomized Power Iteration with q = 1.');
q=1;
error_m2 = [];
for k = 1:2:kmax
  % Q = randomized_range_finder(M, k ,p);
  [Q, ~] = randomized_subspace_iteration(M, k+p, q);
  [U,S,V] = direct_svd(M, Q);
  error_m2 = [error_m2 norm(M - (Q*Q')*M)/norm(M)];
end
plot(1:2:kmax, error_m2, '-o', 'DisplayName', strcat('q = ', int2str(q)));
disp('Applying Randomized Power Iteration with q = 2.');
q=2;
error_m3 = [];
for k = 1:2:kmax
  % Q = randomized_range_finder(M, k ,p);
  [Q, ~] = randomized_subspace_iteration(M, k+p, q);
  [U,S,V] = direct_svd(M, Q);
  error_m3 = [error_m3 norm(M - (Q*Q')*M)/norm(M)];
end
plot(1:2:kmax, error_m3, '-o', 'DisplayName', strcat('q = ', int2str(q)));

legend('show')
hold off;