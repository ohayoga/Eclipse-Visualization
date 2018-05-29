%% Ellipse Viz
%  Instructions
%  ------------
%
%  1. Apply anomaly detection and exclude outliers.
%  2. Detect convex hull and delete insiders.
%  3. Fill the edges with uniformly distributed dots.
%  4. Estimate Mean and Covariance matrix of remaining dots.
%  5. Draw the probability contour with the smallest probability.
%  6. Compute the parameters of the ellipse.
%

%% Initialization
clear ; close all; clc

%% ================== Part 1: Load Example Dataset  ===================
%  We start by visualizing two 2-D dataset with different size.
%

fprintf('Visualizing example dataset.\n');

%  The following command loads the dataset.
load('data1.mat');

%  Visualize the example dataset
plot(X(:, 1), X(:, 2), 'bx');
xlim([0 30])
ylim([0 30])

fprintf('Program paused. Press enter to continue.\n\n');
pause


%% ================== Part 2: Estimate the dataset statistics ===================
%  We first estimate the parameters of our assumed Gaussian distribution, 
%  then compute the probabilities for each of the points and then visualize 
%  both the overall distribution and where each of the points falls in 
%  terms of that distribution.
%

fprintf('Visualizing Gaussian fit.\n');

%  Estimate mean and covariance
mu = mean(X)';
Cov = cov(X);

%  Returns the density of the multivariate normal at each data point (row) 
%  of X
p = multivariateGaussian(X, mu, Cov);

%  Visualize the fit
visualizeFit(X, mu, Cov);

fprintf('Program paused. Press enter to continue.\n\n');
pause;


%% ================== Part 3: Find Outliers ===================
%  We will find outliers that have probabilities lower than a epsilon 
%  threshold, then mark them.
% 

fprintf('Finding outliers.\n');

%  Epsilon can be replaced by any reliable value.
epsilon = 1e-5;

%  Find the outliers in the training set and plot the
outliers = find(p < epsilon);

%  Draw a red circle around those outliers
hold on
plot(X(outliers, 1), X(outliers, 2), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
hold off

fprintf('Program paused. Press enter to continue.\n\n');
pause;


%% ================== Part 4: Detect convex hull ===================
%  We exclude outliers and detect the convex hull of remianing points.
%

fprintf('Detect convex hull\n');

%  Exclude outliers
Xre = X;
Xre(outliers, :) = [];

%  Returns the convex hull and gap
[Xre,r] = convexhull(Xre);

%  Visualize the fit
visualizeFit(Xre, mu, Cov);

fprintf('Program paused. Press enter to continue.\n\n');
pause;


%% ================== Part 5: Fill convex hull ===================
%  We fill the convex hull with uniformly distributed dots and the gap
%  between any two consecutive dots equals the value of the shortest edge.
%

fprintf('Fill convex hull.\n');

%  Fill the convex hull
Xre = fillhull(Xre,r);

%  Visualize the fit
visualizeFit(Xre, mu, Cov);

fprintf('Program paused. Press enter to continue.\n\n');
pause;


%% ================== Part 6: Re-Estimate statistics ===================
%  We re-estimate the parameters of the modified convex hull, then compute
%  the probabilities for each of the points and then visualize both the
%  overall distribution and where each of the points falls in terms of that
%  distribution.
%

fprintf('Re-Visualizing Gaussian fit.\n');

%  Estimate mean and covariance
mu = mean(Xre)';
Cov = cov(Xre);

%  Returns the density of the multivariate normal at each data point (row) 
%  of X
p = multivariateGaussian(Xre, mu, Cov);

%  Visualize the fit
visualizeFit(Xre, mu, Cov);

fprintf('Program paused. Press enter to continue.\n\n');
pause;


%% ================== Part 7: Ellipse contour ===================
%  We find the point with the lowest probability and draw a contour of the
%  assumed Gaussian distribution with respect to that value.
%

fprintf('Drawing Ellipse Contour.\n');

pmin = min(p);

%  Set mesh for drawing contour.
[X1,X2] = meshgrid(0:.1:30); 
Z = multivariateGaussian([X1(:) X2(:)],mu,Cov);
Z = reshape(Z,size(X1));

%  Find value of Z that is closest to pmin.
po = min(min(abs(Z - pmin)));

plot(X(:, 1), X(:, 2),'bx');
hold on;
plot(X(outliers, 1), X(outliers, 2), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
contour(X1, X2, Z, [pmin+po,pmin-po], '+g')
hold off;
