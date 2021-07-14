clc;
clear all;
close all;

load 34AGT2_87_coh_bw.mat
load 34AGT2_145_coh_bw.mat
load AGTB2_180_coh_bw.mat
load AGTB2_Omni_coh_bw.mat
load KIA_coh_bw.mat
load NJPCB_180_coh_bw.mat
load NJPCB_Omni_coh_bw.mat
load WIDT1_188_coh_bw.mat

%coh_bw_high = [coh_bw_intereast_34AGT2_145; coh_bw_intereast_AGTB2_180; coh_bw_intereast_NJPCB_180; coh_bw_intereast_WIDT1_188  ];

coh_bw_count_high = [coh_bw_count_34AGT2_145; coh_bw_count_AGTB2_180; coh_bw_count_NJPCB_180; coh_bw_count_WIDT1_188  ];

mean_coh_bw_count_high = nanmean(coh_bw_count_high);

coh_bw_ol_count_high = [coh_bw_ol_count_34AGT2_145; coh_bw_ol_count_AGTB2_180; coh_bw_ol_count_NJPCB_180; coh_bw_ol_count_WIDT1_188  ];

mean_coh_bw_ol_count_high = nanmean(coh_bw_ol_count_high);

distances = 0:50:400;

xWidth = 1;
yWidth = 1;
lineWidth = 3;
fontsize = 25;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
%plot(distances(1:end-1)+50,mean_coh_bw./1000,'-*','LineWidth',lineWidth);
bar(distances(1:end-1)+50,[mean_coh_bw_count_high; mean_coh_bw_ol_count_high])
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
xticks([50 100 150 200 250 300 350 400]);
xticklabels({'0-50' '50-100' '100-150' '150-200' '200-250' '250-300' '300-350' '350-400'});
xlim([0 450]);
ylim([0 1]);
legend( 'Non-coherant freq. ratio', 'Outlier ratio');
grid on;
box on;
xlabel('Distances(m)');
%ylabel('Outlier');

print('Results/Coh_BW_OL_Combined_High','-depsc');
print('Results/Coh_BW_OL_Combined_High','-dpng');
savefig(strcat('Results/Coh_BW_OL_Combined_High','.fig'));


coh_bw_count_low = [coh_bw_count_34AGT2_87; coh_bw_count_AGTB2_Omni; coh_bw_count_KIA; coh_bw_count_NJPCB_Omni];

mean_coh_bw_count_low = nanmean(coh_bw_count_low);

mean_coh_bw_count_low(5) = NaN;

coh_bw_ol_count_low = [coh_bw_ol_count_34AGT2_87; coh_bw_ol_count_AGTB2_Omni; coh_bw_ol_count_KIA; coh_bw_ol_count_NJPCB_Omni];

mean_coh_bw_ol_count_low = nanmean(coh_bw_ol_count_low);

distances = 0:50:400;

xWidth = 1;
yWidth = 1;
lineWidth = 3;
fontsize = 25;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
%plot(distances(1:end-1)+50,mean_coh_bw./1000,'-*','LineWidth',lineWidth);
bar(distances(1:end-1)+50,[mean_coh_bw_count_low; mean_coh_bw_ol_count_low])
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
xticks([50 100 150 200 250 300 350 400]);
xticklabels({'0-50' '50-100' '100-150' '150-200' '200-250' '250-300' '300-350' '350-400'});
xlim([0 450]);
ylim([0 1]);
legend( 'Non-coherant freq. ratio', 'Outlier ratio');
grid on;
box on;
xlabel('Distances(m)');
%ylabel('Outlier');

print('Results/Coh_BW_OL_Combined_Low','-depsc');
print('Results/Coh_BW_OL_Combined_Low','-dpng');
savefig(strcat('Results/Coh_BW_OL_Combined_Low','.fig'));
