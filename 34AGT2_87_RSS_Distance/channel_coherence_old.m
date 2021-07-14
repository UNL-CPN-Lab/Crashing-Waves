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


corr_vec = ones(1,length(frame_idx)).*NaN;
max = 0;
for i = 1:length(frame_idx)
    ch_preamble = channel_est_all([1:23,25:47],frame_idx(i));
    corr_vec_container = 1;
    j = 0;
    while corr_vec_container > 0.75
        j = j+1;
        ch_data = channel_est_all([1:23,25:47],frame_idx(i)+j);
        corr_vec_container = corr(ch_preamble,ch_data);
    end
    if max <j
        max = j;
    end
    corr_vec(i) =symbol_time*(j-1);
    
end

corr_vect_chopped = corr_vec(start:end_);

xWidth = 0.8;
yWidth = 1;
fontsize = 40;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
plot(vv,corr_vect_chopped*1e3,'*');
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
hold off;
xlabel('Velocity (m/s)');
ylabel('Coherrence time (ms)');
xlim([0 25])

print('Results/34agt2_87_Coherence','-depsc');
print('Results/34agt2_87_Coherence','-dpng');
savefig(strcat('Results/34agt2_87_Coherence','.fig'));

v_34AGT2_87 = vv;
CH_34AGT2_87 = corr_vect_chopped*1e3;


save CH_d_34AGT2_87.mat v_34AGT2_87 CH_34AGT2_87 

%plot(linspace(-20,20,length(v)),v,'*');

%plot(preamble_time_shifted,corr_vec*1e3,'*');


% T = readmatrix('out_file_gps.csv');
% velocity = T(:,6);
% t = T(:,8);
% crash_time = 1494353684;
% t = t-crash_time;
% 
% plot(t+10,velocity);
% xlim([-30 20])

% UTC_of_start = 'May 09, 2017 13:09:22.000'; 
% UTC_of_stop = 'May 09, 2017 13:23:20.000'; % ending time of reception
% UTC_of_crash = 'May 09, 2017 13:14:26.000'; % ending time of reception
% Ts = 0.000002;
% symbol_time = (128+64).*Ts;
% start_time = datevec(UTC_of_start,'mmmm dd, yyyy HH:MM:SS.FFF');
% stop_time = datevec(UTC_of_stop,'mmmm dd, yyyy HH:MM:SS.FFF');
% crash_time = datevec(UTC_of_crash,'mmmm dd, yyyy HH:MM:SS.FFF');
%  get_num_of_secs(crash_time,stop_time)
%  n = 335;
