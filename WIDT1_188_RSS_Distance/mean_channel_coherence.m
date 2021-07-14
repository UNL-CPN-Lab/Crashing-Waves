%% Post processing
% SNR, EVM, PE
clc;
clear variables;
close all;
load evm_ts_gapped.mat
load channel_est_all.mat
load header_full.mat
load preamble_time_shifted.mat
load MwRSF_Data.mat

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
Ts = 0.000002;
symbol_time = (128+64).*Ts;

slit = 50;



% preamble_time = header_time(frame_idx);
% frames_time = header_time([1:len_frames]);

velocityslots = zeros(1,4);
velocityslots(1) = min(find((diff(vv)~=0)));
velocityslots(2) = min(find((abs(vv)>=max(vv)/4)));
velocityslots(3) = min(find((abs(vv)>=max(vv)/2)));
velocityslots(4) = min(find((abs(vv)>=max(vv))));

legendtext = cell(size(velocityslots));

for i = 1:length(velocityslots)
    legendtext{i} = strcat('v=',num2str(vv(velocityslots (i))),'m/s','; d=',num2str(dd(velocityslots (i))),'m');
end


colors = {'b', 'r', 'g', 'k'};
pe_p_vec = NaN.*ones(4,24);
evm_k_vec = NaN.*ones(4,24);
coherence_vec = NaN.*ones(4,24);
std_vec = NaN.*ones(4,24);

for i=1:length(velocityslots)
    slots = velocityslots(i);

    
    start_idx = slots;
    %[~,end_idx] = min(abs(preamble_time-slots(2)));
    end_idx = start_idx + slit - 1;
    
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


hlines = plot([1:24].*symbol_time.*1000,coherence_vec.','-*');
set(hlines,'LineWidth',lineWidth);
for i = 1:length(hlines)
    hlines(i).Marker = markers{i};
    hlines(i).MarkerSize = 10;
end
legend(legendtext,'Location','Northeast');
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
%xlabel('Number of OFDM Symbols');
xlabel('Time Offset (ms)');
ylabel('Correlation Coefficient');
grid on;
grid minor;
box on;
print('Results/WIDT_188_Correlation_Coeff','-depsc');
print('Results/WIDT_188_Correlation_Coeff','-dpng');
savefig(strcat('Results/WIDT_188_Correlation_Coeff','.fig'));
