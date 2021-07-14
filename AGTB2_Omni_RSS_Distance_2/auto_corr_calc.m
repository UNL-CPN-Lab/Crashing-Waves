function y = auto_corr_calc(p,q)
    y = mean(p.*conj(q));
end