clc;
close all;

clear all;


load 34AGT2_87_csi.mat
load 34AGT2_145_csi.mat
load AGTB2_180_csi.mat
load AGTB2_Omni_csi.mat
load KIA_csi.mat
load NJPCB_180_csi.mat
load NJPCB_Omni_csi.mat
load WIDT1_188_csi.mat

load 34AGT2_87_frame_idx.mat
load 34AGT2_145_frame_idx.mat
load AGTB2_180_frame_idx.mat
load AGTB2_Omni_frame_idx.mat
load KIA_frame_idx.mat
load NJPCB_180_frame_idx.mat
load NJPCB_Omni_frame_idx.mat
load WIDT1_188_frame_idx.mat

load 34AGT2_87_d.mat
load 34AGT2_145_d.mat
load AGTB2_180_d.mat
load AGTB2_Omni_d.mat
load KIA_d.mat
load NJPCB_180_d.mat
load NJPCB_Omni_d.mat
load WIDT1_188_d.mat

dat_loc = [9:31,34:56];

t_samp = 1/(500e3);
t = (0:63).*t_samp;
t = t(dat_loc)';




% csi_34AGT2_87(isnan(csi_34AGT2_87))=0;
% csi_34AGT2_145(isnan(csi_34AGT2_145))=0;
% csi_AGTB2_180(isnan(csi_AGTB2_180))=0;
% csi_AGTB2_Omni(isnan(csi_AGTB2_Omni))=0;
% csi_KIA(isnan(csi_KIA))=0;
% csi_NJPCB_180(isnan(csi_NJPCB_180))=0;
% csi_NJPCB_Omni(isnan(csi_NJPCB_Omni))=0;
% csi_WIDT1_188(isnan(csi_WIDT1_188))=0;

idx = {idx_cell_34AGT2_145, idx_cell_AGTB2_180, idx_cell_NJPCB_180, idx_cell_WIDT1_188};

csi = {csi_34AGT2_145, csi_AGTB2_180, csi_NJPCB_180, csi_WIDT1_188};

d = {d_34AGT2_145, d_AGTB2_180, d_NJPCB_180, d_WIDT1_188};

frame_idx = {frame_idx_34AGT2_145, frame_idx_AGTB2_180, frame_idx_NJPCB_180, frame_idx_WIDT1_188};

coh_bw_1 = zeros(size(frame_idx_34AGT2_145));

coh_bw_2 = zeros(size(frame_idx_AGTB2_180));

coh_bw_3 = zeros(size(frame_idx_NJPCB_180));

coh_bw_4 = zeros(size(frame_idx_WIDT1_188));

coh_bw = {coh_bw_1, coh_bw_2, coh_bw_3, coh_bw_4};

cohbw = zeros(1,25);

symb_bw = 500e3/64;

for i = 1:length(csi)
    for j = 1:length(frame_idx{i})
        slice = frame_idx{i}(j):frame_idx{i}(j)+24;
        fs = csi{i}(:,slice);
        for k = 1:25
            P_x = 20*log10(abs(fs(dat_loc,k))./(max(abs(fs(dat_loc,k)))));
            idx = find(P_x < -15);
            if  isempty(idx)
                cohbw(k) = length(P_x)*symb_bw;
            else
                cohbw(k) = (idx(1)-1)*symb_bw;
            end
        end
        coh_bw{i}(j) = mean(cohbw);
    end
end

% for i = 1:length(rms)
%     plot(d{i},1./(5*rms{i}),'*')
%     hold on
% end
% 
% save rms_high.mat rms

save coh_bw_high.mat coh_bw


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

total = [d_all coh_bw_all];
total = sortrows(total);
d_all = total(:,1);
coh_bw_all = total(:,2);

idx = find(d_all <0 );
d_all(idx) = [];
coh_bw_all(idx) = [];
idx = [3200:44250 45400:55425];
d_all(idx) = [];
coh_bw_all(idx) = [];

xWidth = 1;
yWidth = 1;
lineWidth = 3;
fontsize = 33;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
plot(d_all,coh_bw_all/1e3,'*')
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
grid on;
box on;
xlim([0 450]);
%ylim([0 30]);
xlabel('Distances(m)');
ylabel('Coherence Bandwidth (kHz)');
