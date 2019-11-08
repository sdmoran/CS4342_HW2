clear all
close all

%% Load training and test dataset
load('train.mat');
load('test.mat');

%% Visualize data (step 1)
% train_x and train_y
disp(['------input(x1,x2,x3,x4) -------------- class label(y)'])
disp([train_x(1:10,:) train_y(1:10,:)])


%% Visualuze data (step 2)
clc
ind_1 = find(train_y==1);
ind_2 = find(train_y==2);

for j=1:4
    subplot(2,2,1)
    plot(train_x(ind_1,j),'bo','Markersize',12,'linewidth',2);
    title('Class 1')
    xlabel(['x' num2str(j)])
    set(gca,'FontSize', 18);

    subplot(2,2,2)
    histogram(train_x(ind_1,j),20);
    title('Class 1')
    xlabel(['x' num2str(j)])
    set(gca,'FontSize', 18);

    subplot(2,2,3)
    plot(train_x(ind_2,j),'bo','Markersize',12,'linewidth',2);
    title('Class 2')
    xlabel(['x' num2str(j)])
    set(gca,'FontSize', 18);
   
    subplot(2,2,4)
    histogram(train_x(ind_2,j),20);
    title('Class 2')
    xlabel(['x' num2str(j)])
    set(gca,'FontSize', 18);
    set(gcf, 'Position', get(0, 'Screensize'));
end

%% Visualuze data (step 3)
clc
ind_1 = find(train_y==1);
ind_2 = find(train_y==2);

subplot(2,2,1)
plot(0.1+train_x(ind_1,1),'bo','Markersize',12,'linewidth',2);
hold on
plot(train_x(ind_2,1),'r*','Markersize',12,'linewidth',2);
hold off
title('Class 1 & 2')
xlabel('x1')
set(gca,'FontSize', 18);

subplot(2,2,2)
histogram(train_x(ind_1,2),20,'FaceColor','b');
hold on
histogram(train_x(ind_2,2),20,'FaceColor','r');
hold off
title('Class 1 & 2')
xlabel('x2')
set(gca,'FontSize', 18);
legend('Class 1','Class 2')

subplot(2,2,3)
histogram(train_x(ind_1,3),20,'FaceColor','b');
hold on
histogram(train_x(ind_2,3),20,'FaceColor','r');
hold off
title('Class 1 & 2')
xlabel('x3')
set(gca,'FontSize', 18);

subplot(2,2,4)
histogram(train_x(ind_1,4),20,'FaceColor','b');
hold on
histogram(train_x(ind_2,4),20,'FaceColor','r');
title('Class 1 & 2')
xlabel('x4')
set(gca,'FontSize', 18);
set(gcf, 'Position', get(0, 'Screensize'));

%% Visualuze data (step 4)
% % feature 1 and 2
% close all
% ind_1 = find(train_y==1);
% ind_2 = find(train_y==2);
% 
% plot(train_x(ind_1,1)+0.05,train_x(ind_1,2),'bo','Markersize',12,'linewidth',2);
% hold on
% plot(train_x(ind_2,1),train_x(ind_2,2),'r*','Markersize',12,'linewidth',2);
% hold off
% title('Class 1 & 2')
% xlabel('x1')
% ylabel('x2')
% set(gca,'FontSize', 18);
% legend('Class 1','Class 2')
% set(gcf, 'Position', get(0, 'Screensize'));
% 
% % feature 2 and 3
% close all
% plot(train_x(ind_1,2),train_x(ind_1,3),'bo','Markersize',12,'linewidth',2);
% hold on
% plot(train_x(ind_2,2),train_x(ind_2,3),'r*','Markersize',12,'linewidth',2);
% hold off
% title('Class 1 & 2')
% xlabel('x2')
% ylabel('x3')
% set(gca,'FontSize', 18);
% legend('Class 1','Class 2')
% set(gcf, 'Position', get(0, 'Screensize'));

% feature 3 and 4
close all
plot(train_x(ind_1,3),train_x(ind_1,4),'bo','Markersize',12,'linewidth',2);
hold on
plot(train_x(ind_2,3),train_x(ind_2,4),'r*','Markersize',12,'linewidth',2);
hold off
title('Class 1 & 2')
xlabel('x3')
ylabel('x4')
set(gca,'FontSize', 18);
legend('Class 1','Class 2')
set(gcf, 'Position', get(0, 'Screensize'));

% feature 2, 3 and 4
close all
plot3(train_x(ind_1,2),train_x(ind_1,3),train_x(ind_1,4),'bo','Markersize',12,'linewidth',2);
hold on
plot3(train_x(ind_2,2),train_x(ind_2,3),train_x(ind_2,4),'r*','Markersize',12,'linewidth',2);
hold off
title('Class 1 & 2')
xlabel('x2')
ylabel('x3')
zlabel('x4')
set(gca,'FontSize', 18);
grid on
legend('Class 1','Class 2')
set(gcf, 'Position', get(0, 'Screensize'));
xlim([-3 inf])


%% Build Classifiers and Report the Performance
% prior per class
close all
clc
histogram(train_y,10);
title('Class 1 & 2')
xlabel(['y' num2str(j)])
set(gca,'FontSize', 18);
set(gca,'FontSize', 18);
set(gcf, 'Position', get(0, 'Screensize'));

prior   = [length(ind_1)/(length(ind_1)+length(ind_2));      length(ind_2)/(length(ind_1)+length(ind_2))];
disp('piror on class 1 and 2')
disp(prior)

%% Build using X1
observe_1 = [sum(train_x(ind_1,1))/length(ind_1); sum(train_x(ind_2,1))/length(ind_2)];
disp('Observation parameters')
disp(observe_1)

% classifier result based on x1
conf_matrix = zeros(2,2);
for i=1:length(train_y)
    p1 = prior(1) * observe_1(1)^train_x(i,1) * (1-observe_1(1))^(1-train_x(i,1));
    p2 = prior(2) * observe_1(2)^train_x(i,1) * (1-observe_1(2))^(1-train_x(i,1));
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,train_y(i))=conf_matrix(y_hat,train_y(i))+1;
end
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))
% classifier result based on x1 (test)
conf_matrix = zeros(2,2);
for i=1:length(test_y)
    p1 = prior(1) * observe_1(1)^test_x(i,1) * (1-observe_1(1))^(1-test_x(i,1));
    p2 = prior(2) * observe_1(2)^test_x(i,1) * (1-observe_1(2))^(1-test_x(i,1));
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,test_y(i))=conf_matrix(y_hat,test_y(i))+1;
end
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))

%% Build using X2
% classifier result based on x2
observe_2 = [length(ind_1)/sum(train_x(ind_1,2)); length(ind_2)/sum(train_x(ind_2,2))];
disp('Observation parameters')
disp(observe_2)

conf_matrix = zeros(2,2);
for i=1:length(train_y)
    p1 = prior(1) * (observe_2(1)*exp(-observe_2(1)*train_x(i,2)));
    p2 = prior(2) * (observe_2(2)*exp(-observe_2(2)*train_x(i,2)));
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,train_y(i))=conf_matrix(y_hat,train_y(i))+1;
end
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))
% classifier result based on x1 (test)
conf_matrix = zeros(2,2);
for i=1:length(test_y)
    p1 = prior(1) * observe_2(1)*exp(-observe_2(1)*test_x(i,2));
    p2 = prior(2) * observe_2(2)*exp(-observe_2(2)*test_x(i,2));
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,test_y(i))=conf_matrix(y_hat,test_y(i))+1;
end
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))


% Visualize X2 Model
y_hat = [];
p1_a  = [];
p2_a  = [];
for i=1:length(test_y)
    p1 = prior(1) * observe_2(1)*exp(-observe_2(1)*test_x(i,2));%*(observe_1(1)^test_x(i,1) * (1-observe_1(1))^(1-test_x(i,1)));
    p2 = prior(2) * observe_2(2)*exp(-observe_2(2)*test_x(i,2));%*(observe_1(2)^test_x(i,1) * (1-observe_1(2))^(1-test_x(i,1)));
    p1_a  = [p1_a;p1];
    p2_a  = [p2_a;p2];
    if p1 > p2
        y_hat(i) = 1;
    else
        y_hat(i) = 2;
    end
    conf_matrix(y_hat,test_y(i))=conf_matrix(y_hat,test_y(i))+1;
end

subplot(3,1,1)
plot(p1_a,'bo','MarkerSize',12,'linewidth',2);hold on;
plot(p2_a,'r*','MarkerSize',12,'linewidth',2);hold on;plot(p2_a,'r','linewidth',1);
plot(p1_a,'b','linewidth',1);
xlabel('Sample')
ylabel('Posterior')
legend('Class1','Class2')
set(gca,'FontSize', 18);

subplot(3,1,2)
ind_1 = find(test_y==1);
ind_2 = find(test_y==2);
plot(ind_1,test_y(ind_1),'bo','Markersize',12,'linewidth',2);hold on;
plot(ind_2,test_y(ind_2),'r*','Markersize',12,'linewidth',2);hold on;

plot(y_hat,'k+','Markersize',12,'linewidth',2);
xlabel('Sample')
ylabel('Class')
legend('True Label (1)','True Label (2)','Prediction')
set(gca,'FontSize', 18);

subplot(3,2,5)
x=0:0.1:50;
plot(x,log(observe_2(1)*exp(-observe_2(1)*x)),'b','linewidth',2);hold on;
plot(x,log(observe_2(2)*exp(-observe_2(2)*x)),'r','linewidth',2);hold on;
xlabel('X')
ylabel('log(pdf)')
set(gca,'FontSize', 18);
grid minor

subplot(3,2,6)
ind_1 = find(test_y==1);
ind_2 = find(test_y==2);
plot(ind_1,test_x(ind_1,2),'bo','Markersize',12,'linewidth',2);hold on;
plot(ind_2,test_x(ind_2,2),'r*','Markersize',12,'linewidth',2);hold on;
xlabel('X2')
title('Test')
grid minor
set(gca,'FontSize', 18);
set(gcf, 'Position', get(0, 'Screensize'));


%% Build Using X1 and X2
% classifier result based x1 on x2
conf_matrix = zeros(2,2);
for i=1:length(train_y)
    p1 = prior(1) * ( observe_2(1)*exp(-observe_2(1)*train_x(i,2)) ) * (observe_1(1)^train_x(i,1) * (1-observe_1(1))^(1-train_x(i,1)));
    p2 = prior(2) * ( observe_2(2)*exp(-observe_2(2)*train_x(i,2)) ) * (observe_1(2)^train_x(i,1) * (1-observe_1(2))^(1-train_x(i,1))) ;
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,train_y(i))=conf_matrix(y_hat,train_y(i))+1;
end
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))
% classifier result based on x1 (test)
conf_matrix = zeros(2,2);
for i=1:length(test_y)
    p1 = prior(1) * observe_2(1)*exp(-observe_2(1)*test_x(i,2))*(observe_1(1)^test_x(i,1) * (1-observe_1(1))^(1-test_x(i,1)));
    p2 = prior(2) * observe_2(2)*exp(-observe_2(2)*test_x(i,2))*(observe_1(2)^test_x(i,1) * (1-observe_1(2))^(1-test_x(i,1)));
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,test_y(i))=conf_matrix(y_hat,test_y(i))+1;
end
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))




%% QDA, using the last two functions
ind_1 = find(train_y==1);
ind_2 = find(train_y==2);


m1 = mean(train_x(ind_1,3:4)); s1 = cov(train_x(ind_1,3:4));
m2 = mean(train_x(ind_2,3:4)); s2 = cov(train_x(ind_2,3:4));

conf_matrix = zeros(2,2);
for i=1:length(train_y)
    p1 = prior(1) * mvnpdf(train_x(i,3:4),m1,s1);
    p2 = prior(2) * mvnpdf(train_x(i,3:4),m2,s2);
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,train_y(i))=conf_matrix(y_hat,train_y(i))+1;
end
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))
% classifier result based on x1 (test)
conf_matrix = zeros(2,2);
for i=1:length(test_y)
     p1 = prior(1) * mvnpdf(test_x(i,3:4),m1,s1);
    p2 = prior(2) * mvnpdf(test_x(i,3:4),m2,s2);
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,test_y(i))=conf_matrix(y_hat,test_y(i))+1;
end
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))

subplot(1,3,1)
plot(train_x(ind_1,3),train_x(ind_1,4),'r*');
hold on
x1 = -10:.2:10;
x2 = -10:.2:10;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
y = mvnpdf(X,m1,s1);
y = reshape(y,length(x2),length(x1));
contour(x1,x2,y,3,'r')

plot(train_x(ind_2,3),train_x(ind_2,4),'bo');
hold on
x1 = -10:0.05:10;
x2 = -10:0.05:10;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
y = mvnpdf(X,m2,s2);
y = reshape(y,length(x2),length(x1));
contour(x1,x2,y,3,'b')
xlabel('X3')
ylabel('X4')
grid minor
set(gca,'FontSize', 18);


I = zeros(length(x1),length(x2));
for i = 1:length(x1)
   for j=1:length(x2) 
        p1 = prior(1) * mvnpdf([x1(i) x2(j)],m1,s1);
        p2 = prior(2) * mvnpdf([x1(i) x2(j)],m2,s2);
        if p1>p2
            I(i,j)=30;
        else
            I(i,j)=60;
        end
   end
end
subplot(1,3,2)
imagesc(x1,x2,I');hold on;
alpha 0.5
set(gca,'YDir','normal')
plot(train_x(ind_1,3),train_x(ind_1,4),'r*');
plot(train_x(ind_2,3),train_x(ind_2,4),'bo');
set(gca,'FontSize', 18);
xlabel('X3')
ylabel('X4')
title('Training')

subplot(1,3,3)
imagesc(x1,x2,I');hold on;
alpha 0.5
set(gca,'YDir','normal')
ind_1=find(test_y==1);
ind_2=find(test_y==2);
plot(test_x(ind_1,3),test_x(ind_1,4),'r*');
plot(test_x(ind_2,3),test_x(ind_2,4),'bo');
set(gca,'FontSize', 18);
xlabel('X3')
ylabel('X4')
title('Test')
set(gcf, 'Position', get(0, 'Screensize'));


%% LDA, using the last two functions
ind_1 = find(train_y==1);
ind_2 = find(train_y==2);

s  = cov(train_x(:,3:4));
m1 = mean(train_x(ind_1,3:4)); s1 = s;
m2 = mean(train_x(ind_2,3:4)); s2 = s;

conf_matrix = zeros(2,2);
for i=1:length(train_y)
    p1 = prior(1) * mvnpdf(train_x(i,3:4),m1,s1);
    p2 = prior(2) * mvnpdf(train_x(i,3:4),m2,s2);
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,train_y(i))=conf_matrix(y_hat,train_y(i))+1;
end
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))
% classifier result based on x1 (test)
conf_matrix = zeros(2,2);
for i=1:length(test_y)
     p1 = prior(1) * mvnpdf(test_x(i,3:4),m1,s1);
    p2 = prior(2) * mvnpdf(test_x(i,3:4),m2,s2);
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,test_y(i))=conf_matrix(y_hat,test_y(i))+1;
end
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))

subplot(1,3,1)
plot(train_x(ind_1,3),train_x(ind_1,4),'r*');
hold on
x1 = -10:.2:10;
x2 = -10:.2:10;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
y = mvnpdf(X,m1,s1);
y = reshape(y,length(x2),length(x1));
contour(x1,x2,y,3,'r')

plot(train_x(ind_2,3),train_x(ind_2,4),'bo');
hold on
x1 = -10:0.05:10;
x2 = -10:0.05:10;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
y = mvnpdf(X,m2,s2);
y = reshape(y,length(x2),length(x1));
contour(x1,x2,y,3,'b')
xlabel('X3')
ylabel('X4')
grid minor
set(gca,'FontSize', 18);


I = zeros(length(x1),length(x2));
for i = 1:length(x1)
   for j=1:length(x2) 
        p1 = prior(1) * mvnpdf([x1(i) x2(j)],m1,s1);
        p2 = prior(2) * mvnpdf([x1(i) x2(j)],m2,s2);
        if p1>p2
            I(i,j)=30;
        else
            I(i,j)=60;
        end
   end
end
subplot(1,3,2)
imagesc(x1,x2,I');hold on;
alpha 0.5
set(gca,'YDir','normal')
plot(train_x(ind_1,3),train_x(ind_1,4),'r*');
plot(train_x(ind_2,3),train_x(ind_2,4),'bo');
set(gca,'FontSize', 18);
xlabel('X3')
ylabel('X4')
title('Training')

subplot(1,3,3)
imagesc(x1,x2,I');hold on;
alpha 0.5
set(gca,'YDir','normal')
ind_1=find(test_y==1);
ind_2=find(test_y==2);
plot(test_x(ind_1,3),test_x(ind_1,4),'r*');
plot(test_x(ind_2,3),test_x(ind_2,4),'bo');
set(gca,'FontSize', 18);
xlabel('X3')
ylabel('X4')
title('Test')
set(gcf, 'Position', get(0, 'Screensize'));


%% All features, QDA
ind_1 = find(train_y==1);
ind_2 = find(train_y==2);

m1 = mean(train_x(ind_1,:)); s1 = cov(train_x(ind_1,:));
m2 = mean(train_x(ind_2,:)); s2 = cov(train_x(ind_2,:));

conf_matrix = zeros(2,2);
for i=1:length(train_y)
    p1 = prior(1) * mvnpdf(train_x(i,:),m1,s1);
    p2 = prior(2) * mvnpdf(train_x(i,:),m2,s2);
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,train_y(i))=conf_matrix(y_hat,train_y(i))+1;
end
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))
% classifier result based on x1 (test)
conf_matrix = zeros(2,2);
for i=1:length(test_y)
     p1 = prior(1) * mvnpdf(test_x(i,:),m1,s1);
    p2 = prior(2) * mvnpdf(test_x(i,:),m2,s2);
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,test_y(i))=conf_matrix(y_hat,test_y(i))+1;
end
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))



%% All features, LDA
ind_1 = find(train_y==1);
ind_2 = find(train_y==2);
s  = cov(train_x);
m1 = mean(train_x(ind_1,:)); s1 = s;
m2 = mean(train_x(ind_2,:)); s2 = s;

conf_matrix = zeros(2,2);
for i=1:length(train_y)
    p1 = prior(1) * mvnpdf(train_x(i,:),m1,s1);
    p2 = prior(2) * mvnpdf(train_x(i,:),m2,s2);
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,train_y(i))=conf_matrix(y_hat,train_y(i))+1;
end
%subplot(1,2,1)
%imagesc(conf_matrix)
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))
%title(num2str(accuracy))
%colorbar
% classifier result based on x1 (test)
conf_matrix = zeros(2,2);
for i=1:length(test_y)
     p1 = prior(1) * mvnpdf(test_x(i,:),m1,s1);
    p2 = prior(2) * mvnpdf(test_x(i,:),m2,s2);
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,test_y(i))=conf_matrix(y_hat,test_y(i))+1;
end
%subplot(1,2,2)
%imagesc(conf_matrix)
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))
%title(num2str(accuracy))
%colorbar


%% Build using X1 - MAP Mean
ind_1 = find(train_y==1);
ind_2 = find(train_y==2)

observe_1 = [(2+sum(train_x(ind_1,1)))/(4+length(ind_1)); (2+sum(train_x(ind_2,1)))/(4+length(ind_2))];
disp('Observation parameters')
disp(observe_1)

% classifier result based on x1
conf_matrix = zeros(2,2);
for i=1:length(train_y)
    p1 = prior(1) * observe_1(1)^train_x(i,1) * (1-observe_1(1))^(1-train_x(i,1));
    p2 = prior(2) * observe_1(2)^train_x(i,1) * (1-observe_1(2))^(1-train_x(i,1));
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,train_y(i))=conf_matrix(y_hat,train_y(i))+1;
end
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))
% classifier result based on x1 (test)
conf_matrix = zeros(2,2);
for i=1:length(test_y)
    p1 = prior(1) * observe_1(1)^test_x(i,1) * (1-observe_1(1))^(1-test_x(i,1));
    p2 = prior(2) * observe_1(2)^test_x(i,1) * (1-observe_1(2))^(1-test_x(i,1));
    if p1 > p2
        y_hat = 1;
    else
        y_hat = 2;
    end
    conf_matrix(y_hat,test_y(i))=conf_matrix(y_hat,test_y(i))+1;
end
accuracy = sum(conf_matrix(1,1)+conf_matrix(2,2))/sum(sum(conf_matrix))



