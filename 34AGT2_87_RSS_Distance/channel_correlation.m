clc;
clear all;
close all;

load evm_ts_gapped.mat
load channel_est_all.mat
load MwRSF_Data.mat
load preamble_time_shifted.mat
load PL_d_34AGT2_87.mat

format long g


Ts = 0.000002;
symbol_time = (128+64).*Ts;

n = 24;


corr_vec_full = ones(n,length(frame_idx)).*NaN;
for i = 1:length(frame_idx)
    ch_preamble = channel_est_all([1:23,25:47],frame_idx(i));
    corr_vec_container = 1;
    for j=1:size(corr_vec_full,1)
        ch_data = channel_est_all([1:23,25:47],frame_idx(i)+j);
        corr_vec_full(j,i) = corr(ch_preamble,ch_data);
    end  
end

plot([1:24].*symbol_time.*1000,corr_vec_full(:,100),'-*');hold on
plot([1:24].*symbol_time.*1000,corr_vec_full(:,200),'-d');
plot([1:24].*symbol_time.*1000,corr_vec_full(:,300),'-s');
plot([1:24].*symbol_time.*1000,corr_vec_full(:,400),'->');

% corr_vect = corr_vec_full(start:end_);
% 
% xWidth = 0.8;
% yWidth = 1;
% fontsize = 40;
% figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
% yyaxis left;
% plot(ddd,corr_vect*1e3,'*');
% ylim([0 30])
% ylabel('Coherrence time (ms)', 'FontSize', fontsize);
% hold on;
% yyaxis right;
% plot(d,v,'*');
% xlim([0 300])
% ylim([0 30])
% ylabel('Velocity (m/s)');
% xlabel('Distance (m)');
% set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
% 
% 
% print('Results/34agt2_87_Coherence','-depsc');
% print('Results/34agt2_87_Coherence','-dpng');
% savefig(strcat('Results/34agt2_87_Coherence','.fig'));
% 
% v_34AGT2_87 = v;
% d_34AGT2_87 = ddd;
% d_v_34AGT2_87 = d;
% CH_34AGT2_87 = corr_vect*1e3;
% 
% 
% save CH_d_34AGT2_87.mat v_34AGT2_87 CH_34AGT2_87  d_34AGT2_87 d_v_34AGT2_87
% 
