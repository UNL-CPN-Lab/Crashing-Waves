clc;
clear all;
close all;


load channel_est_post.mat
load evm_ts_gapped.mat
load MwRSF_Data.mat

pre_loc = [9:2:56]';
dat_loc = [9:31,34:56]';

N = 64;

channel_est_all = ones(N,size(channel_est_post,2)).*NaN;
channel_est_all(9:56,:) = channel_est_post;

channel_est_mag = abs(channel_est_all);
channel_est_phase = angle(channel_est_all);

pre_vec = [ones(size(pre_loc)) pre_loc];
dat_vec = [ones(size(dat_loc)) dat_loc];

for i = 1:length(frame_idx)
    pre_phase = channel_est_phase(pre_loc,frame_idx(i));
    pre_b = pre_vec\pre_phase;
    pre_phase_corrected = pre_b(1) + pre_b(2).*dat_loc;  
    channel_est_phase(dat_loc,frame_idx(i)) = pre_phase_corrected;
    for j = frame_idx(i)+1:frame_idx(i)+24
        dat_phase = channel_est_phase(dat_loc,j);
        dat_b = dat_vec\dat_phase;
        dat_phase_corrected = dat_b(1) + dat_b(2).*dat_loc;
        channel_est_phase(dat_loc,j) = dat_phase_corrected;
    end
end

distances = 0:50:400;
idx_cell = cell(size(distances));
for i = 1:length(distances)-1
    start_idx = distances(i);
    end_idx = start_idx+50;
    idx = find(dd>=start_idx & dd <end_idx);
    idx_cell{i} = idx;
    x = zeros(N,25);
    for j = 1:length(idx)
        pos = frame_idx(idx(j)):frame_idx(idx(j))+24;
        ph = channel_est_phase(:,pos);
        ph(isnan(ph))=0;
        x = x + ph;
    end
    x = x./length(idx);
    for j = 1:length(idx)
        pos = frame_idx(idx(j)):frame_idx(idx(j))+24;
        channel_est_phase(:,pos) = x;
    end
end

channel_est_cor = channel_est_mag.*exp(1j.*channel_est_phase);

csi_AGTB2_Omni = channel_est_cor;

idx_cell_AGTB2_Omni = idx_cell;

save AGTB2_Omni_csi.mat csi_AGTB2_Omni idx_cell_AGTB2_Omni

