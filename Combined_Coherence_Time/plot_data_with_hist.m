clc;
clear all;
close all;

load 34AGT2_87_coh_time.mat
load 34AGT2_145_coh_time.mat
load AGTB2_180_coh_time.mat
load AGTB2_Omni_coh_time.mat
load KIA_coh_time.mat
load NJPCB_180_coh_time.mat
load NJPCB_Omni_coh_time.mat
load WIDT1_188_coh_time.mat

coh_time_high = [coh_time_intereast_34AGT2_145; coh_time_intereast_AGTB2_180; coh_time_intereast_NJPCB_180; coh_time_intereast_WIDT1_188  ];

mean_coh_time_high = nanmean(coh_time_high);

max_coh_time_high = nanmax(coh_time_high);
min_coh_time_high = nanmin(coh_time_high);

up_dev_high = max_coh_time_high-mean_coh_time_high;
down_dev_high = mean_coh_time_high-min_coh_time_high;

coh_time_count_high = coh_time_count_34AGT2_145 + coh_time_count_AGTB2_180  + coh_time_count_NJPCB_180 + coh_time_count_WIDT1_188;

velicities = 0:3:30;

v = velicities + 1.5;

c = 3e8;
f = 5.8e9;
lamda = c/f;

fD = v/lamda;

T = 1./fD;

xWidth = 1;
yWidth = 1;
lineWidth = 3;
fontsize = 33;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
%subplot(2,1,1);
plot(velicities(1:end)+3,T*1000)
%errorbar(velicities(1:end-1)+3,mean_coh_time_high.*1000,down_dev_high.*1000,up_dev_high.*1000,'-*','LineWidth',lineWidth)
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
xticks([3 6 9 12 15 18 21 24 27 30]);
xticklabels({'0-3' '3-6' '6-9' '9-12' '12-15' '15-18' '18-21' '21-24' '24-27' '27-30'});
xlim([3 27]);
ylim([0 50]);
grid on;
box on;
xlabel('Velocities(m/s)');
ylabel('Coherence Time (ms)');
% subplot(2,1,2);
% bar(velicities(1:end-1)+3,coh_time_count_high);
% set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
% 
% xticks([3 6 9 12 15 18 21 24 27 30]);
% xticklabels({'0-3' '3-6' '6-9' '9-12' '12-15' '15-18' '18-21' '21-24' '24-27' '27-30'});
% xlim([2 27]);
% xlabel('Velocities(m/s)');
% ylabel('Sample Count');
% 
% box on;
% 
% for i1=1:numel(coh_time_count_high)-1
%     text(velicities(i1+1),coh_time_count_high(i1),num2str(coh_time_count_high(i1),'%0.2d'),...
%                'HorizontalAlignment','center',...
%                'VerticalAlignment','top',  'FontWeight', 'Bold','Color','k','FontSize', 30)
% end


% print('Results/Coh_time_Combined_High','-depsc');
% print('Results/Coh_time_Combined_High','-dpng');
% savefig(strcat('Results/Coh_time_Combined_High','.fig'));


coh_time_low = [coh_time_intereast_34AGT2_87; coh_time_intereast_AGTB2_Omni; coh_time_intereast_KIA; coh_time_intereast_NJPCB_Omni];

mean_coh_time_low = nanmean(coh_time_low);

max_coh_time_low = nanmax(coh_time_low);
min_coh_time_low = nanmin(coh_time_low);

up_dev_low = max_coh_time_low-mean_coh_time_low;
down_dev_low = mean_coh_time_low-min_coh_time_low;

coh_time_count_low = coh_time_count_34AGT2_87  + coh_time_count_AGTB2_Omni + coh_time_count_KIA +  coh_time_count_NJPCB_Omni;

xWidth = 1;
yWidth = 1;
lineWidth = 3;
fontsize = 33;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
%plot(distances(1:end-1)+50,mean_coh_time./1000,'-*','LineWidth',lineWidth);
errorbar(velicities(1:end-1)+3,mean_coh_time_low.*1000,down_dev_low.*1000,up_dev_low.*1000,'-*','LineWidth',lineWidth)
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
xticks([3 6 9 12 15 18 21 24 27 30]);
xticklabels({'0-3' '3-6' '6-9' '9-12' '12-15' '15-18' '18-21' '21-24' '24-27' '27-30'});
xlim([3 27]);
ylim([0 50]);
grid on;
box on;
xlabel('Velocities(m/s)');
ylabel('Coherence Time (ms)');

% print('Results/Coh_time_Combined_Low','-depsc');
% print('Results/Coh_time_Combined_Low','-dpng');
% savefig(strcat('Results/Coh_time_Combined_Low','.fig'));


%coh_time_count = coh_time_count_34AGT2_87 + coh_time_count_34AGT2_145 + coh_time_count_AGTB2_180 + coh_time_count_AGTB2_Omni + coh_time_count_KIA + coh_time_count_NJPCB_180 + coh_time_count_NJPCB_Omni + coh_time_count_WIDT1;