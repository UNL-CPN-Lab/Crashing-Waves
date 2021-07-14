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

pl_upper_all = [pl0_up; pl3_up; pl6_up; pl10_up; pl20_up; pl30_up; pl60_up; pl90_up];

count_up_0 = [2050        1542        1759        2498        1800        1755        1799        1806        2076        1764];
count_up_3 = [ 2018        1961        1857        2044        2463        2038        1983        1905        1960        1634];
count_up_6 = [ 1914        1995        1611        1536        1553        1798         NaN        1855        1861          91];
count_up_10 = [ 2032        2280        1760        1894        1702        2124        2400        2010        2392        1559];
count_up_20 = [2039        2321        2265         107        1903        1974        2064        1870        1961        2051];
count_up_30 = [1847        1816        1564        1378        1706        2416        1969        1666        1892        1732];
count_up_60 = [ 2177        1643        1514        1615        1534        1655          17         323           2         NaN];
count_up_90 = [2115        1588         NaN          23         NaN        1784           1         NaN         NaN         NaN];
count_upper_all = [count_up_0; count_up_3; count_up_6; count_up_10; count_up_20; count_up_30; count_up_60; count_up_90];

d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];

PL = pl0_up;

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


pl_tot = pl_upper_all.*count_upper_all;

pl_mean = nanmean(pl_tot,2);

pl_mean_norm = pl_mean./pl_mean(1);

Gain = pl_mean_norm.*28;

theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);

theta_q = linspace(0,90,1000).*(pi/180);

Gain_q = interp1(theta,Gain,theta_q,'Spline');

Gain_q2 = flip(Gain_q);

theta_q2 = linspace(270,360,1000).*(pi/180);

theta_comb = [theta_q theta_q2];
Gain_comb =  [Gain_q Gain_q2];

xWidth = 0.8;
yWidth = 1;
font_size = 40;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
polarplot( theta_comb,Gain_comb, 'Color', 'r');
%polarplot( theta,Gain, 'Color', 'r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
thetalim([270,450])
rticks([0 10 20 30])
rticklabels({'Gain = 0dBi', 'Gain = 10dBi', 'Gain = 20dBi', 'Gain = 30dBi'})
thetaticks([270 300 330 360 390 420 450])
thetaticklabels({'270','300','330','0', '30', '60', '90'})

print('Results/Gain_Corrected_Upper','-depsc');
print('Results/Gain_Corrected_Upper','-dpng');
savefig(strcat('Results/Gain_Corrected_Upper','.fig'));

save pathloss_gain_high.mat n_high theta Gain


% save pathloss_data_low.mat V_low n_low
% 
% 
% d_q = linspace(0,400,10000);
% theta_q = linspace(0,90,1000).*(pi/180);
% 
% 
% Vq = interp2(d_range,theta,V_low,d_q,theta_q','spline');
% Vq =Vq';
% % 
% % interp2(d_range,theta,V_low,d_q(1250),theta_q(329),'spline')
% % Vq(1250,329)




