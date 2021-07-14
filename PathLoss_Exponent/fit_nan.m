function y = fit_nan(d_range, pl20)



[curve, goodness, output] = fit(d_range',pl20','smoothingspline','Exclude', isnan(pl20));

nan_idx = find(isnan(pl20));

pl20(nan_idx) = curve(d_range(nan_idx));

y = pl20;

end