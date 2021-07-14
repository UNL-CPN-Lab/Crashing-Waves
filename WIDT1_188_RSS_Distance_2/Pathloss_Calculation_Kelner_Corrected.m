clc;
clear variables;
close all;

load rx_ofdm_iq_clean.mat
load header_full.mat
load evm_ts_gapped.mat
load preamble_time_shifted.mat
load pathloss_data_high_ref.mat

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
Directional_Gain_Data = csvread('gain_chart.csv');
D_Gain = Directional_Gain_Data(:,2);


G = 15.3;
d = ddd;
h_rx = 1.88;
h_tx = 1.88;

Gain = ones(length(d),1)*(G+28);

n = 2.21821821821822 ; % upper
constant = 20*log10(5.8e3)+32.44;
d_PL = linspace(min(ddd),max(ddd),100);
d_ref = 30.48;
PL_calc = 96.524509 + 10*n_high*log10(d_PL./d_ref);

d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];
theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);
K = interp2(d_range,theta,V_high,d_PL,0*(pi/180),'spline');
C = interp2(d_range,theta,C_high,d_PL,0*pi/180,'spline');
PL_calc = PL_calc +0 -0;
PL_calc = PL_calc + 0.1*C;


% constant = 20*log10(5.8e3)+32.44;
% d_PL = linspace(min(ddd),max(ddd),100);
% PL_calc = constant+n_low.*(10*log10(abs(d_PL./1000)));
% r_PL =  sqrt(d_PL.^2+l^2-2*l*cosd(115)*d_PL);
% Theta_PL = asind((d_PL./r_PL)*sind(115));
% delta_PL = (abs(Theta_PL-Theta(1))).*(pi/180);
% d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];
% theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);
% K = interp2(d_range,theta,V_low,d_PL,delta_PL,'spline');
% C = interp2(d_range,theta,C_low,d_PL,delta_PL,'spline');
% 
% PL_corrected = PL_calc + K-C;


xWidth = 0.8;
yWidth = 0.8;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
plot(ddd,Gain - RSS(start:end_)','*')
hold on
plot(d_PL,PL_calc,'d')

set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
grid on
box on
legend('Actual', 'Calculated','Location','Southeast')
xlim([0 350])
ylim([60 130])
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('Pathloss (dB)', 'FontSize', font_size,'Color','k');

print('Results/WIDT1_188_PL','-depsc');
print('Results/WIDT1_188_PL','-dpng');
savefig(strcat('Results/WIDT1_188_PL','.fig'));


d_WIDT1_188 = ddd;
PL_WIDT1_188 = Gain - RSS(start:end_)';
d_PL_WIDT1_188 = d_PL;
PL_corrected_WIDT1_188  = PL_calc;
save PL_d_WIDT1_188.mat d_WIDT1_188 PL_WIDT1_188 d_PL_WIDT1_188 PL_corrected_WIDT1_188 start end_

% load sinr_ber.mat
% 
% figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
% yyaxis left
% plot(preamble_time_shifted,RSS,'*','Color','b');
% ylim([-90 2-40])
% ylabel('RSS (dBm)', 'FontSize', font_size);
% hold on;
% yyaxis right
% plot(preamble_time_shifted,frame_ber,'d','Color','r')
% set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
% grid on
% box on
% %xlim([-20 20])
% ylim([0 1])
% ylabel('BER', 'FontSize', font_size);
% xlabel('Time (s)', 'FontSize', font_size,'Color','k');
