function [p, q] = organize_vector(x,y)
    m = length(x);
    n = length(y);
    q = repmat(y(:),m,1);
    p = repmat(x,n,1);
    p = p(:);
end

% [p, q, r] =  organize_matrix(d_range,theta(1:6),z);
% 
% sf= fit([p,q],r,'poly34') ;