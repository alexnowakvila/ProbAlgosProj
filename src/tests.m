clear all;
addpath('stageA/');

disp('');
disp('« Project: Probabilistic Algorithms for Constructing Approximate');
disp('  Matrix Decompositions »');

% -------------------------------------------------------------------------
% disp('Testing randomized_range_finder.m with gaussian matrices...');
% % default parameters
% m = 500; n = 200; p = 5;
% % m = input('Number of rows m:\n');
% % n = input('Number of cols n:\n');
% % p = input('Oversampling parameter p:\n');
% A0 = randn(m, n)/(sqrt(m)+sqrt(n)); [U,S0,V] = svd(A0);
% figure(1);
% subplot(2,3,1); plot(diag(S0)); title('Spec of A_0=A');
% subplot(2,3,2); hold on;
% error = []; specs = [];
% for k = 1:n
%   Q0 = randomized_range_finder(A0, k ,p);
%   A0_app = (Q0*Q0')*A0;
%   [U,S,V] = svd(A0_app);
%   specs = [specs; diag(S)'];
%   error = [error  norm(A0 - A0_app)];
%   plot(diag(S));
% end
% title('Spec of A_{0,app} = Q_k*Q_k^T*A_0 '); hold off;
% subplot(2,3,3); plot(error); title('norm(A_0-Q_k*Q_k^T*A_0)');

% A0 = (A0*A0')*A0; [U,S0,V] = svd(A0);
% subplot(2,3,4); plot(diag(S0)); title('Spec of A_1 = A*A^T*A');
% subplot(2,3,5); hold on;
% error = []; specs = [];
% for k = 1:n
%   Q0 = randomized_range_finder(A0, k ,p);
%   A0_app = (Q0*Q0')*A0;
%   [U,S,V] = svd(A0_app);
%   specs = [specs; diag(S)'];
%   error = [error  norm(A0 - A0_app)];
%   plot(diag(S));
% end
% title('Spec of A_{1,app} = Q_k*Q_k^T*A_1'); hold off;
% subplot(2,3,6); plot(error); title('norm(A_1-Q_k*Q_k^T*A_1)');
% ------------------------------------------------------------------------
% disp('Testing adaptive_randomized_range_finder.m with gaussian matrices...');
% m = 500; n = 200; r = 10;
% % m = input('Number of rows m:\n');
% % n = input('Number of cols n:\n');
% A0 = randn(m, n)/(sqrt(m)+sqrt(n));
% A1 = (A0*A0')*A0;
% A2 = (A0*A0')*A1;
% [U,S2,V] = svd(A2);
% tols = 1:-0.1:0.1;
% error = []; rank = [];
% for tol = tols
%   Q2 = adaptive_randomized_range_finder(A2, tol, r);
%   error = [error norm(A2 - Q2*Q2'*A2)];
%   rnk = size(Q2)
%   rank = [rank rnk(2)];
% end
% figure(3); 
% subplot(1,2,1); plot(tols, error);
% title('error vs tol');
% subplot(1,2,2); plot(tols, rank);
% title('dim(Im(A_{app})) w.r.t tol');
% ------------------------------------------------------------------------
disp('Testing randomized_subspace_iteration.m with gaussian matrices...')
m = 500; n = 200;
qs = 0:5;
figure(4);
hold on;
for l = 100:20:200
  error = [];
  for q = qs
    A0 = randn(m, n)/(sqrt(m)+sqrt(n));
    [Q0, ~] = randomized_subspace_iteration(A0, l, q);
    error = [error norm(A0-Q0*Q0'*A0)];
  end
  plot(qs, error, 'DisplayName',int2str(l)); 
  xlabel('q'); ylabel('error=norm(A-Q*Q^T*A)');
  legend('show');
end
hold off;
