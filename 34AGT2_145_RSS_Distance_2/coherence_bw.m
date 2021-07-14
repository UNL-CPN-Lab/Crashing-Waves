clc;
clear all;
close all;


load evm_ts_gapped.mat
%load channel_est_all_snr.mat
load channel_est_post.mat
load header_full.mat
load preamble_time_shifted.mat
load MwRSF_Data.mat

data_idx = [1:23,26:48];

coef_matrix = zeros(size(channel_est_post,1),length(frame_idx)-1);
coef_idx = zeros(1,length(frame_idx)-1);

%channel_est_post = channel_est_post;
%for i = 1:50
for i = 1:length(frame_idx)-1
    data_split = channel_est_post(data_idx,frame_idx(i):frame_idx(i+1)-1);
    data_split = data_split';
    coef_vec = zeros(1,size(data_split,2));
    for j = 1:size(data_split,2)
        coef_vec(j) = corr(data_split(:,2),data_split(:,j));
    end
    coef_matrix(data_idx,i) = coef_vec';
    idx = max(find(abs(coef_vec)>0.5));
    if  ~isempty(idx)
        coef_idx(i) = idx;
    end
end

% coef_abs = abs(coef_matrix);
% coef_mean = mean(coef_abs);
% coef_mean_move = movmean(coef_mean,10,'omitnan');



bw_full = 500e3;
N = 64;
bw_per_sc = bw_full/N;
coh_bw = bw_per_sc.*(coef_idx + (N-length(data_idx)));

distances = 0:50:400;
coh_bw_intereast = ones(1,length(distances)-1).*NaN;
coh_bw_ol_count = zeros(1,length(distances)-1);
coh_bw_count = zeros(1,length(distances)-1);
coef_small = abs(coef_matrix) <0.5;
coef_small = [coef_small, zeros(48,1)];

for i = 1:length(distances)-1
    start_idx = distances(i);
    end_idx = start_idx+50;
    idx = find(dd>=start_idx & dd <end_idx);
    [m,n] = rmoutliers(coh_bw(idx));
    coh_bw_intereast(i) = mean(m);
    coh_bw_ol_count(i) = sum(n)/length(n);
    p = coef_small(:,idx);
    coh_bw_count(i) = sum(p(:))/length(p(:));
end

xWidth = 0.8;
yWidth = 0.8;
lineWidth = 3;
fontsize = 40;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
h = plot(distances(1:end-1)+50,coh_bw_intereast./1000,'-*','LineWidth',lineWidth);
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
xticks([50 100 150 200 250 300 350 400]);
xticklabels({'0-50' '50-100' '100-150' '150-200' '200-250' '250-300' '300-350' '350-400'});
xlim([50 300]);
ylim([0 500]);
grid on;
box on;
xlabel('Distances(m)');
ylabel('Coherence Bandwidth (kHz)');

coh_bw_intereast_34AGT2_145 = coh_bw_intereast;
coh_bw_ol_count_34AGT2_145 = coh_bw_ol_count;
coh_bw_count_34AGT2_145 = coh_bw_count;
save 34AGT2_145_coh_bw.mat coh_bw_intereast_34AGT2_145 coh_bw_ol_count_34AGT2_145 coh_bw_count_34AGT2_145



