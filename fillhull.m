%FILLHULL  Fill the convex hull with normaly distributed dots and the gap
%          between any two consecutive points equals the value of r.
%

function K = fillhull(X,r)

% initial params
  K = X; N = size(X,1);

% scan all edges
  for i = 1:N
      % assign
      p = X(i,:);
      if i == N
          q = X(1,:);
      else
          q = X(i + 1,:);
      end
      % compute the amount of dots
      s = q - p;
      n = floor(norm(s)/r) - 1;
      % fill dots
      if n > 0
          for j = 1:n
              s = s/norm(s);
              K = [K;p + j*r*s];
          end
      end
  end