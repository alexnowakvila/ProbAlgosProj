clear all;
addpath('stageA/');
addpath('stageB/');

disp('« Project: Probabilistic Algorithms for Constructing Approximate');
disp('  Matrix Decompositions »');
fprintf('\r\n');
disp(' Select experiment applied to a Gaussian Random Matrix A0:')
disp(' All experiments use m=500, n=200, p=5.')
fprintf('\r\n');
disp('1 - Randomized Range Finder to A0 and (A0*A0^T)*A0.')
disp('2 - Compare Randomized Range Finder error with theoretical bounds on')
disp('    the expectation of the error applied to (A0*A0^T)^r*A0.')
disp('3 - Compare Randomized Power Iteration error with theoretical bounds on')
disp('    the expectation of the error applied to A0.')
disp('4 - Comparing error of Adaptive Randomized Range Finder with pre-specified')
disp('    tolerance applied to (A0*A0^T)^2*A0.')
disp('5 - Testing Randomized Subspace Iteration for different values of q')
disp('    applied to A0.')
disp('6 - Compare error of Randomized Range Finder with Gaussian and SRFT')
disp('    matrices applied to A0.')
disp('7 - Direct SVD using Randomized Subspace Iteration with q=2 applied.')
disp('    to A0.')
fprintf('\r\n');
experiment = input('Introduce the number of the experiment to run (1-6):\n');

switch experiment
case 1
% -------------------------------------------------------------------------
disp('Running experiment 1...');
% default parameters
m = 500; n = 200; p = 5;
% m = input('Number of rows m:\n');
% n = input('Number of cols n:\n');
% p = input('Oversampling parameter p:\n');
A0 = randn(m, n)/(sqrt(m)+sqrt(n)); [U,S0,V] = svd(A0);
figure(1);
subplot(2,3,1); plot(diag(S0)); title('Spec of A_0=A');
subplot(2,3,2); hold on;
error = []; specs = [];
for k = 1:10:n
  Q0 = randomized_range_finder(A0, k ,p);
  A0_app = (Q0*Q0')*A0;
  [U,S,V] = svd(A0_app);
  specs = [specs; diag(S)'];
  error = [error  norm(A0 - A0_app)];
  plot(diag(S));
end
title('Spec of A_{0,app} = Q_k*Q_k^T*A_0 '); hold off;
subplot(2,3,3); plot(1:10:n, error); title('norm(A_0-Q_k*Q_k^T*A_0)');

A0 = (A0*A0')*A0; [U,S0,V] = svd(A0);
subplot(2,3,4); plot(diag(S0)); title('Spec of A_1 = A*A^T*A');
subplot(2,3,5); hold on;
error = []; specs = [];
for k = 1:10:n
  Q0 = randomized_range_finder(A0, k ,p);
  A0_app = (Q0*Q0')*A0;
  [U,S,V] = svd(A0_app);
  specs = [specs; diag(S)'];
  error = [error  norm(A0 - A0_app)];
  plot(diag(S));
end
title('Spec of A_{1,app} = Q_k*Q_k^T*A_1'); hold off;
subplot(2,3,6); plot(1:10:n, error); title('norm(A_1-Q_k*Q_k^T*A_1)');
% ------------------------------------------------------------------------
case 2
disp('Running experiment 2...')
m = 500; n = 200; p = 5;
% m = input('Number of rows m:\n');
% n = input('Number of cols n:\n');
% p = input('Oversampling parameter p:\n');
A0 = randn(m, n)/(sqrt(m)+sqrt(n)); 
A01 = A0;
q=1;
for q = 1:3
  if q > 1
    for i = 2:q
      A0 = (A01*A01')*A0; 
    end
  end
[U,S0,V] = svd(A0);
S0 = diag(S0);
figure(5);
error = []; specs = []; theory = []; app = [];
for k = 1:n-2
  Q0 = randomized_range_finder(A0, k ,p);
  % l = k + p;
  % [Q0, ~] = randomized_subspace_iteration(A0, l, q);
  A0_app = (Q0*Q0')*A0;
  [U,S,V] = svd(A0_app);
  specs = [specs; diag(S)'];
  error = [error  norm(A0 - A0_app)];
  th = (1 + sqrt(k/(p+1)))*S0(k+1) + exp(1)*sqrt(k+p)/p * sqrt(sum(S0((k+1):end).^2));
  theory = [theory th];
  a = (1-(1:n)/n).^(2*q + 1);
  ap = (1 + sqrt(k/(p+1)))*a(k+1) + exp(1)*sqrt(k+p)/p * sqrt(sum(a((k+1):end).^2));

  app = [app ap];
end
subplot(1,3,q);
plot(1:n-2, theory, 'DisplayName', 'Theory');
hold on;
% plot(1:n-2, app, 'k'); hold on;
plot(1:n-2, error, 'DisplayName', 'Numerics'); hold on;
xlabel('k'); ylabel('error'); title(strcat('r = ', int2str(q-1)));
legend('show');
end
hold off;
% ----------------------------------------------------------------------------
case 3
disp('Running experiment 3...')
m = 500; n = 200; p = 5;
% m = input('Number of rows m:\n');
% n = input('Number of cols n:\n');
% p = input('Oversampling parameter p:\n');
A0 = randn(m, n)/(sqrt(m)+sqrt(n)); 
for q=1:3
[U,S0,V] = svd(A0);
S0 = diag(S0);
figure(6);
error = []; specs = []; theory = []; app = [];
for k = 1:n-2
  % Q0 = randomized_range_finder(A0, k ,p);
  l = k + p;
  [Q0, ~] = randomized_subspace_iteration(A0, l, q);
  A0_app = (Q0*Q0')*A0;
  [U,S,V] = svd(A0_app);
  specs = [specs; diag(S)'];
  error = [error  norm(A0 - A0_app)];
  th = (1 + sqrt(k/(p+1)))*S0(k+1)^(2*q+1) + exp(1)*sqrt(k+p)/p * sqrt(sum(S0((k+1):end).^(2*(2*q+1))));
  th = th^(1/(2*q+1));
  theory = [theory th];
  % a = (1-(1:n)/n).^(2*q + 1);
  % ap = (1 + sqrt(k/(p+1)))*a(k+1) + exp(1)*sqrt(k+p)/p * sqrt(sum(a((k+1):end).^2));
  % app = [app ap];
end
subplot(1,3,q);
plot(1:n-2, theory, 'DisplayName', 'Theory');
hold on;
% plot(1:n-2, app, 'k'); hold on;
plot(1:n-2, error, 'DisplayName', 'Numerics'); hold on;
xlabel('k'); ylabel('error'); title(strcat('q = ', int2str(q)));
legend('show');
end
hold off;

% ------------------------------------------------------------------------
case 4
disp('Running experiment 4...')
m = 500; n = 200; r = 10;
% m = input('Number of rows m:\n');
% n = input('Number of cols n:\n');
A0 = randn(m, n)/(sqrt(m)+sqrt(n));
A1 = (A0*A0')*A0;
A2 = (A0*A0')*A1;
[U,S2,V] = svd(A2); 
tols = 1:-0.1:0.1;
error = []; rank = [];
for tol = tols
  Q2 = adaptive_randomized_range_finder(A2, tol, r);
  error = [error norm(A2 - Q2*Q2'*A2)];
  rnk = size(Q2);
  rank = [rank rnk(2)];
end
figure(3); 
subplot(1,2,1); plot(tols, error);
xlabel('tol'); ylabel('error');
title('error vs tol');
subplot(1,2,2); plot(tols, rank);
xlabel('tol'); ylabel('k');
title('k(tol)');
% ------------------------------------------------------------------------
case 5
disp('Running experiment 5...')
m = 500; n = 200;
qs = 0:10;
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
% ------------------------------------------------------------------------
case 6
disp('Running experiment 6...')
m = 500; n = 200; p = 5; k = 50;
% m = input('Number of rows m:\n');
% n = input('Number of cols n:\n');
% p = input('Oversampling parameter p:\n');
A0 = randn(m, n)/(sqrt(m)+sqrt(n)); 
A1 = (A0*A0')*A0;
A0 = (A0*A0')*A1;
[U,S0,V] = svd(A0);
S0 = diag(S0); error1 = []; error2 = [];
figure(5);
for k = 1:n-p
  Q0 = randomized_range_finder(A0, k ,p);
  % l = k + p;
  % [Q0, ~] = randomized_subspace_iteration(A0, l, q);
  A0_app = (Q0*Q0')*A0;
  [U,S,V] = svd(A0_app);
  specs = diag(S)';
  error1 = [error1 norm(A0 - A0_app)];
  Q0 = fast_randomized_range_finder(A0, k ,p);
  % l = k + p;
  % [Q0, ~] = randomized_subspace_iteration(A0, l, q);
  A0_app = (Q0*Q0')*A0;
  [U,S,V] = svd(A0_app);
  specs = diag(S);
  error2 = [error2 norm(A0 - A0_app)];
  plot(1:k, error1, 'DisplayName', 'Gaussian'); hold on;
  plot(1:k, error2, 'DisplayName', 'SRFT'); hold off;
end

xlabel('k')
ylabel('error')
legend('show')
hold off;

case 7
disp('Running experiment 7...');
m = 500; n = 200; p = 5; l = 150; q = 2;
A0 = randn(m, n)/(sqrt(m)+sqrt(n));
A0 = (A0*A0')*A0;

[U0,S0,V0] = svd(A0);
[Q0, ~] = randomized_subspace_iteration(A0, l, q);
error = norm(A0-Q0*Q0'*A0)
[U1,S1,V1] = direct_svd(A0, Q0);
figure(1); hold on;
plot(diag(S1), 'DisplayName', 'approximated');
plot(diag(S0), 'DisplayName', 'exact');
xlabel('i');ylabel('i-th singular value');
title(strcat('error = ', num2str(error)));
legend('show')
hold off;
error = norm(A0 - U1*S1*V1')
otherwise
  disp('Please Select a Valid Experiment from 1 to 6.')
end