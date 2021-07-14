clc;
clear all;
close all;

format long g;

pl0 = [83.883347 93.755752 89.114896 91.279586 95.137187 99.222277 100.083587 100.92033 103.324519 106.982946];

pl3 = [81.38925 91.923683 86.689068 89.521814 91.528818 94.216237 97.004512 98.248759 100.90061 103.047785 ];

pl6 = [83.069998 91.936461 88.26183 90.941494 93.00588 94.878452 98.996018 102.390701 103.006895 102.502726 ];

pl10 = [68.004496 74.755129 72.62803 75.1144 77.755523 79.534372 81.909683 83.676011 87.438081 87.733666 ];

pl20 = [91.397397 92.030279 89.539602 92.108345 85.691128 NaN 91.19302 89.283853 85.313157 82.733666 ];

pl30 = [79.186323 88.742653 88.232888 92.119293 92.43489 94.255463 86.477278 83.278166 83.938657 91.698762 ];

pl60 = [72.172319 82.672522 79.629036 69.254227 74.499488 87.656682 NaN 82.117396 86.780197 87.521124 ];

pl90 = [74.689366 82.253528 80.482842 86.047937 85.285552 86.169595 85.307491 NaN NaN NaN ];
  
pl_lower_all = [pl0; pl3; pl6; pl10; pl20; pl30; pl60; pl90];

count_down_0 = [1853, 2075, 2123, 2637, 2279, 2242, 1780, 1738, 1941, 1859];
count_down_3 = [2211        2412        1930        2166        2302        2310        2014        1877        1909        1944];
count_down_6 = [2095        2177        1896        1787        2168        2339        1893        1896        2018        2164];
count_down_10 = [ 2415        2305        1758        2029        2452        2489        2518        2016        2719        2055];
count_down_20 = [ 1610        1805        2214        1803        2102         NaN        1932        1871        1932         665];
count_down_30 = [1878        1596        1617        1430        1756        2150        1981        1707        1857        1872];
count_down_60 = [1860        1574        1852        1863        1749        1907           NaN        1549          16          43];
count_down_90 = [2231        1632        1540         454         127           4        1314           NaN         NaN          NaN];

count_lower_all = [count_down_0; count_down_3; count_down_6; count_down_10; count_down_20; count_down_30; count_down_60; count_down_90];

d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];

PL = pl0;

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

n_low = n(index);


pl_tot = pl_lower_all.*count_lower_all;

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

print('Results/Gain_Corrected_Lower','-depsc');
print('Results/Gain_Corrected_Lower','-dpng');
savefig(strcat('Results/Gain_Corrected_Lower','.fig'));

save pathloss_gain_low.mat n_low theta Gain



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




