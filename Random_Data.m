%% Random Data
%  Instructions
%  ------------
%
%  We do ellipse visualization on random dots.
%

%% Initialization
clear ; close all; clc

%% ================== Part 1: Load Example Dataset  ===================
%  We create 2-D dataset randomly with N dots.
%

fprintf('Visualizing example dataset.\n');

%  N should not be large in order to keep shape variable
N = 10;
X = [20*rand(N,1).*cos(2*pi*rand(N,1)),20*rand(N,1).*sin(2*pi*rand(N,1))];

%  Visualize the example dataset
plot(X(:, 1), X(:, 2), 'bx');
xlim([-30 30])
ylim([-30 30])

fprintf('Program paused. Press enter to continue.\n\n');
pause


%% ================== Part 2: Estimate the dataset statistics ===================
%

fprintf('Estimate statistics.\n\n');

%  Estimate mean and covariance
mu = mean(X)';
Cov = cov(X);

%  Returns the density of the multivariate normal at each data point (row) 
%  of X
p = multivariateGaussian(X, mu, Cov);

%  Epsilon can be replaced by any reliable value.
epsilon = 1e-5;

%  Find the outliers in the training set and plot the
outliers = find(p < epsilon);

%  Exclude outliers
Xre = X;
Xre(outliers, :) = [];

%  Returns the convex hull and gap
[Xre,r] = convexhull(Xre);

%  Fill the convex hull
Xre = fillhull(Xre,r);

%  Re-Estimate mean and covariance
mu = mean(Xre)';
Cov = cov(Xre);

%  Returns the density of the multivariate normal at each data point (row) 
%  of X
p = multivariateGaussian(Xre, mu, Cov);


%% ================== Part 3: Ellipse contour ===================
%  We find the point with the lowest probability and draw a contour of the
%  assumed Gaussian distribution respecting to that value.
%

fprintf('Drawing Ellipse Contour.\n');

%  Find the lowest probability
pmin = min(p);

%  Set mesh for drawing contour.
[X1,X2] = meshgrid(-30:.1:30); 
Z = multivariateGaussian([X1(:) X2(:)],mu,Cov);
Z = reshape(Z,size(X1));

%  Find value of Z that is closest to pmin.
po = min(min(abs(Z - pmin)));

plot(X(:, 1), X(:, 2),'bx');
hold on;
plot(X(outliers, 1), X(outliers, 2), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
contour(X1, X2, Z, [pmin+po,pmin-po], '+g')
hold off;