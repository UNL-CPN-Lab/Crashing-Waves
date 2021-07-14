clc;
clear all;
close all;

format long g;

pl0_up = [78.194406 83.151873 92.727434 95.148201 91.269844 92.036073 92.633742 94.974403 94.752296 97.130189 ];

pl3_up = [78.30068 84.090198 92.249419 94.670873 90.822882 91.266166 92.725089 93.6535 95.68956 95.390803 ];

pl6_up = [101.400482 101.659808 108.226443 107.945192 101.412804 101.167556 NaN 104.438579 109.623122 111.227307 ];
 
pl10_up = [67.225393 72.049906 80.67961 83.143528 79.029001 79.374113 80.499836 82.653415 86.219355 85.149293 ];

pl20_up = [74.597603 79.664376 85.729789 88.751158 92.253331 82.826638 81.749407 82.314713 80.020602 85.598754 ];

pl30_up = [73.379555 78.345207 88.346707 90.040568 84.437683 79.162685 84.669039 82.625242 82.44212 83.485283 ];

pl60_up = [69.770377 74.994504 78.553752 80.847456 83.883079 79.554722 85.992416 87.591139 88.680772 NaN ];

pl90_up = [77.393116 81.351571 NaN 83.131098 NaN 83.372391 85.374736 NaN NaN NaN ];

PL = pl0_up;

d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];

pl6_up = fit_nan(d_range,pl6_up);
pl60_up = fit_nan(d_range,pl60_up);
pl90_up = fit_nan(d_range,pl90_up);

pl_upper_all = [pl0_up; pl3_up; pl6_up; pl10_up; pl20_up; pl30_up; pl60_up; pl90_up];

PL_ref = PL(1);
d_ref = d_range(1);

P = polyfit(10*log10(d_range),PL,1);

% n = linspace(1,3,1000);
% 
% PL_calc = zeros(length(d_range),length(n));
% 
% %constant = 20*log10(5.8e3)+32.44;
% 
% for i = 1:length(d_range)
%      PL_calc(i,:) = PL_ref+n.*(10*log10(d_range(i)./d_ref));
% end
% 
% error = zeros(1,length(n));
% 
% for i = 1:length(n)
%    error(i) = immse(PL',PL_calc(:,i)); 
% end
% 
% [val, index] = min(error);

n_high = P(1);

theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);



K_0 = pl0_up-pl0_up;
K_3 = pl3_up-pl0_up;
K_6 = pl6_up-pl0_up;
K_10 = pl10_up-pl0_up;
K_20 = pl20_up-pl0_up;
K_30 = pl30_up-pl0_up;
K_60 = pl60_up-pl0_up;
K_90 = pl90_up-pl0_up;

V_high = [K_0; K_3; K_6; K_10; K_20; K_30; K_60; K_90];

%save pathloss_data_high.mat V_high n_high

pl0_up_car = [96.524509 97.282307 NaN 105.717223 103.547343 103.200398 104.566055 108.408418 107.65402 109.936815];

pl3_up_car = [103.207488 103.994745 NaN 110.079283 109.435208 107.695236 108.745366 112.065482 NaN 108.167587];

pl6_up_car = [107.610391 109.42297 NaN 109.429239 111.143883 111.042187 110.548569 NaN NaN NaN];

pl10_up_car = [NaN NaN NaN NaN 101.015396 102.102724 100.856245 NaN NaN NaN];

pl20_up_car = [NaN NaN NaN NaN 96.436456 NaN NaN NaN NaN NaN];

pl30_up_car = [95.000755 NaN NaN NaN NaN NaN NaN NaN NaN NaN];

pl60_up_car = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];

pl90_up_car = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];

% pl0_up_car_updated = [96.524509 97.282307 102.551369132102 105.717223 103.547343 103.200398 104.566055 108.408418 107.65402 109.936815];
% 
% pl3_up_car_updated = [103.207488 103.994745 107.45043104015 110.079283 109.435208 107.695236 108.745366 112.065482 113.478133674117 108.167587];
% 
% pl6_up_car_updated = [107.610391 109.42297 109.197686943925 109.429239 111.143883 111.042187 110.548569 112.638386950099 120.275529280374 136.441088700935];
% 
% pl10_up_car_updated = [73.3280140000001 83.75057 91.839319 97.594261 101.015396 102.102724 100.856245 97.2728435438421 91.361866 83.1139660000001];
% 
% pl20_up_car_updated = [-524.294600444443 -407.735730333334 -175.671294980919 -13.7934421111106 96.436456 -85.9961850000005 -55.2611650000001 -118.108703731581 -506.478817390239 -1676.27467609971];
% 
% pl30_up_car_updated = [95.000755 -2039.584494 -1016.8068972887 -296.409738714283 317.58278157971 -710.020521857146 -543.795317857142 -780.56127944266 -2532.10056314312 -8120.19182685324];
% 
% pl60_up_car_updated = [36758.4355563403 -20401.384565 -10150.2278789534 -2851.26871328569 4786.54135904347 -7686.88802814292 -5803.98966214284 -7878.59573335372 -25637.9775043017 -85078.7414865781];
% 
% pl90_up_car_updated = [183388.679383106 -72873.1312060001 -35852.0250367685 -9393.88371499993 20111.2321528116 -27548.3553280003 -20536.2638349999 -27741.9714453757 -92058.2551937308 -310468.705484136];

pl0_up_car_updated =  fit_nan(d_range,pl0_up_car);

pl3_up_car_updated =  fit_nan(d_range,pl3_up_car);

pl6_up_car_updated =  fit_nan(d_range,pl6_up_car);

pl10_up_car_updated =  fit_nan(d_range,pl10_up_car);
pl20_up_car_updated = pl10_up_car_updated + 10; 
pl20_up_car_updated(5) = 96.436456;
pl30_up_car_updated=  pl20_up_car_updated;
pl30_up_car_updated(1) = 95.000755;
pl60_up_car_updated = pl30_up_car_updated;
pl90_up_car_updated = pl60_up_car_updated + 8;

exp0 = pathloss_exp(pl0_up_car_updated,d_range);
exp3 = pathloss_exp(pl3_up_car_updated,d_range);
exp6 = pathloss_exp(pl6_up_car_updated,d_range);
exp10 = pathloss_exp(pl10_up_car_updated,d_range);
exp20 = pathloss_exp(pl20_up_car_updated,d_range);
exp30 = pathloss_exp(pl30_up_car_updated,d_range);
exp60 = pathloss_exp(pl60_up_car_updated,d_range);
exp90 = pathloss_exp(pl90_up_car_updated,d_range);

exps = [exp0; exp3; exp6; exp10; exp20; exp30; exp60; exp90];

C_0 = pl0_up-pl0_up_car_updated;
C_3 = pl3_up-pl3_up_car_updated;
C_6 = pl6_up-pl6_up_car_updated;
C_10 = pl10_up-pl10_up_car_updated;
C_20 = pl20_up-pl20_up_car_updated;
C_30 = pl30_up-pl30_up_car_updated;
C_60 = pl60_up-pl60_up_car_updated;
C_90 = pl90_up-pl90_up_car_updated;

C_high = [C_0; C_3; C_6; C_10; C_20; C_30; C_60; C_90];

d_i = linspace(1e-3,400,100);
theta_i = linspace(0,pi/2,100);
[d_o , theta_o] = organize_vector(d_i,theta_i);
d_o = reshape(d_o,length(d_i),[]);
theta_o = reshape(theta_o,length(theta_i),[]);
K = interp2(d_range,theta,V_high,d_o,theta_o,'spline');
C =  interp2(d_range,theta,C_high,d_o,theta_o,'spline');

% [curve, goodness, output] = fit(theta',exps,'smoothingspline');
% exp_ref =  curve(theta_i);


% alpha = linspace(0.01,1,100);
% beta = linspace(0.01,1,100);
% 
% e = zeros(length(alpha),length(beta));
% exponents = zeros(length(alpha), length(beta),length(theta_i));
% for i = 1:length(alpha)
%     for j = 1:length(beta)
%         PL = (pl0_up_car(1) + 10*n_high*log10(d_o./d_ref)) + alpha(i)*K - beta(j)*C;
%         
%         for k = 1:length(theta_i)
%             exponents(i,j,k) = pathloss_exp(PL(k,:),d_i);
%         end
%         exp_idx =  exponents(i,j,:) ;
%         exp_idx = exp_idx(:);
%         e(i,j) = rms(exp_ref-exp_idx);
%     end
% end
% 
% [value, index] = min(e(:));
% [row, col] = ind2sub(size(e), index);
% row
% col
% alpha(row)
% beta(col)
% save /work/vuran/mlunar/MATLAB/Pathloss_Exponent/pathloss_up.mat exponents e row col
% 
% 
% 
% 
