clc
clear all
close all

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

PL_E = [pl0_car; pl3_car; pl6_car; pl10_car; pl20_car; pl30_car; pl60_car; pl90_car];

C = zeros(size(PL_E));
C(isnan(PL_E)) = NaN;

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

d_range = 30.48.*(1:10);

theta_range = [0 3 6 10 20 30 60 90].*(pi/180);

[d_fit, theta_fit, K_fit] = organize_matrix(d_range, theta_range, K_low);


X = [log10(d_fit) (theta_fit) ];

p = zeros(3,1);
r = p;
p(1) = 1;
q = (0:1:2)';

T = [p q r];

mdl_angle_down = fitlm(X,K_fit,'poly11')   % poly12

%dnew = linspace(0.001,450,100)';

%dnew = (304.8).*ones(100,1);

%thetanew = (90*pi/180).*ones(100,1);

%thetanew = linspace(0,pi/2,100)';

% Xnew = [log10(dnew), (thetanew) ];
% 
% Knew = predict(mdl_angle_down,Xnew) ;

% figure;
% plot(dnew,Knew)
% hold on
% plot(d_range,K_low(8,:),'*')


[d_fit, theta_fit, V_fit] = organize_matrix(d_range, theta_range, V_low);

X = [log10(d_fit) (theta_fit) ];

mdl_vehicle_down = fitlm(X,V_fit, 'poly11')  % poly12

% Xnew = [log10(dnew), (thetanew) ];
% 
% Vnew = predict(mdl_vehicle_down,Xnew);

% 
% figure;
% plot(dnew,Vnew)
% hold on
% plot(d_range,V_low(4,:),'*')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_low = 2.0325;
d_ref = d_range(1);

PL = PL_E(1,1) + 10*n_low*log10(d_range./d_ref);
PL_T = repmat(PL,8,1) + C;

[d, theta] = organize_vector(d_range, theta_range);

K = predict(mdl_angle_down,[log10(d), (theta)]) ;
K = reshape(K,8,10) + C;
V = predict(mdl_vehicle_down,[log10(d), (theta)]) ;
V = reshape(V,8,10) + C;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N_d = length(d_range);
N_theta = length(theta_range);

a11 = sum(sum(K.^2, 'omitnan'), 'omitnan');
a12 = sum(sum(K.*V, 'omitnan'), 'omitnan');
a13 = sum(sum(K, 'omitnan'), 'omitnan');
b1 = sum(sum(PL_E.*K, 'omitnan'), 'omitnan') - sum(sum(PL_T.*K, 'omitnan'), 'omitnan');

a21 = sum(sum(K.*V, 'omitnan'), 'omitnan');
a22 = sum(sum(V.^2, 'omitnan'), 'omitnan');
a23 = sum(sum(V, 'omitnan'), 'omitnan');
b2 = sum(sum(PL_E.*V, 'omitnan'), 'omitnan') - sum(sum(PL_T.*V, 'omitnan'), 'omitnan');

a31 = sum(sum(K, 'omitnan'), 'omitnan');
a32 = sum(sum(V, 'omitnan'), 'omitnan');
a33 = 21; %N_d * N_theta;  
b3 = sum(sum(PL_E, 'omitnan'), 'omitnan') - sum(sum(PL_T, 'omitnan'), 'omitnan');

A = [a11, a12, a13; a21, a22, a23; a31, a32, a33];
b = [b1; b2; b3];

W = A\b;

E = mean(mean((PL_E - PL_T - W(1).*K - W(2).*V - W(3)).^2, 'omitnan'), 'omitnan');

save KV_model_down.mat mdl_angle_down mdl_vehicle_down W


