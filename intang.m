% INTERSECTION ANGLE  theta = arccos(a*b/|a|*|b|).

  function theta = intang(a,b)

  theta = acos(a*b'/norm(a)/norm(b));