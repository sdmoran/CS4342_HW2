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
    
    if(x == 1)
        prob_disease = length(disease_and_indicator) / 100 * length(has_disease);
        prob_healthy = length(healthy_indicator) / 100 * length(healthy);
        if(prob_disease > prob_healthy)
            disease = 1;
        else
            disease = 0;
        end
    else %(x == 0)
        prob_disease = length(disease_no_indicator) / 100 * length(has_disease);
        prob_healthy = length(healthy_no_indicator) / 100 * length(healthy);
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
    
    % Continuous value being negative corresponds to being healthy
    if(x > 0)
        prob_disease = length(disease_and_indicator) / 100 * length(has_disease);
        prob_healthy = length(healthy_indicator) / 100 * length(healthy);
        if(prob_disease > prob_healthy)
            disease = 1;
        else
            disease = 0;
        end
    else %(x == 0)
        prob_disease = length(disease_no_indicator) / 100 * length(has_disease);
        prob_healthy = length(healthy_no_indicator) / 100 * length(healthy);
        if(prob_disease > prob_healthy)
            disease = 1;
        else
            disease = 0;
        end
    end
end
