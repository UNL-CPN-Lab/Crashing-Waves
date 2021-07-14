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

coh_bw_high = [coh_bw_intereast_34AGT2_145; coh_bw_intereast_AGTB2_180; coh_bw_intereast_NJPCB_180; coh_bw_intereast_WIDT1_188  ];

mean_coh_bw_high = nanmean(coh_bw_high);

max_coh_bw_high = nanmax(coh_bw_high);
min_coh_bw_high = nanmin(coh_bw_high);

up_dev_high = max_coh_bw_high-mean_coh_bw_high;
down_dev_high = mean_coh_bw_high-min_coh_bw_high;

distances = 0:50:400;

xWidth = 1;
yWidth = 1;
lineWidth = 3;
fontsize = 33;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
%plot(distances(1:end-1)+50,mean_coh_bw./1000,'-*','LineWidth',lineWidth);
errorbar(distances(1:end-1)+50,mean_coh_bw_high./1000,down_dev_high./1000,up_dev_high./1000,'-*','LineWidth',lineWidth)
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
xticks([50 100 150 200 250 300 350 400]);
xticklabels({'0-50' '50-100' '100-150' '150-200' '200-250' '250-300' '300-350' '350-400'});
xlim([50 400]);
ylim([0 600]);
grid on;
box on;
xlabel('Distances(m)');
ylabel('Coherence Bandwidth (kHz)');

print('Results/Coh_BW_Combined_High','-depsc');
print('Results/Coh_BW_Combined_High','-dpng');
savefig(strcat('Results/Coh_BW_Combined_High','.fig'));


coh_bw_low = [coh_bw_intereast_34AGT2_87; coh_bw_intereast_AGTB2_Omni; coh_bw_intereast_KIA; coh_bw_intereast_NJPCB_Omni];

mean_coh_bw_low = nanmean(coh_bw_low);

max_coh_bw_low = nanmax(coh_bw_low);
min_coh_bw_low = nanmin(coh_bw_low);

up_dev_low = max_coh_bw_low-mean_coh_bw_low;
down_dev_low = mean_coh_bw_low-min_coh_bw_low;

distances = 0:50:400;

xWidth = 1;
yWidth = 1;
lineWidth = 3;
fontsize = 33;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
%plot(distances(1:end-1)+50,mean_coh_bw./1000,'-*','LineWidth',lineWidth);
errorbar(distances(1:end-1)+50,mean_coh_bw_low./1000,down_dev_low./1000,up_dev_low./1000,'-*','LineWidth',lineWidth)
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
xticks([50 100 150 200 250 300 350 400]);
xticklabels({'0-50' '50-100' '100-150' '150-200' '200-250' '250-300' '300-350' '350-400'});
xlim([50 250]);
ylim([0 600]);
grid on;
box on;
xlabel('Distances(m)');
ylabel('Coherence Bandwidth (kHz)');

print('Results/Coh_BW_Combined_Low','-depsc');
print('Results/Coh_BW_Combined_Low','-dpng');
savefig(strcat('Results/Coh_BW_Combined_Low','.fig'));
