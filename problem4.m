load('assignment_2_problem_4.mat');
has_disease = find(xy(:, 3) == 1);
healthy = find(xy(:, 3) == 0);

% Plot of discrete for patients that have disease
figure(1)
histogram(xy(has_disease, 1))
title('Has disease discrete');

% Plot of continuous for patients that have disease
figure(2)
histogram(xy(has_disease, 2))
title('Has disease continuous');

% Plot of discrete for patients that have disease
figure(3)
histogram(xy(healthy, 1))
title('Healthy discrete');

% Plot of continuous for patients that have disease
figure(4)
histogram(xy(healthy, 2))
title('Healthy continuous');

% DISCRETE 
% Classify diseased individuals
s = 0;
for i = 1 : length(has_disease)
    s = s + (Prob_Disease_Discrete(xy(has_disease(i), 1)));
end

disp(" DISCRETE ");
disp("Diseased people categorized as diseased: " + s);
disp("Total diseased: " + length(has_disease));

% Classify diseased individuals
s = 0;
for i = 1 : length(healthy)
    if(Prob_Disease_Discrete(xy(healthy(i), 1))) == 0
        s = s + 1;
    end
end
disp("People categorized as healthy: " + s);
disp("Total healthy: " + length(healthy));

% CONTINUOUS
s = 0;
for i = 1 : length(has_disease)
    s = s + (Prob_Disease_Continuous(xy(has_disease(i), 2)));
end

disp(" CONTINUOUS ");
disp("Diseased people categorized as diseased: " + s);
disp("Total diseased: " + length(has_disease));

% Classify diseased individuals
s = 0;
for i = 1 : length(healthy)
    if(Prob_Disease_Continuous(xy(healthy(i), 2))) == 0
        s = s + 1;
    end
end
disp("People categorized as healthy: " + s);
disp("Total healthy: " + length(healthy));

total_healthy = length(healthy);
total_diseased = length(has_disease);

% Discrete has indicator or not
d_disease_yes = find(xy(has_disease, 1) == 1);
d_disease_no = find(xy(has_disease, 1) == 0);
d_healthy_yes = find(xy(healthy, 1) == 1);
d_healthy_no = find(xy(healthy, 1) == 0);

% Positive continuous value -> disease
c_disease_pos = find(xy(has_disease, 2) > 0);
c_disease_neg = find(xy(has_disease, 2) <= 0);
c_healthy_pos = find(xy(healthy, 2) > 0);
c_healthy_neg = find(xy(healthy, 2) <= 0);

% Probability calculations for discrete case
% Discrete: disease, no indicator
disp("P(y='disease'|x='1'): " + length(d_disease_yes)/100);
disp("P(y='healthy'|x='1'): " + length(d_healthy_yes)/100);
disp("P(y='disease'|x='0'): " + length(d_disease_no)/100);
disp("P(y='healthy'|x='0'): " + length(d_healthy_no)/100);

% General probability of health/disease
disp("P(y='disease'): " + length(has_disease)/ 100);
disp("P(y='healthy'): " + length(healthy)/ 100);

% Classify people using naive bayes classifier
healthy_count = 0;
diseased_count = 0;
for i = 1 : length(xy)
    % If it's more likely they DON'T have the disease, add 1 to healthy ct
    if Naive_Bayes(xy(i, 1), xy(i, 2)) == 0
        healthy_count = healthy_count + 1;
    else
        diseased_count = diseased_count + 1;
    end
end
disp("Naive Bayes classified healthy: " + healthy_count);
disp("Naive Bayes classified diseased: " + diseased_count);
% Discrete is the discrete marker, cont is continuous

%!!! NORMAL DIST NEEDS TO HAVE CASES FOR PEOPLE HAVING/NOT HAVING DISEASE
function disease = Naive_Bayes(disc, cont)
    load('assignment_2_problem_4.mat');
    has_disease = find(xy(:, 3) == 1);
    healthy = find(xy(:, 3) == 0);
    
    disease_and_indicator = find(xy(has_disease, 1) == 1);
    %disp("Disease and indicator: " + length(disease_and_indicator));

    disease_no_indicator = find(xy(has_disease, 1) == 0);
    %disp("Disease no indicator: " + length(disease_no_indicator));

    healthy_indicator = find(xy(healthy, 1) == 1);
    %disp("No disease, indicator: " + length(healthy_indicator));

    healthy_no_indicator = find(xy(healthy, 1) == 0);
    
    % Probability of having the disease
    x1_dist = fitdist(xy(:, 3), 'Binomial');
    
    % Probability that they are HEALTHY given this value of indicator
    healthy_dist = fitdist(xy(healthy, 2), 'Normal');
    
    % Probability that they are DISEASED given this value of indicator
    disease_dist = fitdist(xy(has_disease, 2), 'Normal');
    
   
    if(disc == 1)
        prob_disease = length(disease_and_indicator) / 100 * pdf(x1_dist, 1) * pdf(disease_dist, cont);
        prob_healthy = length(healthy_indicator) / 100 * pdf(x1_dist, 0) * pdf(healthy_dist, cont);
        if(prob_disease > prob_healthy)
            disease = 1;
        else
            disease = 0;
        end
    else %(x == 0)
        prob_disease = length(disease_no_indicator) / 100 * pdf(x1_dist, 1) * pdf(disease_dist, cont);
        prob_healthy = length(healthy_no_indicator) / 100 * pdf(x1_dist, 0) * pdf(healthy_dist, cont);
        if(prob_disease > prob_healthy)
            disease = 1;
        else
            disease = 0;
        end
    end
    
end

function disease = Prob_Disease_Discrete(x)
    load('assignment_2_problem_4.mat');
    has_disease = find(xy(:, 3) == 1);
    healthy = find(xy(:, 3) == 0);
    % Probability that disease given indicator
    % If the indicator is one... simulate probability that they have the
    % disease and their indicator is one * 
    % Looking for number who HAVE disease AND have indicator 
    disease_and_indicator = find(xy(has_disease, 1) == 1);
    %disp("Disease and indicator: " + length(disease_and_indicator));

    disease_no_indicator = find(xy(has_disease, 1) == 0);
    %disp("Disease no indicator: " + length(disease_no_indicator));

    healthy_indicator = find(xy(healthy, 1) == 1);
    %disp("No disease, indicator: " + length(healthy_indicator));

    healthy_no_indicator = find(xy(healthy, 1) == 0);
    %disp("No disease, no indicator: " + length(healthy_no_indicator));
    
    % Probability of having the disease
    dist = fitdist(xy(:, 3), 'Binomial');
    
    %disp(dist);
    
    if(x == 1)
        % Probability of having disease given indicator * probability of
        % having disease
        prob_disease = length(disease_and_indicator) / 100 * pdf(dist, 1);
        prob_healthy = length(healthy_indicator) / 100 * pdf(dist, 0);
        if(prob_disease > prob_healthy)
            disease = 1;
        else
            disease = 0;
        end
    else %(x == 0)
        prob_disease = length(disease_no_indicator) / 100 * pdf(dist, 1);
        prob_healthy = length(healthy_no_indicator) / 100 * pdf(dist, 0);
        if(prob_disease > prob_healthy)
            disease = 1;
        else
            disease = 0;
        end
    end
end

function disease = Prob_Disease_Continuous(x)
    load('assignment_2_problem_4.mat');
    has_disease = find(xy(:, 3) == 1);
    healthy = find(xy(:, 3) == 0);
    
    % Probability that they are HEALTHY given this value of indicator
    healthy_dist = fitdist(xy(healthy, 2), 'Normal');
    
    % Probability that they are DISEASED given this value of indicator
    disease_dist = fitdist(xy(has_disease, 2), 'Normal');
    
    prob_disease = pdf(disease_dist, x) * length(has_disease) / 100;
    prob_healthy = pdf(healthy_dist, x) * length(healthy) / 100;
    
    if(prob_disease > prob_healthy)
        disease = 1;
    else
        disease = 0;
    end
end
