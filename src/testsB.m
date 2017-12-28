clear all;
addpath('stageA/');
addpath('stageB/');

disp('');
disp('« Project: Probabilistic Algorithms for Constructing Approximate');
disp('  Matrix Decompositions »');

% -------------------------------------------------------------------------
% change the value of q and you see how the randomized rank-l approximation
% deviates from the exact approximation
disp('testing direct_svd.m...');
m = 500; n = 200; p = 5; l = 150; q = 3;
A0 = randn(m, n)/(sqrt(m)+sqrt(n));
A0 = (A0*A0')*A0;

[U0,S0,V0] = svd(A0);
[Q0, ~] = randomized_subspace_iteration(A0, l, q);
error = norm(A0-Q0*Q0'*A0)
[U1,S1,V1] = direct_svd(A0, Q0);
figure(1); hold on;
plot(diag(S1), 'DisplayName', 'approximated');
plot(diag(S0), 'DisplayName', 'exact');
hold off;
error = norm(A0 - U1*S1*V1')
pause;

% ------------------------------------------------------------------------
disp('testing svd_via_row_extraction.m... (does not work...)');
% we can observe that the induced error through matrix extraction is 
% potentially larger than the one with direct svd. You loose accuracy to
% gain in complexity
m = 500; n = 200; p = 5; l = 150; q = 3;
A0 = randn(m, n)/(sqrt(m)+sqrt(n));
A0 = (A0*A0')*A0;

[U0,S0,V0] = svd(A0);
[Q0, Y0] = randomized_subspace_iteration(A0, l, q);
% error = norm(A0-Q0*Q0'*A0)
[U1,S1,V1] = svd_via_row_extraction(A0,Q0);
figure(1); hold on;
plot(diag(S1), 'DisplayName', 'approximated');
plot(diag(S0), 'DisplayName', 'exact');
hold off;
error = norm(A0 - U1*S1*V1')