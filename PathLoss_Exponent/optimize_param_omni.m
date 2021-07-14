function y = optimize_param_omni(d_range, theta, pl0, d_i, C_high, n_high, res)

    beta = linspace(-1,1,2*res+1);

    e = zeros(1,length(beta));
    
    PL_ref = pl0(1);
    d_ref = d_range(1);


    [curve, goodness, output] = fit(d_range',pl0','smoothingspline');

    PL0 =  curve(d_i);

  
    C =  interp2(d_range,theta,C_high,d_i,theta(1),'spline');



    for j = 1:length(beta)
        PL = (PL_ref + 10*n_high*log10(d_i./d_ref)) - beta(j)*C ;
        e(j) = rms(PL0'-PL);
    end

%plot(e);


    [min_val,idx]=min(e);
    
    %min_val

    y = beta(idx);

end