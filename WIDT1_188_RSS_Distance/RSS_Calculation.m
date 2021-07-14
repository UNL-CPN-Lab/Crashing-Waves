clc;
clear variables;
close all;

load rx_ofdm_iq_clean.mat
load header_full.mat
load evm_ts_gapped.mat
load preamble_time_shifted.mat

UTC_of_start = 'May 30, 2017 13:37:08.989'; 
UTC_of_stop = 'May 30, 2017 13:45:56.218'; % ending time of reception
UTC_of_crash = 'May 30, 2017 13:44:08.406'; % ending time of reception
Ts = 0.000002;
symbol_time = (128+64).*Ts;
start_time = datevec(UTC_of_start,'mmmm dd, yyyy HH:MM:SS.FFF');
stop_time = datevec(UTC_of_stop,'mmmm dd, yyyy HH:MM:SS.FFF');
crash_time = datevec(UTC_of_crash,'mmmm dd, yyyy HH:MM:SS.FFF');

header_index = 1:length(header_full);
header_time = header_index.*symbol_time;
unprocessed_time = symbol_time.*(len_frames - frame_idx(end));

crash_sec = header_time(end) + unprocessed_time - get_num_of_secs(crash_time,stop_time);
car_start_sec = preamble_time(end)-30;
car_stop_sec = preamble_time(end);

min_time = -35;
max_time = 25;
xWidth = 0.8;
yWidth = 1;
font_size = 30;
transperency = 0.2;

%fftc = read_complex_binary('ofdm_receiver-fft_out_c.dat');

fftc = rx_ofdm_iq;





%fftc=fftc(10044225:10931904);

Overall_PSD_split = fftc;

%Overall_PSD_split = Overall_PSD_split(156942:170811,:);




%c=-105.77; %evaluated with IQ_calibration
c = -100.999;
sample_rate=500000;
cp_length=128;  
delta_t=(64+128)/sample_rate;


PSD = (10*log10(sum(real(Overall_PSD_split).^2+imag(Overall_PSD_split).^2)/delta_t))+c;

RSS = zeros(1,length(frame_idx));



for i = 1: length(frame_idx)-1
    RSS(i) = mean(PSD(frame_idx(i):frame_idx(i+1)));
   
end

%N = csvread('Results/WIDT.csv',1,0);




load MwRSF_Data.mat


xWidth = 0.8;
yWidth = 0.8;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
plot(ddd, RSS(start:end_)','*')
hold on

set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');

grid on
box on
xlim([0 430])
ylim([-90 -40])
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','k');
print('Results/WIDT1_188_RSS','-depsc');
print('Results/WIDT1_188_RSS','-dpng');
savefig(strcat('Results/WIDT1_188_RSS','.fig'));
d = flip(dd)-269;

save 'Results/Pathloss.mat' d 

d_WIDT1_188 = ddd;
RSS_WIDT1_188 = RSS(start:end_);
save RSS_d_WIDT1_188.mat d_WIDT1_188 RSS_WIDT1_188
