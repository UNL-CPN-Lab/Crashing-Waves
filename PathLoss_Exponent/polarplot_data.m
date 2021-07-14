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
  
pl_lower_all = [pl0; pl3; pl6; pl10; pl20; pl30; pl60; pl90];

theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);

xWidth = 0.8;
yWidth = 1;
font_size = 40;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);

rho = pl_lower_all(:,1);
polarplot(theta,rho, 'Color', 'b', 'Marker', '*');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
hold on;
rho = pl_lower_all(:,2);
polarplot(theta,rho, 'Color', 'r', 'Marker', 'd');
rho = pl_lower_all(:,3);
polarplot(theta,rho, 'Color', 'g', 'Marker', 's');
rho = pl_lower_all(:,4);
polarplot(theta,rho, 'Color', 'c', 'Marker', '+');
rho = pl_lower_all(:,5);
polarplot(theta,rho, 'Color', 'm', 'Marker', '>');
rho = pl_lower_all(:,6);
polarplot(theta,rho, 'Color', 'y', 'Marker', '<');
rho = pl_lower_all(:,7);
polarplot(theta,rho, 'Color', 'k', 'Marker', '^');
rho = pl_lower_all(:,8);
polarplot(theta,rho, 'Color', 'r', 'Marker', 'h');
rho = pl_lower_all(:,9);
polarplot(theta,rho, 'Color', 'b', 'Marker', 'o');
rho = pl_lower_all(:,10);
polarplot(theta,rho, 'Color', 'g', 'Marker', 'p');
legend('100ft','200ft','300ft','400ft','500ft','600ft','700ft','800ft','900ft','1000ft', 'Location','Northeastoutside' )
rlim([60 110]);
rticks([60 100])
rticklabels({'PL = 60 dB', 'PL = 100 dB'})

print('Results/Polarplot_Nocar_Nobarrier','-depsc');
print('Results/Polarplot_Nocar_Nobarrier','-dpng');
savefig(strcat('Results/Polarplot_Nocar_Nobarrier','.fig'));
