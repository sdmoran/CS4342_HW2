%% Linear/ quadratic discriminant analysis for Height Weight data
%
%%

% This file is from pmtk3.googlecode.com

clear all
rawdata = loadData('heightWeight');
data.Y = rawdata(:,1); % 1=male, 2=female
data.X = [rawdata(:,2) rawdata(:,3)]; % height, weight
disp("Data length: " + length(data.X));
maleNdx = find(data.Y == 1);
femaleNdx = find(data.Y == 2);
classNdx = {maleNdx, femaleNdx};

% Plot class conditional densities
for tied=[false true]
    figure;
    colors = 'br';
    sym = 'xo';
    styles = {'bx', 'ro'};
    for c=1:2
        X = data.X(classNdx{c},:);
        % fit Gaussian
        mu{c}= mean(X);
        if tied
            Sigma{c} = cov(data.X); % all classes (male and female)
        else
            Sigma{c} = cov(X); % class-specific (male or female)
        end
        str = sprintf('%s%s', sym(c), colors(c));
        % Plot data and model
        % THIS IF CONDITIONALLY PRINTS THE DATA. 1 = ONLY CLASS 1.
        %if c == 2
            % X(:,1) is height of a class, X(:, 2) is weight of a class.
            % h=scatter(X(:,1), X(:,2), 100, str); %set(h, 'markersize', 10);
            % This is the scatter plot but flipped
            h=scatter(X(:,2), X(:,1), 100, str); %set(h, 'markersize', 10);
        %end
        hold on;
        [x,y] = meshgrid(linspace(50,80,100), linspace(80,280,100));
        [m,n]=size(x);
        X = [reshape(x, n*m, 1) reshape(y, n*m, 1)];
        %g{c} = reshape(gaussProb(X, mu{c}(:)', Sigma{c}), [m n]);
        % MVN with Height and Weight
        g{c} = reshape(mvnpdf(X, mu{c}(:)', Sigma{c}), [m n]);
        % This flips the orientation of the circley things
        contour(y,x,g{c}, colors(c)); % This draws the circley thingies flipped
        %contour(x,y,g{c}, colors(c)); % This draws the circley thingies
    end
    % Flipped coordinates, so flip labels too
    ylabel('height'); xlabel('weight')
    
    % Indicate whether these statistics are for LDA or QDA
    if tied
        disp("========== LDA STATISTICS ==========");
    else
        disp("========== QDA STATISTICS ==========");
    end
    
    % Draw decision boundary
    for c=1:2
        % OK This flips the curve on the x and y axes, which means we can
        % represent it as a function in order to categorize.
        [cc,hh]=contour(y,x,g{1} - g{2},[0 0], '-k');
        % OK THIS LINE GIVES THE CORRECT CURVE
        %plot(hh.ContourMatrix(1,2:end),hh.ContourMatrix(2,2:end))
        
        range = 80:0.1:280;
        % Get x coordinates of the curve
        xcoords = hh.ContourMatrix(1,2:end);
        % Get y coordinates of the curve
        ycoords = hh.ContourMatrix(2,2:end);
        % Build piecewise polynomial based on the curve coords
        pp = spline(xcoords, ycoords);
        yy = ppval(pp, range);

        % THIS is the equation of the line, calculated by polyfit.
        line = -0.1005 * range + 83.7011;
        
        plot(range, line, '-r');
        
        k = -0.1005;
        n = 83.7011;
        under_line = 0;
        on_line = 0;
        above_line = 0;
        
        under_curve = 0;
        on_curve = 0;
        above_curve = 0;

        % Filter data based on the class we're looking at
        classdata = data.X(classNdx{c},:);
        for i = 1 : length(classdata)
            a = classdata(i, 2);
            b = classdata(i, 1);
            
            % Check each data point for misclassification by LDA
            if k*a + n > b
                %Under the line
                under_line = under_line + 1;
            elseif k*a + n < b
                % Above the line
                above_line = above_line + 1;
            else
                % On the line
                on_line = on_line + 1;
            end
            
            % Check each data point for misclassification by QDA
            % Sample a value of curve at data.x and compare to data.x
            curvey = ppval(pp, a);
            
            % Have to check if a is less than 200, because the piecewise
            % polynomial starts behaving strangely (it's an odd-number
            % order, and goes up to infinity beyond this range). From
            % the graph, it's clear that any data points with a > 200 are
            % outside the curve anyway.
            if curvey > b && a < 200
             %Under the curve
                under_curve = under_curve + 1;
                %plot(a, b, 'mo');
            elseif curvey < b || a >= 200
                % Above the curve
                above_curve = above_curve + 1;
                %plot(a, b, 'mx');
            else
                % On the curve
                on_curve = on_curve + 1;
            end
                 
                
        end
        set(hh,'linewidth',3);% Changes the width of the line
        
        % If this is class 1, we expect it to be above the line/curve.
        % Therefore, the error is the proportion UNDER the line/curve.
        if c == 1
            error_l = under_line / (above_line + under_line + on_line);
            error_c = under_curve / (above_curve + under_curve + on_curve); 
        else % If class 2, we expect it to be below line/curve.
           error_l = above_line / (above_line + under_line + on_line);
           error_c = above_curve / (above_curve + under_curve + on_curve); 

        end
        if(tied)    % If covariance is tied, report LDA statistics.
            disp("Class: " + c);
            disp("Covariance: TIED");
            disp("Above line: " + above_line);
            disp("Under line: " + under_line);
            disp("On line: " + on_line);
            disp("LDA class " + c + " % Misclassified: " + error_l);
            disp(newline);
        else        % If covariance is class-specifc, report QDA statistics.
            disp("Class: " + c);
            disp("Covariance: CLASS-SPECIFIC");
            disp("Above curve: " + above_curve);
            disp("Under curve: " + under_curve);
            disp("On curve: " + on_curve);
            disp("QDA class " + c + " % Misclassified: " + error_c);
            disp(newline);
        end
    end
    if tied
        title('tied covariance')
        %printPmtkFigure(sprintf('heightWeightLDA'))
    else
        title('class-specific covariance')
        %printPmtkFigure(sprintf('heightWeightQDA'))
    end
end
