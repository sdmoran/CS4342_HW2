mu1 = [1 -1];
sigma1 = [2, 0; 0, 16];

mu2 = [-1 1];
sigma2 = [1, 0; 0, 1];

mu3 = [3 3];
sigma3 = [4, 1; 1, 2];

pd1 = mvnrnd(mu1, sigma1, 400);
pd2 = mvnrnd(mu2, sigma2, 300);
pd3 = mvnrnd(mu3, sigma3, 300);

figure(2)
hold on
plot(pd1(:,1),pd1(:,2),'r+');
plot(pd2(:,1),pd2(:,2),'go');
plot(pd3(:,1),pd3(:,2),'b+');
hold off

mu = [2 3];
sigma = [1 1.5; 1.5 3];

% Yeet Skeet get the mean of all the 
data = [pd1; pd2; pd3];
disp("DATA: " + length(data));
disp("MEAN: " + mean(data));
disp("COV: " + cov(data));

figure(3)
avg_distr = mvnrnd(mean(data), cov(data), 1000);
plot(avg_distr(:,1), avg_distr(:,2), 'kx');