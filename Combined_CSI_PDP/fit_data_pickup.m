clc;
close all;

clear all;

load rms_low.mat
rms_low = rms;
load rms_high.mat
rms_high = rms;

load 34AGT2_87_d.mat
load 34AGT2_145_d.mat
load AGTB2_180_d.mat
load AGTB2_Omni_d.mat
load KIA_d.mat
load NJPCB_180_d.mat
load NJPCB_Omni_d.mat
load WIDT1_188_d.mat

format long g

d = {d_AGTB2_180, d_AGTB2_Omni, d_NJPCB_180, d_NJPCB_Omni, d_WIDT1_188};
rms = {rms_high{2}, rms_low{2}, rms_high{3}, rms_low{3}, rms_high{4}};

s = zeros(size(d));
for i = 1:length(d)
    s(i) = length(d{i});
end
d_all = zeros(sum(s),1);
rms_all = zeros(sum(s),1);

start_idx = 1;
for i = 1:length(d)
    stop_idx = start_idx + s(i) - 1;
    d_all(start_idx:stop_idx) = d{i};
    rms_all(start_idx:stop_idx) = rms{i};
    start_idx = stop_idx + 1;
end



rms_all(isnan(rms_all))=1e-20;

total = [d_all rms_all];
total = sortrows(total);
d_all = total(:,1);
rms_all = total(:,2);
% 
% ref = min(find(d_all >100));
% T = rms_all(ref);
idx = [1:1320 4480:45250 46560:56429];
%idx = find(d_all <0 | d_all>245.5);
d_all(idx) = [];
rms_all(idx) = [];

%f = fit(d_all,rms_all,'exp1')


X = log(d_all+1e-20);
XX = [ones(size(X)) X];
Y = log(rms_all);
B = XX\Y;
a = exp(B(1));
b = B(2);
% a = T;
% b = -b;

% merror = 1e9;
% idx = 0;
% power = linspace(-1,1,20001);
% for i = 1:length(power)
%     x = T.*(d_all.^power(i));
%     e = norm(rms_all - x);
%     if e < merror
%         merror = e;
%         idx = i;
%     end
% end
% %power(idx)
% 
%d_model = linspace(0,450,9000);
d_model = logspace(0,3,1000);
% a = T;
% b = power(idx);
rms_model = a.*(d_model.^b);

% xWidth = 1;
% yWidth = 1;
% lineWidth = 3;
% fontsize = 33;
% figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
% plot(d_all,rms_all.*1e6,'*')
% hold on
% plot(d_model, rms_model.*1e6,'d')
% set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
% legend('Calculated','Model')
% grid on;
% box on;
% xlim([0 450]);
% ylim([0 30]);
% xlabel('Distances(m)');
% ylabel('RMS Delay Spread (\mus)');

% xWidth = 1;
% yWidth = 1;
% lineWidth = 3;
% fontsize = 33;
% figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
% plot(d_all,1./(5*rms_all*1000),'*')
% set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
% grid on;
% box on;
% %xlim([0 400]);
% ylim([0 50]);
% xlabel('Distances(m)');
% ylabel('50% Coherence Bandwidth(kHz)');

a * 1e6
b
rms_comp = a.*(d_all.^b);
error = rms_all./rms_comp;
%error(1) = [];
edB = 10*log10(error);
%edB([553 2038]) = [];
std(edB,'omitnan')
k = kurtosis(edB)

rms_pickup = rms_all;
d_pickup = d_all;
rms_model_pickup = rms_model;
d_model_pickup = d_model;
save rds_pickup.mat rms_pickup d_pickup rms_model_pickup d_model_pickup

