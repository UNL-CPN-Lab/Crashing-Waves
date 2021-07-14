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



distances = 0:50:400;

xWidth = 1;
yWidth = 1;
alpha = 0.2;
lineWidth = 3;
fontsize = 33;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
for i = 1:size(coh_bw_high,1)
    scatter(distances(1:end-1)+50, coh_bw_high(i,:)./1000,100*ones(1,size(coh_bw_high,2)),...
    'MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha);
    hold on;
end
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
xticks([50 100 150 200 250 300 350 400]);
xticklabels({'0-50' '50-100' '100-150' '150-200' '200-250' '250-300' '300-350' '350-400'});
xlim([50 400]);
ylim([0 600]);
grid on;
box on;
xlabel('Distances(m)');
ylabel('Coherence Bandwidth (kHz)');

print('Results/Coh_BW_Combined_Transparent_High','-depsc');
print('Results/Coh_BW_Combined_Transparent_High','-dpng');
savefig(strcat('Results/Coh_BW_Combined_Transparent_High','.fig'));


coh_bw_low = [coh_bw_intereast_34AGT2_87; coh_bw_intereast_AGTB2_Omni; coh_bw_intereast_KIA; coh_bw_intereast_NJPCB_Omni];


distances = 0:50:400;

xWidth = 1;
yWidth = 1;
alpha = 0.2;
lineWidth = 3;
fontsize = 33;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
for i = 1:size(coh_bw_low,1)
    scatter(distances(1:end-1)+50, coh_bw_low(i,:)./1000,100*ones(1,size(coh_bw_low,2)),...
    'MarkerFaceColor','b','MarkerEdgeColor','b','MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha);
    hold on;
end
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
xticks([50 100 150 200 250 300 350 400]);
xticklabels({'0-50' '50-100' '100-150' '150-200' '200-250' '250-300' '300-350' '350-400'});
xlim([50 400]);
ylim([0 600]);
grid on;
box on;
xlabel('Distances(m)');
ylabel('Coherence Bandwidth (kHz)');

print('Results/Coh_BW_Combined_Transparent_Low','-depsc');
print('Results/Coh_BW_Combined_Transparent_Low','-dpng');
savefig(strcat('Results/Coh_BW_Combined_Transparent_Low','.fig'));