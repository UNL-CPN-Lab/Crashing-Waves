function [y1, y2] = optimize_param(d_range, theta, pl_up_car_updated, d_i, V_high, C_high, n_high, res)

%     alpha = linspace(1/res,1,res);
%     beta = linspace(1/res,1,res);
    alpha = linspace(-1,1,2*res+1);
    beta = linspace(-1,1,2*res+1);

    e = zeros(length(alpha),length(beta));
    
    PL_ref = pl_up_car_updated(1,1);
    d_ref = d_range(1);


    for k=1:length(theta)

        [curve, goodness, output] = fit(d_range',pl_up_car_updated(k,:)','smoothingspline');

        PL0 =  curve(d_i);

        K = interp2(d_range,theta,V_high,d_i,theta(k),'spline');
        C =  interp2(d_range,theta,C_high,d_i,theta(k),'spline');


        for i = 1:length(alpha)
            for j = 1:length(beta)
                PL = (PL_ref + 10*n_high*log10(d_i./d_ref)) + alpha(i)*K - beta(j)*C;
                e(i,j) = e(i,j) + rms(PL0'-PL);
            end
        end



    end
    [min_val,idx]=min(e(:));
    %min_val
    [row,col]=ind2sub(size(e),idx);
    y1 = alpha(row);
    y2 = beta(col);

end