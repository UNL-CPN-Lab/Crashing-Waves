clc;
clear variables;
close all;

load rx_ofdm_iq_clean.mat
load header_full.mat
load evm_ts_gapped.mat
load preamble_time_shifted.mat
load pathloss_data_low_ref.mat
load KV_model.mat

font_size = 30;

freq = 5.8e9;
lamda = physconst('LightSpeed')/freq;

Overall_PSD_split = rx_ofdm_iq;

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
d_PL = linspace(0.001,max(ddd),100);
d_ref = 30.48;
r_PL = sqrt(d_PL.^2+l^2);

Theta_PL = asind((d_PL./r_PL));
delta_PL = (abs(Theta_PL-Theta(1))).*(pi/180);
d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];
theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);
K = interp2(d_range,theta,V_low,d_PL,delta_PL,'spline');
C = interp2(d_range,theta,C_low,d_PL,delta_PL,'spline');

X_g = normrnd(0,sdev,size(d_PL));




hV = 1.45;
hB = 0.87;

P1 = [d_PL.*cosd(25); d_PL.*sind(25); (hV - hB).*ones(1,length(d_PL))];
P2 = [l*cosd(65); -l*sind(65); 0].*ones(1,length(d_PL));
P3 = [(l.*d_PL)./(r_PL.*sind(65+asind(d_PL./r_PL))); zeros(1,length(d_PL)); zeros(1,length(d_PL))];
P4 = [d_PL.*cosd(25); d_PL.*sind(25); zeros(1,length(d_PL))];

h = (hV-hB).*(distance(P2,P3)./distance(P2,P4));

LOS_path = distance(P1,P2);

d2 = LOS_path .*(h./(hV-hB));

d1 = LOS_path - d2;

neu = -h.*sqrt((2/lamda).*((1./d1)+(1./d2)));

fun_real = @(s)cos(pi.*(s.^2)./2);
fun_imag = @(s)sin(pi.*(s.^2)./2);

real_loss = zeros(size(neu));
imag_loss = zeros(size(neu));

for i = 1:length(neu)
   real_loss(i) = integral(fun_real,0,neu(i)) ;
   imag_loss(i) = integral(fun_imag,0,neu(i)) ;
end

diff_loss = -20*log10(sqrt((1 - real_loss - imag_loss).^2 +  (real_loss - imag_loss).^2 )./2);

PL_calc = 91.861826 + 10*n_low*log10(LOS_path./d_ref);

hB = ones(size(d_PL)).*0.87;
hV = ones(size(d_PL)).*1.45;

X = [log10(d_PL(:)) (delta_PL(:)) log10(hB(:)) log10(hV(:)) ];

K = predict(mdl_angle,X) ;
C = predict(mdl_vehicle,X) ;

XX = [K C log10(hB(:)) log10(hV(:)) ];
Correction = predict(mdl_total,XX) ;

PL_corrected = PL_calc' + diff_loss' + Correction;

PL_actual = Gain - RSS(start:end_)';

xWidth = 0.8;
yWidth = 0.8;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
semilogx(ddd,Gain - RSS(start:end_)','*')
hold on
semilogx(d_PL,PL_corrected,'-d','Linewidth',3)
%plot(d_PL,PL_corrected2,'h')
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
grid on
box on
legend('Actual', 'Calculated','Location','Southeast')
xlim([1 1000])
ylim([60 130])
xlabel('Log Distance (m)', 'FontSize', font_size);
ylabel('Pathloss (dB)', 'FontSize', font_size,'Color','k');
print('Results/34agt2_87_PathLoss','-depsc');
print('Results/34agt2_87_PathLoss','-dpng');
savefig(strcat('Results/34agt2_87_PathLoss','.fig'));
d = flip(dd)-25;
PL = G - RSS(start:end_);
%save 'Results/Pathloss.mat' d PL 

d_34AGT2_87 = ddd;
PL_34AGT2_87 = Gain - RSS(start:end_)';
d_PL_34AGT2_87 = d_PL;
PL_corrected_34AGT2_87 = PL_corrected;
save PL_d_34AGT2_87.mat d_34AGT2_87 PL_34AGT2_87 d_PL_34AGT2_87 PL_corrected_34AGT2_87

