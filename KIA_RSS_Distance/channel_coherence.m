clc;
clear all;
close all;

load evm_ts_gapped.mat
load channel_est_all.mat
load MwRSF_Data.mat
load preamble_time_shifted.mat
load PL_d_KIA.mat

format long g


Ts = 0.000002;
symbol_time = (128+64).*Ts;


corr_vec_full = ones(1,length(frame_idx)).*NaN;
max_similarity = 0;
for i = 1:length(frame_idx)
    ch_preamble = channel_est_all([1:23,25:47],frame_idx(i));
    corr_vec_container = 1;
    j = 0;
    while corr_vec_container > 0.75
        j = j+1;
        ch_data = channel_est_all([1:23,25:47],frame_idx(i)+j);
        corr_vec_container = corr(ch_preamble,ch_data);
    end
    if max_similarity <j
        max_similarity = j;
    end
    corr_vec_full(i) =symbol_time*(j-1);
    
end

corr_vect = corr_vec_full(start:end_);

xWidth = 0.8;
yWidth = 1;
fontsize = 40;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
yyaxis left;
plot(ddd,corr_vect*1e3,'*');
ylim([0 30])
ylabel('Coherrence time (ms)', 'FontSize', fontsize);
hold on;
yyaxis right;
plot(d,v,'*');
xlim([0 300])
ylim([0 30])
ylabel('Velocity (m/s)');
xlabel('Distance (m)');
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
grid on
box on

print('Results/KIA_Coherence','-depsc');
print('Results/KIA_Coherence','-dpng');
savefig(strcat('Results/KIA_Coherence','.fig'));

v_KIA = v;
d_KIA = ddd;
d_v_KIA = d;
CH_KIA = corr_vect*1e3;


save CH_d_KIA.mat v_KIA CH_KIA  d_v_KIA d_KIA

