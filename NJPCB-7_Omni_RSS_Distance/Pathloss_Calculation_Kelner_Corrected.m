clc;
clear variables;
close all;

load rx_ofdm_iq_clean.mat
load header_full.mat
load evm_ts_gapped.mat
load preamble_time_shifted.mat
load pathloss_data_low_ref.mat
load KV_model.mat

UTC_of_start = 'July 12, 2017 11:28:13.374'; 
%UTC_of_start = 'July 19, 2017 12:47:07.230'; 
UTC_of_stop = 'July 12, 2017 11:37:15.527'; % ending time of reception
UTC_of_crash = 'July 12, 2017 11:37:14.322'; % ending time of reception
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

load MwRSF_Data.mat
G = 15.3;
l = 6.5;
d = ddd;


r = sqrt(d.^2+l^2-2*l*cosd(25)*d);
Theta = asind((d./r)*sind(25));
delta = abs(Theta-Theta(1));

h_rx = 1.8;
h_tx = 1.8;

Directional_Gain_Data = csvread('gain_chart.csv');
D_Gain = Directional_Gain_Data(:,2);


Gain = 10+5.3+5.3;
Gain_Omni = 20;



n = 2.12812812812813; %  Lower
constant = 20*log10(5.8e3)+32.44;
d_PL = linspace(1,300,100);

r_PL = sqrt(d_PL.^2+l^2-2*l*cosd(25)*d_PL);
Theta_PL = asind((d_PL./r_PL)*sind(25));
delta_PL = abs(Theta_PL-Theta_PL(1));

d_ref = 30.48;
PL_calc = 91.861826 + 10*n_low*log10(d_PL./d_ref);

d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];
theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);
%C = interp2(d_range,theta,C_low,d_PL,0*pi/180,'spline');
X_g = normrnd(0,sdev,size(d_PL));

hB = ones(size(d_PL)).*0.82;
hV = ones(size(d_PL)).*1.8;

X = [log10(d_PL(:)) (delta_PL(:)) log10(hB(:)) log10(hV(:)) ];

K = zeros(size(d_PL));
C = predict(mdl_vehicle,X) ;

XX = [K(:) C(:) log10(hB(:)) log10(hV(:)) ];
Correction = predict(mdl_total,XX) ;

PL_corrected = PL_calc'  + Correction;


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

print('Results/NJPCB7_Omni_PL','-depsc');
print('Results/NJPCB7_Omni_PL','-dpng');
savefig(strcat('Results/NJPCB7_Omni_PL','.fig'));

d_NJPCB7_Omni = ddd;
PL_NJPCB7_Omni = Gain - RSS(start:end_)';
d_PL_NJPCB7_Omni = d_PL;
PL_corrected_NJPCB7_Omni  = PL_calc;
save PL_d_NJPCB7_Omni.mat d_NJPCB7_Omni PL_NJPCB7_Omni d_PL_NJPCB7_Omni PL_corrected_NJPCB7_Omni start end_
