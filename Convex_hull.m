%% Instruction
%  Compute the convex hull of X (a set of 2D discrete points).
%
%  This convex hull is a subset of X which contains the smallest
%  number of points and ignores the points on the same line and 
%  the points that are too close to another point.
%
%  The sequence of the points in K is counter-clockwise.
%
%
%% Test sets
Num = 20;
Points = 10*rand(Num,2);
K = convexhull(Points);

figure
subplot(1,2,1)
scatter(Points(:,1),Points(:,2))
xlim([-1 11])
ylim([-1 11])

subplot(1,2,2)
scatter(K(:,1), K(:,2))
xlim([-1 11])
ylim([-1 11])

%% Main function
function K = convexhull(X)

% Input:  X, a N-by-2 matrix where each row is a 2D point.
% Output: K, the smallest convex subset of X.

% sort X from left to right, if there are more than one leftmost
% points, we start from the bottom one
  [~,idx] = sort(X(:,2));
  X = X(idx,:);
  [~,idx] = sort(X(:,1));
  X = X(idx,:);

% initialize parameters
% the bottom-left point must be in the convex hull
% u is the initial normal vector
  p = X(1,:); K = p; u = [0, -1]; N = size(X,1);

%% ========== Part 1 ==========
% scan all points
  while true
      % initialize v (vector) and w (cosine of angle)
      v = [0,0]; w = -1;
      % iterate through all the other points
      for i = 1:N
          q = X(i,:); s = q - p; w1 = u*s'/norm(u)/norm(s);
          % if the angle between (q - p) and the normal vector
          % is smaller, then update the candidate point
          if w1 > w
              v = s; w = w1;
          % if the angle is equal, then choose the further point
          elseif w1 == w && norm(s) > norm(v)
              v = s;
          end
      end
      % update convex hull and normal vector
      p = p + v; u = v/norm(v);
      % return if K is closed, i.e. iteration has come back to the first point
      if norm(p - K(1,:)) < 1e-8
          break
      else
          K = [K;p];
      end
  end

%% ========== Part 2 ==========
% r is the smallest point-to-point distance in the convex hull
% idx are the points to be deleted
  idx = []; r = norm(K(1,:) - K(end,:));

% scan through the convex hull
  for i = 1:size(K,1) - 1
      d = norm(K(i,:) - K(i + 1,:));
      % delete the points that are too close to another point
      if d < 1e-5
          idx = [idx;i];
      % update the smallest distance
      elseif d < r
          r = d;
      end
  end  
  K(idx,:) = [];  
end
