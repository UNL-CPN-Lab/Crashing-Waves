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


fftc = rx_ofdm_iq;


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

%N = csvread('Results/34AG145.csv',1,0);





load MwRSF_Data.mat
G = 15.3;
l = 3.66;
d = ddd;
h_rx = 1.45;
h_tx = 1.5;

Directional_Gain_Data = csvread('gain_chart.csv');
D_Gain = Directional_Gain_Data(:,2);
%load regress_no_car.mat
%load regress_with_car.mat


r = sqrt(d.^2+l^2);
Theta = asind((d./r));
delta = abs(Theta-Theta(1));

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

hT = 1.88;
hR = 1.88;
hT0 = 1.5;
hR0 = 1.5;
h = (hT*hR)/(hT0*hR0);

PL_actual = Gain - RSS(start:end_)';
%constant = 20*log10(5.8e3)+32.44;
d_PL = ddd;
%d_PL = linspace(min(ddd),max(ddd),100);
d_ref = 30.48;
% idx_ref = min(find(d_PL<=d_ref));
% d_ref = d_PL(idx_ref);
% PL_calc = PL_actual(idx_ref) + 10*n_high*log10(d_PL./d_ref) ;
PL_calc = 96.524509 + 10*n_high*log10(d_PL./d_ref);
%PL_calc = constant+n_high.*(10*log10(abs(d_PL./1000)));
r_PL = sqrt(d_PL.^2+l^2);
Theta_PL = asind((d_PL./r_PL));
delta_PL = delta.*(pi/180);
d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];
theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);
K = interp2(d_range,theta,V_high,d_PL,0.*pi/180,'spline');
C = interp2(d_range,theta,C_high,d_PL,0.*pi/180,'spline');



PL_corrected = PL_calc + 0.1*C';

error = PL_actual-PL_corrected;

idx = find(ddd<=0);
error(idx) = 0;


st = (min(find(d_PL >=432)));
ed = (min(find(d_PL <=50)));


%plot(ddd,error,'d')
% xlim([50 400])



rms(error(st:ed-1),'omitnan')
rms(error(ed:end),'omitnan')

% d_WIDT1_188 = ddd;
% PL_WIDT1_188 = Gain - RSS(start:end_)';
% d_PL_WIDT1_188 = d_PL;
% PL_corrected_WIDT1_188  = PL_calc;
% save PL_d_WIDT1_188.mat d_WIDT1_188 PL_WIDT1_188 d_PL_WIDT1_188 PL_corrected_WIDT1_188 start end_

