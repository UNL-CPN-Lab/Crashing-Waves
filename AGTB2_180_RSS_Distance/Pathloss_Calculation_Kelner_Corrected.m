clc;
clear variables;
close all;

load rx_ofdm_iq_clean.mat
load header_full.mat
load evm_ts_gapped.mat
load preamble_time_shifted.mat
load pathloss_data_high_ref.mat
load KV_model.mat

UTC_of_start = 'July 19, 2017 12:42:13.230'; 
%UTC_of_start = 'July 19, 2017 12:47:07.230'; 
UTC_of_stop = 'July 19, 2017 12:53:36.599'; % ending time of reception
UTC_of_crash = 'July 19, 2017 12:53:35.345'; % ending time of reception
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

% xWidth = 0.8;
% yWidth = 0.8;
% figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
% plot(preamble_time_shifted,RSS)
% xlim([-20,20])
% ylim([-80,-30])


%N = csvread('Results/AGTB2.csv',1,0);

load MwRSF_Data.mat
G = 15.3;
l = 8.1;
d = ddd;


r = sqrt(d.^2+l^2-2*l*cosd(25)*d);
Theta = asind((d./r)*sind(25));
delta = abs(Theta-Theta(1));

h_rx = 1.8;
h_tx = 1.8;

Directional_Gain_Data = csvread('gain_chart.csv');
D_Gain = Directional_Gain_Data(:,2);
% load regress_no_car.mat
% load regress_with_car.mat

Gain = zeros(length(d),1);

for i = 1:length(delta)
    x1 = floor(delta(i));
    x2 = ceil(delta(i));
    y1 = D_Gain(x1+1);
    y2 = D_Gain(x2+1);
    x = delta(i);
    if x2 == x1
        Gain(i) = G + y1;
    else
        Gain(i) = G + y1 + (x - x1)*(y2-y1)/(x2-x1);
    end
end



constant = 20*log10(5.8e3)+32.44;
d_PL = linspace(1,max(ddd),100);
d_ref = 30.48;
PL_calc = 96.524509 + 10*n_high*log10(d_PL./d_ref);
r_PL = sqrt(d_PL.^2+l^2-2*l*cosd(25)*d_PL);
Theta_PL = asind((d_PL./r_PL)*sind(25));
delta_PL = (abs(Theta_PL-Theta(1))).*(pi/180);
d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];
theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);

hB = ones(size(d_PL)).*1.8;
hV = ones(size(d_PL)).*1.8;

X = [log10(d_PL(:)) (delta_PL(:)) log10(hB(:)) log10(hV(:)) ];

K = predict(mdl_angle,X) ;
C = predict(mdl_vehicle,X) ;

XX = [K C log10(hB(:)) log10(hV(:)) ];
Correction = predict(mdl_total,XX) ;

PL_corrected = PL_calc'  + Correction;

xWidth = 0.8;
yWidth = 0.8;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
plot(ddd,Gain - RSS(start:end_)','*')
hold on
plot(d_PL,PL_corrected,'d')

set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
grid on
box on
legend('Actual', 'Calculated','Location','Southeast')
xlim([0 300])
ylim([40 130])
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('Pathloss (dB)', 'FontSize', font_size,'Color','k');

print('Results/AGTB2_180_PL','-depsc');
print('Results/AGTB2_180_PL','-dpng');
savefig(strcat('Results/AGTB2_180_PL','.fig'));

d_AGTB2_180 = ddd;
PL_AGTB2_180 = Gain - RSS(start:end_)';
d_PL_AGTB2_180 = d_PL;
PL_corrected_AGTB2_180 = PL_corrected;
save PL_d_AGTB2_180.mat d_AGTB2_180 PL_AGTB2_180 d_PL_AGTB2_180 PL_corrected_AGTB2_180 start end_
