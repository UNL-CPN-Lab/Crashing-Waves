function [p,q,r] = structure_matrix(x,y,z)
    n = sqrt(length(x));
    x = x(1:n:end);
    y = y(1:n);
    r = reshape(z,n,n);
    p = repmat(x',n,1);
    q = repmat(y,1,n);
end