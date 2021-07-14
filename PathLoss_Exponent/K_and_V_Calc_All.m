clc
clear all
close all

pl0_up = [78.194406 83.151873 92.727434 95.148201 91.269844 92.036073 92.633742 94.974403 94.752296 97.130189 ];

pl3_up = [78.30068 84.090198 92.249419 94.670873 90.822882 91.266166 92.725089 93.6535 95.68956 95.390803 ];

pl6_up = [101.400482 101.659808 108.226443 107.945192 101.412804 101.167556 NaN 104.438579 109.623122 111.227307 ];
 
pl10_up = [67.225393 72.049906 80.67961 83.143528 79.029001 79.374113 80.499836 82.653415 86.219355 85.149293 ];

pl20_up = [74.597603 79.664376 85.729789 88.751158 92.253331 82.826638 81.749407 82.314713 80.020602 85.598754 ];

pl30_up = [73.379555 78.345207 88.346707 90.040568 84.437683 79.162685 84.669039 82.625242 82.44212 83.485283 ];

pl60_up = [69.770377 74.994504 78.553752 80.847456 83.883079 79.554722 85.992416 87.591139 88.680772 NaN ];

pl90_up = [77.393116 81.351571 NaN 83.131098 NaN 83.372391 85.374736 NaN NaN NaN ];


pl0_up_car = [96.524509 97.282307 NaN 105.717223 103.547343 103.200398 104.566055 108.408418 107.65402 109.936815];

pl3_up_car = [103.207488 103.994745 NaN 110.079283 109.435208 107.695236 108.745366 112.065482 NaN 108.167587];

pl6_up_car = [107.610391 109.42297 NaN 109.429239 111.143883 111.042187 110.548569 NaN NaN NaN];

pl10_up_car = [NaN NaN NaN NaN 101.015396 102.102724 100.856245 NaN NaN NaN];

pl20_up_car = [NaN NaN NaN NaN 96.436456 NaN NaN NaN NaN NaN];

pl30_up_car = [95.000755 NaN NaN NaN NaN NaN NaN NaN NaN NaN];

pl60_up_car = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];

pl90_up_car = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];

PL_E_Up = [pl0_up_car; pl3_up_car; pl6_up_car; pl10_up_car; pl20_up_car; pl30_up_car; pl60_up_car; pl90_up_car];
    
pl0 = [83.883347 93.755752 89.114896 91.279586 95.137187 99.222277 100.083587 100.92033 103.324519 106.982946];

pl3 = [81.38925 91.923683 86.689068 89.521814 91.528818 94.216237 97.004512 98.248759 100.90061 103.047785 ];

pl6 = [83.069998 91.936461 88.26183 90.941494 93.00588 94.878452 98.996018 102.390701 103.006895 102.502726 ];

pl10 = [68.004496 74.755129 72.62803 75.1144 77.755523 79.534372 81.909683 83.676011 87.438081 87.733666 ];

pl20 = [91.397397 92.030279 89.539602 92.108345 85.691128 NaN 91.19302 89.283853 85.313157 82.733666 ];

pl30 = [79.186323 88.742653 88.232888 92.119293 92.43489 94.255463 86.477278 83.278166 83.938657 91.698762 ];

pl60 = [72.172319 82.672522 79.629036 69.254227 74.499488 87.656682 NaN 82.117396 86.780197 87.521124 ];

pl90 = [74.689366 82.253528 80.482842 86.047937 85.285552 86.169595 85.307491 NaN NaN NaN ];


pl0_car = [91.861826 96.272886 96.153989 99.677923 102.990024 103.294122 105.614433 NaN NaN NaN];

pl3_car = [105.765696 105.808566 NaN NaN NaN NaN NaN NaN NaN NaN];

pl6_car = [102.869126 105.787761 106.886257 107.897699 106.098617 107.91713 NaN NaN NaN NaN];

pl10_car = [NaN NaN NaN 104.35343 106.103157 NaN NaN NaN NaN NaN];

pl20_car = [107.680479 107.684314 NaN NaN NaN NaN NaN NaN NaN NaN ];

pl30_car = [105.792217 105.2657 NaN NaN NaN NaN NaN NaN NaN NaN ];

pl60_car = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];

pl90_car = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];

hV = 1.45.*ones(160,1);

PL_E_Down = [pl0_car; pl3_car; pl6_car; pl10_car; pl20_car; pl30_car; pl60_car; pl90_car];

PL_E = [PL_E_Up; PL_E_Down];


C = zeros(size(PL_E));
C(isnan(PL_E)) = NaN;

K0 = pl0_up -pl0_up;
K3 = pl3_up -pl0_up;
K6 = pl6_up -pl0_up;
K10 = pl10_up -pl0_up;
K20 = pl20_up -pl0_up;
K30 = pl30_up -pl0_up;
K60 = pl60_up -pl0_up;
K90 = pl90_up -pl0_up;

K_high = [K0; K3; K6; K10; K20; K30; K60; K90];

V0 = pl0_up -pl0_up_car;
V3 = pl3_up -pl3_up_car;
V6 = pl6_up -pl6_up_car;
V10 = pl10_up -pl10_up_car;
V20 = pl20_up -pl20_up_car;
V30 = pl30_up -pl30_up_car;
V60 = pl60_up -pl60_up_car;
V90 = pl90_up -pl90_up_car;

V_high = [V0; V3; V6; V10; V20; V30; V60; V90];

K0 = pl0 -pl0;
K3 = pl3 -pl0;
K6 = pl6 -pl0;
K10 = pl10 -pl0;
K20 = pl20 -pl0;
K30 = pl30 -pl0;
K60 = pl60 -pl0;
K90 = pl90 -pl0;

K_low = [K0; K3; K6; K10; K20; K30; K60; K90];

V0 = pl0 -pl0_car;
V3 = pl3 -pl3_car;
V6 = pl6 -pl6_car;
V10 = pl10 -pl10_car;
V20 = pl20 -pl20_car;
V30 = pl30 -pl30_car;
V60 = pl60 -pl60_car;
V90 = pl90 -pl90_car;

V_low = [V0; V3; V6; V10; V20; V30; V60; V90];

K = [K_high; K_low];

V = [V_high; V_low];



d_range = 30.48.*(1:10);

d_range_comb = [d_range, d_range];

theta_range = [0 3 6 10 20 30 60 90].*(pi/180);

%theta_range = [theta_range, theta_range];

[d_fit, theta_fit, K_fit] = organize_matrix(d_range_comb, theta_range, K);

h_fit = ones(size(d_fit));

h_fit(1:length(d_fit)/2) = 1.45;

h_fit(length(d_fit)/2+1:end) = 0.8;


X = [log10(d_fit) (theta_fit) log10(h_fit) log10(hV) ];

p = zeros(3,1);
r = p;
p(1) = 1;
q = (0:1:2)';

T = [p q r];

mdl_angle = fitlm(X,K_fit,'poly1111')   % poly12

dnew = linspace(0.001,450,100)';

%dnew = (304.8).*ones(100,1);

% thetanew = (90*pi/180).*ones(100,1);
% 
% %thetanew = linspace(0,pi/2,100)';
% 
% Xnew = [log10(dnew), (thetanew) ];
% 
% Knew = predict(mdl_angle_up,Xnew) ;

% figure;
% plot(dnew,Knew)
% hold on
% plot(d_range,K_high(8,:),'*')


[d_fit, theta_fit, V_fit] = organize_matrix(d_range_comb, theta_range, V);

X = [log10(d_fit) (theta_fit) log10(h_fit) log10(hV) ];

mdl_vehicle = fitlm(X,V_fit, 'poly1111')  % poly12

% Xnew = [log10(dnew), (thetanew) ];
% 
% Vnew = predict(mdl_vehicle_up,Xnew);

% 
% figure;
% plot(dnew,Vnew)
% hold on
% plot(d_range,V_high(4,:),'*')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_high = 1.6786;
d_ref = d_range(1);

PL = PL_E_Up(1,1) + 10*n_high*log10(d_range./d_ref);
PL_T_Up = repmat(PL,8,1);

n_low = 2.0325;

PL = PL_E_Down(1,1) + 10*n_low*log10(d_range./d_ref);
PL_T_Down = repmat(PL,8,1);

PL_T = [PL_T_Up; PL_T_Down] + C;

[d, theta] = organize_vector(d_range_comb, theta_range);

hB = h_fit;



K = predict(mdl_angle,[log10(d) (theta) log10(hB) log10(hV) ]) ;
K = reshape(K,16,10) + C;
V = predict(mdl_vehicle,[log10(d) (theta) log10(hB) log10(hV) ]) ;
V = reshape(V,16,10) + C;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = [K(:) V(:) log10(hB) log10(hV) ];

PL_Diff = PL_E - PL_T;

mdl_total = fitlm(X,PL_Diff(:), 'poly1111')  % poly12


save KV_model.mat mdl_angle mdl_vehicle mdl_total


