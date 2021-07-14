function [y1, y2] = distance_down(d)    
    alpha = zeros(size(d));
    beta = zeros(size(d));
    idx = find(d<=50);
    alpha(idx) = 0.56;
    beta(idx) = 0.57;
    idx = find(d<=300 & d > 50);
    alpha(idx) = 0.67;
    beta(idx) = 0.4;
    idx = find(d> 300);
    alpha(idx) = 0.17;
    beta(idx) = 0.16;
    y1 = alpha;
    y2 = beta;
end