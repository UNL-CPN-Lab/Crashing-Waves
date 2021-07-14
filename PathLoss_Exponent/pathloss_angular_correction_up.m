clc;
clear all;
close all;

pl0_up = [78.194406 83.151873 92.727434 95.148201 91.269844 92.036073 92.633742 94.974403 94.752296 97.130189 ];

pl3_up = [78.30068 84.090198 92.249419 94.670873 90.822882 91.266166 92.725089 93.6535 95.68956 95.390803 ];

pl6_up = [101.400482 101.659808 108.226443 107.945192 101.412804 101.167556 NaN 104.438579 109.623122 111.227307 ];
 
pl10_up = [67.225393 72.049906 80.67961 83.143528 79.029001 79.374113 80.499836 82.653415 86.219355 85.149293 ];

pl20_up = [74.597603 79.664376 85.729789 88.751158 92.253331 82.826638 81.749407 82.314713 80.020602 85.598754 ];

pl30_up = [73.379555 78.345207 88.346707 90.040568 84.437683 79.162685 84.669039 82.625242 82.44212 83.485283 ];

pl60_up = [69.770377 74.994504 78.553752 80.847456 83.883079 79.554722 85.992416 87.591139 88.680772 NaN ];

pl90_up = [77.393116 81.351571 NaN 83.131098 NaN 83.372391 85.374736 NaN NaN NaN ];

pl_upper_all = [pl0_up; pl3_up; pl6_up; pl10_up; pl20_up; pl30_up; pl60_up; pl90_up];

PL = pl0_up;

d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];

n = linspace(1,3,1000);

PL_calc = zeros(length(d_range),length(n));

constant = 20*log10(5.8e3)+32.44;

for i = 1:length(d_range)
    PL_calc(i,:) = constant+n.*(10*log10(d_range(i)./1000));
end

error = zeros(1,length(n));

for i = 1:length(n)
   error(i) = immse(PL',PL_calc(:,i)); 
end

[val, index] = min(error);

n_high = n(index);

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

save pathloss_data_high.mat V_high n_high



