%% Linear/ quadratic discriminant analysis for Height Weight data
%
%%

% This file is from pmtk3.googlecode.com

clear all
rawdata = loadData('heightWeight');
data.Y = rawdata(:,1); % 1=male, 2=female
data.X = [rawdata(:,2) rawdata(:,3)]; % height, weight
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
            Sigma{c} = cov(data.X); % all classes
        else
            Sigma{c} = cov(X); % class-specific
        end
        str = sprintf('%s%s', sym(c), colors(c));
        % Plot data and model
        if c == 1 % THIS CONDITIONALLY PRINTS THE DATA. 1 = ONLY CLASS 1.
            h=scatter(X(:,1), X(:,2), 100, str); %set(h, 'markersize', 10);
        end
        hold on;
        [x,y] = meshgrid(linspace(50,80,100), linspace(80,280,100));
        [m,n]=size(x);
        X = [reshape(x, n*m, 1) reshape(y, n*m, 1)];
        %g{c} = reshape(gaussProb(X, mu{c}(:)', Sigma{c}), [m n]);
        g{c} = reshape(mvnpdf(X, mu{c}(:)', Sigma{c}), [m n]);
        contour(x,y,g{c}, colors(c)); % This draws the circley thingies
    end
    xlabel('height'); ylabel('weight')
    % Draw decision boundary
    %for c=1:2
        %if c == 1 I have genuinely 0 idea how the fuck this works
        [cc,hh]=contour(x,y,g{1} - g{2},[0 0], '-k');
        %plot(cc(1, :), cc(2, :), 'r.');
        jxs = 50:0.01:80;
        ys = -5.5699 * jxs + 543.2542;
        curveys = -0.0820 * jxs .^2 + 5.5467 * jxs + 134.7568;
        plot(jxs, ys);
        plot(jxs, curveys);
        j = polyfit(cc(1, :), cc(2, :), 2);
        disp(j);
%         plot(hh(:, 1), hh(:, 2));
        set(hh,'linewidth',3);% Changes the width of the line
        %end
    %end
    if tied
        title('tied covariance')
        printPmtkFigure(sprintf('heightWeightLDA'))
    else
        title('class-specific covariance')
        printPmtkFigure(sprintf('heightWeightQDA'))
    end
end
