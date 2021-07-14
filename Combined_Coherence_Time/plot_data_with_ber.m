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

ber_high = [ber_intereast_34AGT2_145; ber_intereast_AGTB2_180; ber_intereast_NJPCB_180; ber_intereast_WIDT1_188  ];

mean_coh_time_high = nanmean(coh_time_high);

max_coh_time_high = nanmax(coh_time_high);
min_coh_time_high = nanmin(coh_time_high);

up_dev_high = max_coh_time_high-mean_coh_time_high;
down_dev_high = mean_coh_time_high-min_coh_time_high;

velicities = 0:3:30;

xWidth = 1;
yWidth = 1;
lineWidth = 3;
fontsize = 33;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
scatter(velicities(1:end-1)+3, coh_time_high(1,:)*1000,100,ber_high(1,:),'filled')
hold on
scatter(velicities(1:end-1)+3, coh_time_high(2,:)*1000, 100,ber_high(2,:),'filled')
scatter(velicities(1:end-1)+3, coh_time_high(3,:)*1000, 100,ber_high(3,:),'filled')
scatter(velicities(1:end-1)+3, coh_time_high(4,:)*1000, 100,ber_high(4,:),'filled')
c = colorbar;
c.Label.String = 'BER';
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
set(gca,'ColorScale','log')
xticks([3 6 9 12 15 18 21 24 27 30]);
xticklabels({'0-3' '3-6' '6-9' '9-12' '12-15' '15-18' '18-21' '21-24' '24-27' '27-30'});
xlim([3 27]);
ylim([0 50]);
caxis([0 1]);
grid on;
box on;
xlabel('Velocities(m/s)');
ylabel('Coherence Time (ms)');
print('Results/Coh_time_BER_Combined_High','-depsc');
print('Results/Coh_time_BER_Combined_High','-dpng');
savefig(strcat('Results/Coh_time_BER_Combined_High','.fig'));


coh_time_low = [coh_time_intereast_34AGT2_87; coh_time_intereast_AGTB2_Omni; coh_time_intereast_KIA; coh_time_intereast_NJPCB_Omni];

mean_coh_time_low = nanmean(coh_time_low);

max_coh_time_low = nanmax(coh_time_low);
min_coh_time_low = nanmin(coh_time_low);

up_dev_low = max_coh_time_low-mean_coh_time_low;
down_dev_low = mean_coh_time_low-min_coh_time_low;
ber_low = [ber_intereast_34AGT2_87; ber_intereast_AGTB2_Omni; ber_intereast_KIA; ber_intereast_NJPCB_Omni];

xWidth = 1;
yWidth = 1;
lineWidth = 3;
fontsize = 33;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
scatter(velicities(1:end-1)+3, coh_time_low(1,:)*1000,100,ber_low(1,:),'filled')
hold on
scatter(velicities(1:end-1)+3, coh_time_low(2,:)*1000, 100,ber_low(2,:),'filled')
scatter(velicities(1:end-1)+3, coh_time_low(3,:)*1000, 100,ber_low(3,:),'filled')
scatter(velicities(1:end-1)+3, coh_time_low(4,:)*1000, 100,ber_low(4,:),'filled')
c = colorbar;
c.Label.String = 'BER';
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
set(gca,'ColorScale','log')
xticks([3 6 9 12 15 18 21 24 27 30]);
xticklabels({'0-3' '3-6' '6-9' '9-12' '12-15' '15-18' '18-21' '21-24' '24-27' '27-30'});
xlim([3 27]);
ylim([0 50]);
caxis([0 1]);
grid on;
box on;
xlabel('Velocities(m/s)');
ylabel('Coherence Time (ms)');

print('Results/Coh_time_BER_Combined_Low','-depsc');
print('Results/Coh_time_BER_Combined_Low','-dpng');
savefig(strcat('Results/Coh_time_BER_Combined_Low','.fig'));


