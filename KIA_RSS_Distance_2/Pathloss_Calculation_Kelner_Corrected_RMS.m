clc;
clear variables;
close all;

load rx_ofdm_iq_clean.mat
load header_full.mat
load evm_ts_gapped.mat
load preamble_time_shifted.mat
load pathloss_data_low_ref.mat




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

constant = 20*log10(5.8e3)+32.44;
d_PL = ddd;
d_PL = linspace(min(ddd),max(ddd),100);
%PL_calc = constant+n_high.*(10*log10(abs(d_PL./1000)));
r_PL = sqrt(d_PL.^2+l^2);
Theta_PL = asind((d_PL./r_PL));
delta_PL = delta.*(pi/180);
d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];
theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);
K = interp2(d_range,theta,V_low,d_PL,delta_PL,'spline');
C = interp2(d_range,theta,C_low,d_PL,delta_PL,'spline');
PL_actual = Gain - RSS(start:end_)';

d_ref = 30.48;
% idx_ref = min(find(d_PL<=d_ref));
% d_ref = d_PL(idx_ref);
% PL_calc = PL_actual(idx_ref) + 10*n_low*log10(d_PL./d_ref);
PL_calc = 91.861826 + 10*n_low*log10(d_PL./d_ref);
alpha = 0.1;

PL_corrected = PL_calc + 0.1.*K - alpha.*C;
% PL_corrected = PL_calc;
% PL_corrected = PL_calc - K+C;

error = PL_actual-PL_corrected;

st = (min(find(d_PL >=245)));
ed = (min(find(d_PL <=50)));


% plot(ddd,error,'d')
% xlim([50 400])

error(find(d_PL <= 0)) = 0;

rms(error(st:ed-1),'omitnan')
rms(error(ed:end),'omitnan')
r_square(RSS_actual,RSS_corrected)

% d_KIA = ddd;
% PL_KIA = Gain - RSS(start:end_)';
% d_PL_KIA = d_PL;
% PL_corrected_KIA = PL_corrected;
% save PL_d_KIA.mat d_KIA PL_KIA d_PL_KIA PL_corrected_KIA start end_
