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

PL_E = [pl0_up_car; pl3_up_car; pl6_up_car; pl10_up_car; pl20_up_car; pl30_up_car; pl60_up_car; pl90_up_car];

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

d_range = 30.48.*(1:10);

theta_range = [0 3 6 10 20 30 60 90].*(pi/180);

[d_fit, theta_fit, K_fit] = organize_matrix(d_range, theta_range, K_high);


X = [log10(d_fit) (theta_fit) ];

p = zeros(3,1);
r = p;
p(1) = 1;
q = (0:1:2)';

T = [p q r];

mdl_angle_up = fitlm(X,K_fit,'poly11')   % poly12

dnew = linspace(0.001,450,100)';

%dnew = (304.8).*ones(100,1);

thetanew = (90*pi/180).*ones(100,1);

%thetanew = linspace(0,pi/2,100)';

Xnew = [log10(dnew), (thetanew) ];

Knew = predict(mdl_angle_up,Xnew) ;

% figure;
% plot(dnew,Knew)
% hold on
% plot(d_range,K_high(8,:),'*')


[d_fit, theta_fit, V_fit] = organize_matrix(d_range, theta_range, V_high);

X = [log10(d_fit) (theta_fit) ];

mdl_vehicle_up = fitlm(X,V_fit, 'poly11')  % poly12

Xnew = [log10(dnew), (thetanew) ];

Vnew = predict(mdl_vehicle_up,Xnew);

% 
% figure;
% plot(dnew,Vnew)
% hold on
% plot(d_range,V_high(4,:),'*')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_high = 1.6786;
d_ref = d_range(1);

PL = PL_E(1,1) + 10*n_high*log10(d_range./d_ref);
PL_T = repmat(PL,8,1) + C;

[d, theta] = organize_vector(d_range, theta_range);

K = predict(mdl_angle_up,[log10(d), (theta)]) ;
K = reshape(K,8,10) + C;
V = predict(mdl_vehicle_up,[log10(d), (theta)]) ;
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
a33 = 28;%N_d * N_theta;
b3 = sum(sum(PL_E, 'omitnan'), 'omitnan') - sum(sum(PL_T, 'omitnan'), 'omitnan');

A = [a11, a12, a13; a21, a22, a23; a31, a32, a33];
b = [b1; b2; b3];

W = A\b;

E = mean(mean((PL_E - PL_T - W(1).*K - W(2).*V - W(3)).^2, 'omitnan'), 'omitnan');

RSS = sum(sum((PL_E - PL_T - W(1).*K - W(2).*V - W(3)).^2, 'omitnan'), 'omitnan');
OBS_mean =  mean(mean(PL_E,'omitnan'),'omitnan');
TSS = sum(sum((PL_E - OBS_mean).^2, 'omitnan'), 'omitnan');
R_square = 1 - RSS/TSS;


save KV_model_up.mat mdl_angle_up mdl_vehicle_up W


