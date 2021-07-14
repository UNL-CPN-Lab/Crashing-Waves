function y = distance_down(d)    
    beta = zeros(size(d));
    idx = find(d<=50);
    beta(idx) = 0.464;
    idx = find(d<=300 & d > 50);
    beta(idx) = -0.602;
    y = beta;
end