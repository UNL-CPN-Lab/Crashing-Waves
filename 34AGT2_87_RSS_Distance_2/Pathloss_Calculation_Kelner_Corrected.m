clc;
clear variables;
close all;

load rx_ofdm_iq_clean.mat
load header_full.mat
load evm_ts_gapped.mat
load preamble_time_shifted.mat
load pathloss_data_low_ref.mat


font_size = 30;

Overall_PSD_split = rx_ofdm_iq;

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
l = 3.66;
d = ddd;
h_rx = 0.8;
h_tx = 1.5;

Directional_Gain_Data = csvread('gain_chart.csv');
D_Gain = Directional_Gain_Data(:,2);

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
d_PL = linspace(min(ddd),max(ddd),100);
d_ref = 30.48;
PL_calc = 91.861826 + 10*n_low*log10(d_PL./d_ref);
r_PL = sqrt(d_PL.^2+l^2);
Theta_PL = asind((d_PL./r_PL));
delta_PL = (abs(Theta_PL-Theta(1))).*(pi/180);
d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];
theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);
K = interp2(d_range,theta,V_low,d_PL,delta_PL,'spline');
C = interp2(d_range,theta,C_low,d_PL,delta_PL,'spline');

alpha = 0.1;

PL_corrected = PL_calc +0.1.*K - alpha.*C;




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
xlim([20 260])
ylim([60 130])
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('Pathloss (dB)', 'FontSize', font_size,'Color','k');
print('Results/34agt2_87_PathLoss','-depsc');
print('Results/34agt2_87_PathLoss','-dpng');
savefig(strcat('Results/34agt2_87_PathLoss','.fig'));
d = flip(dd)-25;
PL = G - RSS(start:end_);
save 'Results/Pathloss.mat' d PL 

d_34AGT2_87 = ddd;
PL_34AGT2_87 = Gain - RSS(start:end_)';
d_PL_34AGT2_87 = d_PL;
PL_corrected_34AGT2_87 = PL_corrected;
save PL_d_34AGT2_87.mat d_34AGT2_87 PL_34AGT2_87 d_PL_34AGT2_87 PL_corrected_34AGT2_87
