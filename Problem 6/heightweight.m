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
        if c == 2 % THIS CONDITIONALLY PRINTS THE DATA. 1 = ONLY CLASS 1.
            % X(:,1) is height of a class, X(:, 2) is weight of a class.
            % h=scatter(X(:,1), X(:,2), 100, str); %set(h, 'markersize', 10);
            % This is the scatter plot but flipped
            h=scatter(X(:,2), X(:,1), 100, str); %set(h, 'markersize', 10);
        end
        hold on;
        [x,y] = meshgrid(linspace(50,80,100), linspace(80,280,100));
        [m,n]=size(x);
        X = [reshape(x, n*m, 1) reshape(y, n*m, 1)];
        %g{c} = reshape(gaussProb(X, mu{c}(:)', Sigma{c}), [m n]);
        % MVN with Height and Weight
        g{c} = reshape(mvnpdf(X, mu{c}(:)', Sigma{c}), [m n]);
        % This flips the orientation of the circley things
        contour(y,x,g{c}, colors(c)); % This draws the circley thingies
        %contour(x,y,g{c}, colors(c)); % This draws the circley thingies
    end
    xlabel('height'); ylabel('weight')
    % Draw decision boundary
    for c=1:2
        % OK This flips the shit
        [cc,hh]=contour(y,x,g{1} - g{2},[0 0], '-k');
        % OK THIS LINE GIVES THE CORRECT CURVE
        %plot(hh.ContourMatrix(1,2:end),hh.ContourMatrix(2,2:end))
        
        xcoords = hh.ContourMatrix(1,2:end);
        ycoords = hh.ContourMatrix(2,2:end);
        pp = spline(xcoords, ycoords);
        curverange = 100:200;
        yy = ppval(pp, curverange);
        disp(j);
        
        range = 80:0.1:280;
        curve = -0.0038*curverange.^2 + 0.9687.*curverange + 10.3885;
        % THIS Is the equation of the line.
        line = -0.1005 * range + 83.7011;
        
        %plot(ppval(pp, curverange), '-r');
        plot(range, line, '-r');
        
        k = -0.1005;
        n = 83.7011;
        under = 0;
        on = 0;
        above = 0;
        % Split data into classes
        classdata = data.X(classNdx{c},:);
        disp("CLASS: " + c);
        for i = 1 : length(classdata)
            a = classdata(i, 2);
            b = classdata(i, 1);
            if k*a + n > b
                %Under the line
                %plot(a, b, 'ob');
                under = under + 1;
            elseif k*a + n < b
                % Above the line
                above = above + 1;
                %plot(a, b, 'xr');
            else
                % On the line
                on = on + 1;
            end
        end
        set(hh,'linewidth',3);% Changes the width of the line
        
        disp("Above: " + above);
        disp("Under: " + under);
        disp("On: " + on);
    end
    if tied
        title('tied covariance')
        %printPmtkFigure(sprintf('heightWeightLDA'))
    else
        title('class-specific covariance')
        %printPmtkFigure(sprintf('heightWeightQDA'))
    end
end
