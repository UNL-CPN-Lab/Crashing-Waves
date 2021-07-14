clc;
close all;

clear all;

load coh_bw_high.mat

load 34AGT2_87_d.mat
load 34AGT2_145_d.mat
load AGTB2_180_d.mat
load AGTB2_Omni_d.mat
load KIA_d.mat
load NJPCB_180_d.mat
load NJPCB_Omni_d.mat
load WIDT1_188_d.mat

d = {d_34AGT2_145, d_AGTB2_180, d_NJPCB_180, d_WIDT1_188};


s = zeros(size(d));
for i = 1:length(d)
    s(i) = length(d{i});
end
d_all = zeros(sum(s),1);
coh_bw_all = zeros(sum(s),1);

start_idx = 1;
for i = 1:length(d)
    stop_idx = start_idx + s(i) - 1;
    d_all(start_idx:stop_idx) = d{i};
    coh_bw_all(start_idx:stop_idx) = coh_bw{i};
    start_idx = stop_idx + 1;
end

idx = find(d_all <0);
d_all(idx) = [];
coh_bw_all(idx) = [];


xWidth = 1;
yWidth = 1;
lineWidth = 3;
fontsize = 33;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
plot(d_all,coh_bw_all./1000,'*')
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
grid on;
box on;
%xlim([0 400]);
%ylim([0 0.03]);
xlabel('Distances(m)');
ylabel(' Coherence Bandwidth(kHz)');

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

