clc;
clear all;
close all;

load evm_ts_gapped.mat
%load channel_est_all_snr.mat
load channel_est_post.mat
load header_full.mat
load preamble_time_shifted.mat
load MwRSF_Data.mat
load frame_ber.mat

data_idx = [1:23,26:48];

coef_matrix = zeros(size(channel_est_post,1),length(frame_idx)-1);
coef_idx = zeros(1,length(frame_idx));

channel_est_post = [channel_est_post, NaN.*ones(size(channel_est_post,1),100)];

%channel_est_post = channel_est_post;
%for i = 1:50
for i = 1:length(frame_idx)
    data_split = channel_est_post(data_idx,frame_idx(i):frame_idx(i)+100);
    %data_split = data_split';
    coef_vec = zeros(1,size(data_split,2));
    for j = 1:size(data_split,2)
        coef_vec(j) = corr(data_split(:,2),data_split(:,j));
    end
 
    idx = max(find(abs(coef_vec)>0.5));
    if  ~isempty(idx)
        coef_idx(i) = idx;
    end
end




Ts = 0.000002;
symbol_time = (128+64).*Ts;
coh_time = symbol_time.*coef_idx ;

velicities = 0:3:30;
coh_time_intereast = ones(1,length(velicities)-1).*NaN;
coh_time_count = zeros(1,length(velicities)-1);

l = 8.1;
r = sqrt(dd.^2+l^2-2*l*cosd(25)*dd);
Theta = asind((l./r)*sind(25));


vvv = vv.*cosd(Theta);

for i = 1:length(velicities)-1
    start_idx = velicities(i);
    end_idx = start_idx+3;
    idx = find(vvv>=start_idx & vvv <end_idx);
    coh_time_count(i) = length(idx);
    coh_time_intereast(i) = mean(coh_time(idx));
    
end

ber_intereast = ones(1,length(velicities)-1).*NaN;

for i = 1:length(velicities)-1
    start_idx = velicities(i);
    end_idx = start_idx+3;
    idx = find(vvv>=start_idx & vvv <end_idx);
    ber_intereast(i) = mean(frame_ber(idx));
    
end

xWidth = 1;
yWidth = 1;
lineWidth = 3;
fontsize = 33;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
h = plot(velicities(1:end-1)+3,coh_time_intereast.*1000,'-*','LineWidth',lineWidth);
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
xticks([3 6 9 12 15 18 21 24 27 30]);
xticklabels({'0-3' '3-6' '6-9' '9-12' '12-15' '15-18' '18-21' '21-24' '24-27' '27-30'});
xlim([3 30]);
ylim([0 50]);
grid on;
box on;
xlabel('Velocities(m/s)');
ylabel('Coherence Time (ms)');

coh_time_intereast_AGTB2_Omni = coh_time_intereast;
coh_time_count_AGTB2_Omni = coh_time_count;
ber_intereast_AGTB2_Omni = ber_intereast;
save AGTB2_Omni_coh_time.mat coh_time_intereast_AGTB2_Omni coh_time_count_AGTB2_Omni ber_intereast_AGTB2_Omni

