clc;
close all;

clear all;



load 34AGT2_145_doppler_norm.mat
load AGTB2_180_doppler_norm.mat
load NJPCB_180_doppler_norm.mat
load WIDT1_188_doppler_norm.mat

load 34AGT2_87_v.mat
load 34AGT2_145_v.mat
load AGTB2_180_v.mat
load AGTB2_Omni_v.mat
load KIA_v.mat
load NJPCB_180_v.mat
load NJPCB_Omni_v.mat
load WIDT1_188_v.mat

auto_corr = {auto_corr_34AGT2_145, auto_corr_AGTB2_180, auto_corr_NJPCB_180, auto_corr_WIDT1_188};

doppler_frequency = {doppler_freq_34AGT2_145, doppler_freq_AGTB2_180, doppler_freq_NJPCB_180, doppler_freq_WIDT1_188};

v = {v_34AGT2_145, v_AGTB2_180, v_NJPCB_180, v_WIDT1_188};



s = zeros(size(doppler_frequency));
for i = 1:length(doppler_frequency)
    s(i) = length(doppler_frequency{i});
end
v_all = zeros(sum(s),1);
doppler_all = zeros(25,25,sum(s));

start_idx = 1;
for i = 1:length(v)
    stop_idx = start_idx + s(i) - 1;
    v_all(start_idx:stop_idx) = v{i};
    doppler_all(:,:,start_idx:stop_idx) = doppler_frequency{i};
    start_idx = stop_idx + 1;
end

mean_doppler_all = nanmean(nanmean(doppler_all));
mean_doppler_all = mean_doppler_all(:);

total = [v_all mean_doppler_all];
total = sortrows(total);
v_all = total(:,1);
mean_doppler_all = total(:,2);

idx = 1:51100;
v_all(idx) = [];
mean_doppler_all(idx) = [];

X = log(v_all+1e-20);
XX = [ones(size(X)) X];
Y = log(mean_doppler_all);
B = XX\Y;
a = exp(B(1));
b = B(2);

v_th = linspace(0,30,2600);
d_th = a.*v_th.^b;

xWidth = 1;
yWidth = 1;
lineWidth = 3;
fontsize = 33;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
plot(v_all,mean_doppler_all,'*')
hold on
plot(v_th,d_th,'d')
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
legend('Calculated','Model')
grid on;
box on;
xlim([0 30]);
ylim([0 400]);
xlabel('Velocity(m/s)');
ylabel('Doppler Spread (Hz)');

% print('Results/Doppler_High','-depsc');
% print('Results/Doppler_High','-dpng');
% savefig(strcat('Results/Doppler_High','.fig'));

