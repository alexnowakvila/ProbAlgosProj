figure(1)
subplot(1,2,1);
hold on;
plot(1:2:kmax, error_m1, '-o', 'DisplayName', strcat('q=0')); hold on;
plot(1:2:kmax, error_m2, '-o', 'DisplayName', strcat('q=1')); hold on;
plot(1:2:kmax, error_m3, '-o', 'DisplayName', strcat('q=2')); hold on;
xlabel('k');
ylabel('error');
title('MNIST');
legend('show')
hold off;
subplot(1,2,2);
hold on;
plot(1:10:kmax, error1, '-o', 'DisplayName', strcat('q=0'));
plot(1:10:kmax, error2, '-o', 'DisplayName', strcat('q=1'));
plot(1:10:kmax, error3, '-o', 'DisplayName', strcat('q=2'));
plot(1:10:kmax, error4, '-o', 'DisplayName', strcat('q=3'));
xlabel('k');
ylabel('error');
title('A');
legend('show')
hold off;