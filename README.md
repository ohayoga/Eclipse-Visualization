# Eclipse-Visualization

This algorithm is aimed to find the smallest eclipse that incorporates a set of discrete 2D points. First compute the convex hull of the point set and then probability of each point in the convex hull; estimate parameters of Multivariate Gaussian Distribution with the smallest probability to plot the probability contour, which is the smallest eclipse.

### Multivariate Gaussian
Compute the probability density function
### Convex Hull
Compute the convex hull of a set of discrete 2D points.
### Fill Hull
Fill the convex hull with uniformly distributed points.
### Generate Random Data
See Random_Data.m and Large-Scale.m
### VisualizeFit
Visualize the dataset and its estimated distribution

## Final Step: Eclipse Visualization
1. Apply anomaly detection and exclude outliers.
2. Detect convex hull and delete insiders.
3. Fill the edges with uniformly distributed points.
4. Estimate Mean and Covariance matrix of the remaining points.
5. Draw the probability contour with the smallest probability.
6. Compute the parameters of the ellipse.
