function y = closest_value(x,v)
    A = [x (1:length(x))'];
    A = sortrows(A);
    m = min(find(A(:,1) >= v));
    y = A(m,2);
end