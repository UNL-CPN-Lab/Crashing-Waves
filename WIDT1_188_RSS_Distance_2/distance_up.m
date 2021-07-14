function [y1, y2] = distance_up(d)    
    alpha = zeros(size(d));
    beta = zeros(size(d));
    idx = find(d<=304.8);
    alpha(idx) = 0.13;
    beta(idx) = 0.16;
    idx = find(d> 304.8);
    alpha(idx) = 0.01;
    beta(idx) = -0.03;
    y1 = alpha;
    y2 = beta;
end