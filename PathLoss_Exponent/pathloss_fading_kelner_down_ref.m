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
% n = linspace(1,3,1000);
% 
% 
% 
% PL_calc = zeros(length(d_range),length(n));
% 
% constant = 20*log10(5.8e3)+32.44;
% 
% for i = 1:length(d_range)
%     PL_calc(i,:) = PL_ref+n.*(10*log10(d_range(i)./d_ref));
% end
% 
% error = zeros(1,length(n));
% 
% for i = 1:length(n)
%    error(i) = immse(PL',PL_calc(:,i)); 
% end
% 
% [val, index] = min(error);
% 
% n_low = n(index);
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

% pl0_car_updated = [91.861826 96.272886 96.153989 99.677923 102.990024 103.294122 105.614433 116.791261565007 143.618012428571 192.958440071429];
% 
% pl3_car_updated = [105.765696 105.808566 105.851436 105.894306 105.937176 105.980046 106.022916 106.065814129921 106.108655999999 106.151525999998];
% 
% pl6_car_updated = [102.869126 105.787761 106.886257 107.897699 106.098617 107.91713 122.5188844 159.102722472969 226.734703 334.68006];
% 
% pl10_car_updated = [99.104249 100.853976 102.603703 104.35343 106.103157 107.852884 109.602611 111.353486114829 113.102065 114.851792];
% 
% pl20_car_updated = [107.680479 107.684314 107.688149 107.691984 107.695819 107.699654 107.703489 107.707326516404 107.711159 107.714994 ];
% 
% pl30_car_updated = [105.792217 105.2657 219.386841521739 224.595425795031 109.757278598344 139.929345014493 719.167100737061 2258.16921168574 5161.98174063977 9844.12965508907 ];
% 
% pl60_car_updated = [-447.009635503546 -556.960467085106 2244.86735473913 2458.41284503105 96.3766986770251 835.570581826095 13358.0620547267 46494.0013508093 108951.911560466 209622.756488647];
% 
% pl90_car_updated = [-2837.65232821986 -3460.5430092766 9012.39233013043 10040.498215913 6.65541763770833 3279.41480342033 57164.8013912321 199612.079466875 468047.731705698 900682.413198728];

pl0_car_updated =  fit_nan(d_range,pl0_car);

pl3_car_updated =  fit_nan(d_range,pl3_car);

pl6_car_updated =  fit_nan(d_range,pl6_car);

pl10_car_updated =  fit_nan(d_range,pl10_car);

pl20_car_updated =  fit_nan(d_range,pl20_car);

pl30_car_updated =  fit_nan(d_range,pl30_car);

z = [pl0_car_updated; pl3_car_updated; pl6_car_updated; pl10_car_updated; pl20_car_updated; pl30_car_updated];

% x = fit_nan(theta, [z(:,10)', NaN, NaN]);
% x(end-1:end)

% pl60_car_updated = [173.672761297162  162.209301314837  148.776674095584 136.779440996854 124.429769949378 111.233564363192 98.7150377185848 85.6980286889383 71.8633158907105 56.4905647365502 ];
% 
% pl90_car_updated = [717.943451912746 634.808640470339 535.545015002757 448.571969274792 359.650238274248 262.133749663394 170.884038973272 76.2079009365094 -23.6307473365035 -133.827851089181];
% 

pl60_car_updated = pl30_car_updated;
pl90_car_updated = pl60_car_updated + 8;

C_0 = pl0-pl0_car_updated;
C_3 = pl3-pl3_car_updated;
C_6 = pl6-pl6_car_updated;
C_10 = pl10-pl10_car_updated;
C_20 = pl20-pl20_car_updated;
C_30 = pl30-pl30_car_updated;
C_60 = pl60-pl60_car_updated;
C_90 = pl90-pl90_car_updated;

C_low = [C_0; C_3; C_6; C_10; C_20; C_30; C_60; C_90];

% [x, y, z] =  organize_matrix(d_range,theta,C_low);
% 
% sf = fit([x, y],z,'poly23');
% plot(sf,[x,y],z)
pl_down_car_updated = [pl0_car_updated; pl3_car_updated; pl6_car_updated; pl10_car_updated; ...
    pl20_car_updated; pl30_car_updated; pl60_car_updated; pl90_car_updated];
e = zeros(size(theta));
for i = 1:length(theta)-2
    n_i = pathloss_exp(pl_down_car_updated(i,:),d_range);
    PL = pl_down_car_updated(i,1) + 10.*n_i.*log10(d_range./d_ref);
    e(i) =  std(pl_down_car_updated(i,:) -PL);
end

sdev = mean(e);


save pathloss_data_low_ref.mat V_low n_low C_low sdev

