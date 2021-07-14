clc
clear all
close all

RSS0_up = [-34.896975 -39.851265 -49.425696 -51.848421 -47.964326 -48.733547 -49.337804 -51.673147 -51.451083 -53.828945 ];

RSS3_up = [-36.004015 -41.789217 -49.955169 -52.367354 -48.520944 -48.967475 -50.422847 -51.349754 -53.393403 -53.091075];

RSS6_up = [-60.583163 -60.854765 -67.425941 -67.145872 -60.615949 -60.359767 NaN -63.640568 -68.829057 -70.646081];
 
RSS10_up = [-36.421082 -41.249673 -49.880378 -52.338825 -48.226530 -48.566302 -49.702620 -51.850315 -55.420042 -54.349514];

RSS20_up = [-38.952077 -53.864516 -59.925902 -68.952956 -66.395999 -57.020362 -55.952221 -56.525268 -54.219179 -59.799168];

RSS30_up = [ -48.587874 -53.552137 -63.528132 -65.239174 -59.638105 -54.354391 -59.867884 -57.828714 -57.648357 -58.692186];

RSS60_up = [-51.467890 -56.709270 -60.179978 -62.547888 -65.559869 -61.256074 -70.571972 -62.833515 -70.961368 NaN ];

RSS90_up = [-62.087723 -66.053923 NaN -71.960087 NaN -68.175968 -71.643513 NaN NaN NaN];


RSS0_up_car = [-53.223740 -53.982220 NaN -62.419106 -60.242916 -61.239637 -61.267148 -65.105469 -64.354147 -66.645396];

RSS3_up_car = [-60.906579 -61.695892 NaN -67.716145 -67.136104 -65.394736 -66.445133 -69.768438 NaN -73.186208];

RSS6_up_car = [-66.804961 -68.628098 NaN -68.631846 -70.325229 -70.621847 -69.731657 NaN NaN NaN];

RSS10_up_car = [NaN NaN NaN NaN -70.246478 -71.710507 -71.114743 NaN NaN NaN];

RSS20_up_car = [NaN NaN NaN NaN -71.176912 NaN NaN -73.469816 NaN NaN];

RSS30_up_car = [-70.192555 -71.813394 NaN NaN NaN NaN NaN NaN NaN NaN];

RSS60_up_car = [-69.837616 NaN NaN NaN NaN NaN NaN NaN NaN NaN];

RSS90_up_car = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];

RSS_E_Up = [RSS0_up_car; RSS3_up_car; RSS6_up_car; RSS10_up_car; RSS20_up_car; RSS30_up_car; RSS60_up_car; RSS90_up_car];
    
RSS0 = [-40.595194 -50.454728 -45.813841 -47.978956 -51.836546 -55.922742 -56.780174 -57.620383 -57.946925 -63.678594];

RSS3 = [-39.088578 -49.631427 -44.375355 -47.228998 -49.225901 -51.919514 -54.702199 -55.946190 -58.597057 -60.742007 ];

RSS6 = [-42.272843 -51.137898 -47.457571 -50.141466 -52.206084 -54.077131 -58.192290 -61.597550 -62.205660 -61.725172];

RSS10 = [-37.195982 -43.957736 -41.830623 -44.316188 -46.954398 -48.731444 -51.109955 -52.872783 -56.636354 -56.933446];

RSS20 = [-65.615178 -66.245176 -63.735182 -66.330099 -59.892486 NaN -65.391566 -63.490047 -59.521892 -70.679831];

RSS30 = [-54.397788 -63.913686 -63.442080 -66.589420 -67.626522 -69.515652 -61.685518 -58.485102 -59.136584 -66.897492];

RSS60 = [-53.875544 -64.413155 -61.322032 -50.949582 -56.190405 -69.372462 NaN -63.803151 -67.402965 -71.464578 ];

RSS90 = [-59.364789 -66.972046 -65.178780 -67.776789 -70.220022 -67.763524 -69.954102 NaN NaN NaN ];


RSS0_car = [-53.557622 -57.976691 -57.865940 -61.391004 -64.739254 -64.997059 -67.429497 NaN -70.593325 NaN];

RSS3_car = [-67.469758 -67.495409 NaN NaN NaN NaN NaN NaN NaN NaN];

RSS6_car = [-64.565607 -67.761593 -63.343875 -70.167671 -67.929912 -69.937059 NaN NaN NaN NaN];

RSS10_car = [NaN NaN NaN 104.35343 106.103157 NaN NaN NaN NaN NaN];

RSS10_car = [-70.464061 NaN NaN -68.942971 -67.989090 NaN NaN NaN NaN NaN];

RSS20_car = [-69.551433 -69.625752 NaN NaN NaN NaN NaN NaN NaN NaN ];

RSS30_car = [-67.542841 -67.929365 NaN NaN NaN NaN NaN NaN NaN NaN ];

RSS60_car = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];

RSS90_car = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];

hV = 1.45.*ones(160,1);

RSS_E_Down = [RSS0_car; RSS3_car; RSS6_car; RSS10_car; RSS20_car; RSS30_car; RSS60_car; RSS90_car];

RSS_E = [RSS_E_Up; RSS_E_Down];


C = zeros(size(RSS_E));
C(isnan(RSS_E)) = NaN;

K0 = RSS0_up -RSS0_up;
K3 = RSS3_up -RSS0_up;
K6 = RSS6_up -RSS0_up;
K10 = RSS10_up -RSS0_up;
K20 = RSS20_up -RSS0_up;
K30 = RSS30_up -RSS0_up;
K60 = RSS60_up -RSS0_up;
K90 = RSS90_up -RSS0_up;

K_high = [K0; K3; K6; K10; K20; K30; K60; K90];

V0 = RSS0_up -RSS0_up_car;
V3 = RSS3_up -RSS3_up_car;
V6 = RSS6_up -RSS6_up_car;
V10 = RSS10_up -RSS10_up_car;
V20 = RSS20_up -RSS20_up_car;
V30 = RSS30_up -RSS30_up_car;
V60 = RSS60_up -RSS60_up_car;
V90 = RSS90_up -RSS90_up_car;

V_high = [V0; V3; V6; V10; V20; V30; V60; V90];

K0 = RSS0 -RSS0;
K3 = RSS3 -RSS0;
K6 = RSS6 -RSS0;
K10 = RSS10 -RSS0;
K20 = RSS20 -RSS0;
K30 = RSS30 -RSS0;
K60 = RSS60 -RSS0;
K90 = RSS90 -RSS0;

K_low = [K0; K3; K6; K10; K20; K30; K60; K90];

V0 = RSS0 -RSS0_car;
V3 = RSS3 -RSS3_car;
V6 = RSS6 -RSS6_car;
V10 = RSS10 -RSS10_car;
V20 = RSS20 -RSS20_car;
V30 = RSS30 -RSS30_car;
V60 = RSS60 -RSS60_car;
V90 = RSS90 -RSS90_car;

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
% RSSot(dnew,Knew)
% hold on
% RSSot(d_range,K_high(8,:),'*')


[d_fit, theta_fit, V_fit] = organize_matrix(d_range_comb, theta_range, V);

X = [log10(d_fit) (theta_fit) log10(h_fit) log10(hV) ];

mdl_vehicle = fitlm(X,V_fit, 'poly1111')  % poly12

% Xnew = [log10(dnew), (thetanew) ];
% 
% Vnew = predict(mdl_vehicle_up,Xnew);

% 
% figure;
% RSSot(dnew,Vnew)
% hold on
% RSSot(d_range,V_high(4,:),'*')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_high = 1.67835043567682;
d_ref = d_range(1);

RSS = RSS_E_Up(1,1) - 10*n_high*log10(d_range./d_ref);
RSS_T_Up = repmat(RSS,8,1);

n_low = 1.96351712381082;

RSS = RSS_E_Down(1,1) - 10*n_low*log10(d_range./d_ref);
RSS_T_Down = repmat(RSS,8,1);

RSS_T = [RSS_T_Up; RSS_T_Down] + C;

[d, theta] = organize_vector(d_range_comb, theta_range);

hB = h_fit;



K = predict(mdl_angle,[log10(d) (theta) log10(hB) log10(hV) ]) ;
K = reshape(K,16,10) + C;
V = predict(mdl_vehicle,[log10(d) (theta) log10(hB) log10(hV) ]) ;
V = reshape(V,16,10) + C;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = [K(:) V(:) log10(hB) log10(hV) ];

RSS_Diff = RSS_E - RSS_T;

mdl_total = fitlm(X,RSS_Diff(:), 'poly1111')  % poly12


save KV_model_RSS.mat mdl_angle mdl_vehicle mdl_total n_high n_low


