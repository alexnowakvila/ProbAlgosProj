figure(1)
hold on;
kmax = 100;
plot(1:10:kmax, error1, '-o', 'DisplayName', strcat('q=0'));
plot(1:10:kmax, error2, '-o', 'DisplayName', strcat('q = ', int2str(1)));
plot(1:10:kmax, error3, '-o', 'DisplayName', strcat('q = ', int2str(2)));
plot(1:10:kmax, error4, '-o', 'DisplayName', strcat('q = ', int2str(2)));
xlabel('k');
ylabel('error');
title('A');
legend('show')
hold off;