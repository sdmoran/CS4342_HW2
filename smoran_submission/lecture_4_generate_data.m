%% Generate Training Data
% 4 input: Bernoulli, Exponential, MVN(2)

pd = makedist('Binomial','N',1,'p',0.8);
N1 = 100;
N2 = 100;
x1 = [random(pd,N1,1) exprnd(5,[N1,1])  mvnrnd([2;2],[3 0;0 6],N1)];
y1 = [ones(N1,1)];
pd = makedist('Binomial','N',1,'p',0.40);
x2 = [random(pd,N2,1) exprnd(10,[N2,1]) mvnrnd([-2;-2],[4 -3;-3 9],N2)];
y2 = [2*ones(N2,1)];
x  = [x1;x2];
y  = [y1;y2];
ind= randperm(size(x, 1));
train_x  = x(ind, :);
train_y  = y(ind,:);
save('train.mat','train_x','train_y')

%% Generate Test Data
pd = makedist('Binomial','N',1,'p',0.8);
N1 = 50;
N2 = 50;
x1 = [random(pd,N1,1) exprnd(5,[N1,1])  mvnrnd([2;2],[3 0;0 6],N1)];
y1 = [ones(N1,1)];
pd = makedist('Binomial','N',1,'p',0.40);
x2 = [random(pd,N2,1) exprnd(10,[N2,1]) mvnrnd([-2;-2],[4 -3;-3 9],N2)];
y2 = [2*ones(N2,1)];
x  = [x1;x2];
y  = [y1;y2];
ind= randperm(size(x, 1));
test_x  = x(ind, :);
test_y  = y(ind,:);
save('test.mat','test_x','test_y')


