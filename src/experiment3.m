addpath('stageA/');
addpath('stageB/');
addpath('experiment2/');
u = double(imread('Lenna.png'))/255;
img = u(200:256,190:246,3);
x = size(img, 1);
y = size(img, 2);
fullimagesize = x*y;
sigma=0.3;
ImagePatches = nlfilter(img, [5 5], @(block) {block});
X = cat(3, ImagePatches{:});
X = permute(X, [3, 1, 2]);
X = reshape(X, [fullimagesize, 5^2]);
cropsize = 5;
nbsparse = 7;
Wtild = WeightMatrix(img, sigma, cropsize);
W = SparseWeightMatrix(Wtild, nbsparse);
D = diag(sum(W,2));
A = sqrt(inv(D))*W*sqrt(inv(D));
disp('Computed W matrix');
[U,S,V] = svd(A);
disp('Computed exact SVD');
disp('Starting experiment...');
M = A;
kmax = 100; p=5;
error1 = [];
figure(1)
hold on;
for k = 1:10:kmax
    Q = randomized_range_finder(M, k ,p);
    % [Q, ~] = randomized_subspace_iteration(M, k+p, 2);
    [U,S,V] = direct_svd(M, Q);
    error1 = [error1 norm(M - (Q*Q')*M)/norm(M)];
end
plot(1:10:kmax, error1, '-o', 'DisplayName', strcat('q=0'));

q=1;
error2 = [];
for k = 1:10:kmax
  % Q = randomized_range_finder(M, k ,p);
  [Q, ~] = randomized_subspace_iteration(M, k+p, q);
  [U,S,V] = direct_svd(M, Q);
  error2 = [error2 norm(M - (Q*Q')*M)/norm(M)];
end
plot(1:10:kmax, error2, '-o', 'DisplayName', strcat('q = ', int2str(q)));

q=2;
error3 = [];
for k = 1:10:kmax
  % Q = randomized_range_finder(M, k ,p);
  [Q, ~] = randomized_subspace_iteration(M, k+p, q);
  [U,S,V] = direct_svd(M, Q);
  error3 = [error3 norm(M - (Q*Q')*M)/norm(M)];
end
plot(1:10:kmax, error3, '-o', 'DisplayName', strcat('q = ', int2str(q)));
q=3;
error4 = [];
for k = 1:10:kmax
  % Q = randomized_range_finder(M, k ,p);
  [Q, ~] = randomized_subspace_iteration(M, k+p, q);
  [U,S,V] = direct_svd(M, Q);
  error4 = [error4 norm(M - (Q*Q')*M)/norm(M)];
end
plot(1:10:kmax, error4, '-o', 'DisplayName', strcat('q = ', int2str(q)));
legend('show')
hold off;