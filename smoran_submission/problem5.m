mu1 = [0, 0].';
sigma1 = [0.7, 0; 0, 0.7];

mu2 = [1, 1].';
sigma2 = [0.8, 0.2; 0.2, 0.8];

mu3 = [-1, 1].';
sigma3 = [0.8, 0.2; 0.2, 0.8];

x1 = [-0.5; 0.5];
x2 = [0.5; 0.5];

disp("X1:");
disp((Sigma_Class(x1, mu1, sigma1)));
disp((Sigma_Class(x1, mu2, sigma2)));
disp((Sigma_Class(x1, mu3, sigma3)));

disp("X2:");
disp((Sigma_Class(x2, mu1, sigma1)));
disp((Sigma_Class(x2, mu2, sigma2)));
disp((Sigma_Class(x2, mu3, sigma3)));

function prob = Sigma_Class(x, mu, sigma)
    prob = log(1/3) - 1/2 * mu.' * inv(sigma) * mu + x.' * inv(sigma) * mu - 1/2 * x.' * inv(sigma) * x - 1/2 * log(det(sigma));
end