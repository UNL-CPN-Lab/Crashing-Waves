%% Post processing
% SNR, EVM, PE
clc;
clear variables;
close all;
% load rx_ofdm_iq.mat
load evm_ts_gapped.mat
load channel_est_all.mat
load header_full.mat
dat_loc = [9:31,34:56];

xWidth = 0.8;
yWidth = 0.8;
missingLineHeight = 25;
lineWidth = 3;
fontsize = 40;
transperency = 0.2;
marker_num = 10;
markersize = 14;


%%
UTC_of_start = 'May 09, 2017 13:14:21.617'; 
UTC_of_stop = 'May 09, 2017 13:14:31.074'; % ending time of reception
UTC_of_crash = 'May 09, 2017 13:14:26.064'; % ending time of reception
Ts = 0.000002;
symbol_time = (128+64).*Ts;
start_time = datevec(UTC_of_start,'mmmm dd, yyyy HH:MM:SS.FFF');
stop_time = datevec(UTC_of_stop,'mmmm dd, yyyy HH:MM:SS.FFF');
crash_time = datevec(UTC_of_crash,'mmmm dd, yyyy HH:MM:SS.FFF');

header_index = 1:length(header_full);
header_time = header_index.*symbol_time;
unprocessed_time = symbol_time.*(len_frames - frame_idx(end));

crash_sec = header_time(end) + unprocessed_time - get_num_of_secs(crash_time,stop_time);
car_start_sec = header_time(end) + unprocessed_time - 81;
car_stop_sec = crash_sec + 5;
tc = crash_sec;
tbs =  - 19;
tbm =  -1.5;
ta =  4;
slit = 0.5;




%% Add Missing Gaps

% header_empty = isnan(header_full);
% nan_loc = find(header_empty==1);
% val_loc = find(header_empty==0);
% header_miss=NaN.*ones(size(header_full));
% header_miss(header_empty==1)=1;%mean([nanmin(header_full),nanmax(header_full)]);
% 
% % [lia,locb] = ismember(used_frame_idx,frame_idx);
% % evm1_ts_gap = evm1_ts(locb(lia));
% 
preamble_time = header_time(frame_idx);
frames_time = header_time([1:len_frames]);


%% 150-163, 165-175, 175-183, 185-195
%timeslots = {[40,46],[82,88],[90,97],[120,126]};
timeslots = {[tbs+tc - slit,tbs+tc + slit],[tbm+tc - slit,tbm+tc + slit],[tc - slit,tc + slit],[ta+tc-slit,ta+tc+slit]};
legendtext = {'Pre Crash Moving','Post Crash'};
% h1 = figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
% h2 = figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
% h3 = figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
% h4 = figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
markers = {'->','s','d','x'};
colors = {'b', 'r', 'g', 'k'};
pe_p_vec = NaN.*ones(4,24);
evm_k_vec = NaN.*ones(4,24);
coherence_vec = NaN.*ones(4,24);
std_vec = NaN.*ones(4,24);

for i=[2,4]
    slots = timeslots{i};
    %% CDFs
    [~,start_idx] = min(abs(preamble_time-slots(1)));
    [~,end_idx] = min(abs(preamble_time-slots(2)));

    
    
    %% Channel Coherence
    preambles = frame_idx(start_idx:end_idx);
    for j = 1:24
        ch_preambles = channel_est_all([1:23,25:47],preambles);
        ch_data = channel_est_all([1:23,25:47],preambles+j);
        coef_vec = zeros(1,size(ch_data,2));
        for fn = 1:size(ch_data,2)
            coef_vec(fn) = corr(ch_preambles(:,fn),ch_data(:,fn));
        end
        coherence_vec(i,j) = nanmean(coef_vec);
        std_vec(i,j) = nanstd(abs(coef_vec));
    end
end




markers = {'>','s','d','x'};

figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
%hlines = plot(abs(coherence_vec).','-+');
hlines = plot([1:24].*symbol_time.*1000,coherence_vec.','-*');
set(hlines,'LineWidth',lineWidth);
for i = 1:length(hlines)
    hlines(i).Marker = markers{i};
    hlines(i).MarkerSize = 10;
end
legend(legendtext,'Location','best');
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
%xlabel('Number of OFDM Symbols');
xlabel('Time Offset (ms)');
ylabel('Correlation Coefficient');
grid on;
%grid minor;
% print('Results_VNC/34agt2_87_Correlation_Coeff','-depsc');
% print('Results_VNC/34agt2_87_Correlation_Coeff','-dpng');
% savefig(strcat('Results_VNC/34agt2_87_Correlation_Coeff','.fig'));
