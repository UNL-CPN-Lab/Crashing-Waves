clc;
clear all;
close all;

load KV_model_up.mat

format long g;

%tic

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


n_high = P(1);

theta_range = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);



K_0 = pl0_up-pl0_up;
K_3 = pl3_up-pl0_up;
K_6 = pl6_up-pl0_up;
K_10 = pl10_up-pl0_up;
K_20 = pl20_up-pl0_up;
K_30 = pl30_up-pl0_up;
K_60 = pl60_up-pl0_up;
K_90 = pl90_up-pl0_up;

K = [K_0; K_3; K_6; K_10; K_20; K_30; K_60; K_90];

pl0_up_car = [96.524509 97.282307 NaN 105.717223 103.547343 103.200398 104.566055 108.408418 107.65402 109.936815];

pl3_up_car = [103.207488 103.994745 NaN 110.079283 109.435208 107.695236 108.745366 112.065482 NaN 108.167587];

pl6_up_car = [107.610391 109.42297 NaN 109.429239 111.143883 111.042187 110.548569 NaN NaN NaN];

pl10_up_car = [NaN NaN NaN NaN 101.015396 102.102724 100.856245 NaN NaN NaN];

pl20_up_car = [NaN NaN NaN NaN 96.436456 NaN NaN NaN NaN NaN];

pl30_up_car = [95.000755 NaN NaN NaN NaN NaN NaN NaN NaN NaN];

pl60_up_car = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];

pl90_up_car = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];

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

PL_E = [pl0_up_car_updated; pl3_up_car_updated; pl6_up_car_updated; pl10_up_car_updated; ...
    pl20_up_car_updated; pl30_up_car_updated; pl60_up_car_updated; pl90_up_car_updated];

PL = PL_E(1,1) + 10*n_high*log10(d_range./d_ref);
PL_T = repmat(PL,8,1);

V_0 = pl0_up-pl0_up_car_updated;
V_3 = pl3_up-pl3_up_car_updated;
V_6 = pl6_up-pl6_up_car_updated;
V_10 = pl10_up-pl10_up_car_updated;
V_20 = pl20_up-pl20_up_car_updated;
V_30 = pl30_up-pl30_up_car_updated;
V_60 = pl60_up-pl60_up_car_updated;
V_90 = pl90_up-pl90_up_car_updated;

V = [V_0; V_3; V_6; V_10; V_20; V_30; V_60; V_90];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[d, theta] = organize_vector(d_range, theta_range);

K = predict(mdl_angle_up,[log10(d), theta]) ;
K = reshape(K,8,10);
V = predict(mdl_vehicle_up,[log10(d), theta]) ;
V = reshape(V,8,10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N_d = 10;
N_theta = 8;

a11 = sum(sum(K.^2));
a12 = sum(sum(K.*V));
a13 = sum(sum(K));
b1 = sum(sum(PL_E.*K)) - sum(sum(PL_T.*K));

a21 = sum(sum(K.*V));
a22 = sum(sum(V.^2));
a23 = sum(sum(V));
b2 = sum(sum(PL_E.*V)) - sum(sum(PL_T.*V));

a31 = sum(sum(K));
a32 = sum(sum(V));
a33 = N_d * N_theta;
b3 = sum(sum(PL_E)) - sum(sum(PL_T));

A = [a11, a12, a13; a21, a22, a23; a31, a32, a33];
b = [b1; b2; b3];

W = A\b

E = mean(mean((PL_E - PL_T - W(1).*K - W(2).*V - W(3)).^2));

