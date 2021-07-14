clc;
clear all;
close all;

pl0 = [83.883347 93.755752 89.114896 91.279586 95.137187 99.222277 100.083587 100.92033 103.324519 106.982946];

pl3 = [81.38925 91.923683 86.689068 89.521814 91.528818 94.216237 97.004512 98.248759 100.90061 103.047785 ];

pl6 = [83.069998 91.936461 88.26183 90.941494 93.00588 94.878452 98.996018 102.390701 103.006895 102.502726 ];

pl10 = [68.004496 74.755129 72.62803 75.1144 77.755523 79.534372 81.909683 83.676011 87.438081 87.733666 ];

pl20 = [91.397397 92.030279 89.539602 92.108345 85.691128 NaN 91.19302 89.283853 85.313157 82.733666 ];

pl30 = [79.186323 88.742653 88.232888 92.119293 92.43489 94.255463 86.477278 83.278166 83.938657 91.698762 ];

pl60 = [72.172319 82.672522 79.629036 69.254227 74.499488 87.656682 NaN 82.117396 86.780197 87.521124 ];

pl90 = [74.689366 82.253528 80.482842 86.047937 85.285552 86.169595 85.307491 NaN NaN NaN ];
  
%pl_lower_all = [pl0; pl3; pl6; pl10; pl20; pl30; pl60; pl90];

d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];

pl20 = fit_nan(d_range,pl20);
pl30 = fit_nan(d_range,pl30);
pl60 = fit_nan(d_range,pl60);
pl90 = fit_nan(d_range,pl90);

PL = pl0;

PL_ref = PL(1);
d_ref = d_range(1);
P = polyfit(10*log10(d_range),PL,1);

n_low = P(1);
theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);

K_0 = pl0-pl0;
K_3 = pl3-pl0;
K_6 = pl6-pl0;
K_10 = pl10-pl0;
K_20 = pl20-pl0;
K_30 = pl30-pl0;
K_60 = pl60-pl0;
K_90 = pl90-pl0;

V_low = [K_0; K_3; K_6; K_10; K_20; K_30; K_60; K_90];



% d_q = linspace(0,400,10000);
% theta_q = linspace(0,90,1000).*(pi/180);
% 
% 
% Vq = interp2(d_range,theta,V_low,d_q,theta_q','spline');
% Vq =Vq';

% interp2(d_range,theta,V_low,d_q(1250),theta_q(329),'spline')
% Vq(1250,329)

pl0_car = [91.861826 96.272886 96.153989 99.677923 102.990024 103.294122 105.614433 NaN NaN NaN];

pl3_car = [105.765696 105.808566 NaN NaN NaN NaN NaN NaN NaN NaN];

pl6_car = [102.869126 105.787761 106.886257 107.897699 106.098617 107.91713 NaN NaN NaN NaN];

pl10_car = [NaN NaN NaN 104.35343 106.103157 NaN NaN NaN NaN NaN];

pl20_car = [107.680479 107.684314 NaN NaN NaN NaN NaN NaN NaN NaN ];

pl30_car = [105.792217 105.2657 NaN NaN NaN NaN NaN NaN NaN NaN ];

pl60_car = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];

pl90_car = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];



pl0_car_updated =  fit_nan(d_range,pl0_car);

pl3_car_updated =  fit_nan(d_range,pl3_car);

pl6_car_updated =  fit_nan(d_range,pl6_car);

pl10_car_updated =  fit_nan(d_range,pl10_car);

pl20_car_updated =  fit_nan(d_range,pl20_car);

pl30_car_updated =  fit_nan(d_range,pl30_car);

pl60_car_updated = pl30_car_updated;
pl90_car_updated = pl60_car_updated + 8;

pl_down_car_updated = [pl0_car_updated; pl3_car_updated; pl6_car_updated; pl10_car_updated; ...
    pl20_car_updated; pl30_car_updated; pl60_car_updated; pl90_car_updated];


C_0 = pl0-pl0_car_updated;
C_3 = pl3-pl3_car_updated;
C_6 = pl6-pl6_car_updated;
C_10 = pl10-pl10_car_updated;
C_20 = pl20-pl20_car_updated;
C_30 = pl30-pl30_car_updated;
C_60 = pl60-pl60_car_updated;
C_90 = pl90-pl90_car_updated;

C_low = [C_0; C_3; C_6; C_10; C_20; C_30; C_60; C_90];

d_i = linspace(1e-3,250,100);
theta_i = linspace(0,pi/2,100);
[d_o , theta_o] = organize_vector(d_i,theta_i);
d_o = reshape(d_o,length(d_i),[]);
theta_o = reshape(theta_o,length(theta_i),[]);
% K = interp2(d_range,theta,V_high,d_o,theta_o,'spline');
% C =  interp2(d_range,theta,C_high,d_o,theta_o,'spline');

% e = zeros(size(theta));
% for i = 1:length(theta)
%     n_i = pathloss_exp(pl_down_car_updated(i,:),d_range);
%     PL = pl_down_car_updated(i,1) + 10.*n_i.*log10(d_range./d_ref);
%     e(i) =  std(pl_down_car_updated(i,:) -PL);
% end
% 
% mean(e)

res = 100;

[alpha, beta] = optimize_param(d_range, theta, pl_down_car_updated, d_i, V_low, C_low, n_low, res)

beta = optimize_param_omni(d_range, theta, pl0_car_updated, d_i, C_low, n_low, res)

%surf(alpha,beta,e)
%overall
% 1, 0.63
% 0.307, 0.297
%d <= 50
%0.56, 0.57
% 50< d <300
% 0.67, 0.4; 0.13, 0.16
% d > 300
% 0.17, 0.16

%omni
% 0.464, -0.602