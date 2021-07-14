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




csi_34AGT2_87(isnan(csi_34AGT2_87))=0;
csi_34AGT2_145(isnan(csi_34AGT2_145))=0;
csi_AGTB2_180(isnan(csi_AGTB2_180))=0;
csi_AGTB2_Omni(isnan(csi_AGTB2_Omni))=0;
csi_KIA(isnan(csi_KIA))=0;
csi_NJPCB_180(isnan(csi_NJPCB_180))=0;
csi_NJPCB_Omni(isnan(csi_NJPCB_Omni))=0;
csi_WIDT1_188(isnan(csi_WIDT1_188))=0;

idx = {idx_cell_34AGT2_145, idx_cell_AGTB2_180, idx_cell_NJPCB_180, idx_cell_WIDT1_188};

csi = {csi_34AGT2_145, csi_AGTB2_180, csi_NJPCB_180, csi_WIDT1_188};

d = {d_34AGT2_145, d_AGTB2_180, d_NJPCB_180, d_WIDT1_188};

frame_idx = {frame_idx_34AGT2_145, frame_idx_AGTB2_180, frame_idx_NJPCB_180, frame_idx_WIDT1_188};

rms1 = zeros(size(frame_idx_34AGT2_145));

rms2 = zeros(size(frame_idx_AGTB2_180));

rms3 = zeros(size(frame_idx_NJPCB_180));

rms4 = zeros(size(frame_idx_WIDT1_188));

rms = {rms1, rms2, rms3, rms4};

r = zeros(1,25);

for i = 1:length(csi)
    for j = 1:length(frame_idx{i})
        slice = frame_idx{i}(j):frame_idx{i}(j)+24;
        ts = ifft(csi{i}(:,slice));
        for k = 1:25
            P_x = 20*log10(abs(ts(dat_loc,k))./(max(abs(ts(dat_loc,k))))) -5;
            idx = find(P_x > -20);
            r(k) = rms_delay_spread(t(idx),abs(ts(idx,k)).^2);
        end
        rms{i}(j) = mean(r);
    end
end

for i = 1:length(rms)
    plot(d{i},1./(5*rms{i}),'*')
    hold on
end

save rms_high.mat rms
