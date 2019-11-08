data = [ 2.0, 7.89; -3.6, -16.55; 2.2, 6.73; 4.9, 17.91; 1.5, 2.06; 3.1, 12.84; 2.2, 8.13; -0.9, -5.35; 0.9, 3.97; -2.4, -12.31];
disp(data);

%m = mle(data, 'distribution', 'Normal');
disp("Sum x: " + sum(data(:, 1)));

disp("Sum y: " + sum(data(:, 2)));

s = 0;
for i = 1: 10
    s = s + (data(i, 2) - (data(i, 1)*5.154 - 2.57046))^2;
end

disp(s);

scatter(data(:, 1), data(:, 2));
hold on
xs = -5:0.1:10;
ys = 5.154*xs -2.57046;
plot(xs, ys);