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

%N = csvread('Results/KIA.csv',1,0);

load MwRSF_Data.mat
%load MwRSF_Data2.mat
G = 15.3;
l = 6.096;
d = ddd;


r = sqrt(d.^2+l^2-2*l*cosd(115)*d);
Theta = asind((d./r)*sind(115));
delta = abs(Theta-Theta(1));

h_rx = 1.0;
h_tx = 1.45;

Directional_Gain_Data = csvread('gain_chart.csv');
D_Gain = Directional_Gain_Data(:,2);


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
d_PL = ddd';
d_ref = 30.48;

r_PL =  sqrt(d_PL.^2+l^2-2*l*cosd(115)*d_PL);
Theta_PL = asind((d_PL./r_PL)*sind(115));
delta_PL = (abs(Theta_PL-Theta(1))).*(pi/180);
d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];
theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);
% K = interp2(d_range,theta,V_low,d_PL,delta_PL,'spline');
% C = interp2(d_range,theta,C_low,d_PL,delta_PL,'spline');



%PL_calc = 91.861826 + 10*n_low*log10(d_PL./d_ref);
alpha = 0.1;

%PL_corrected = PL_calc + 0.1.*K - alpha.*C;

%PL_corrected = PL_calc + K-C;

hV = 1.45;
hBs = [0.394, 0.584, 0.775, 0.965];
diff_loss = zeros(length(hBs),length(d_PL));

for ii = 1:length(hBs)
    hB = hBs(ii);
    

    P1 = [d_PL.*cosd(25); d_PL.*sind(25); (hV - hB).*ones(1,length(d_PL))];
    P2 = [0; -l; 0].*ones(1,length(d_PL));
    P3 = [l.*tand(Theta_PL); zeros(1,length(d_PL)); zeros(1,length(d_PL))];
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

    diff_loss(ii,:) = -20*log10(sqrt((1 - real_loss - imag_loss).^2 +  (real_loss - imag_loss).^2 )./2);

end


PL_calc = 91.861826 + 10*n_low*log10(LOS_path./d_ref);

hB = ones(size(d_PL)).*0.965;
hV = ones(size(d_PL)).*1.45;

X = [log10(d_PL(:)) (delta_PL(:)) log10(hB(:)) log10(hV(:)) ];

K = predict(mdl_angle,X) ;
C = predict(mdl_vehicle,X) ;

XX = [K C log10(hB(:)) log10(hV(:)) ];
Correction = predict(mdl_total,XX) ;

PL_corrected = PL_calc' + sum(diff_loss)' + Correction;




PL_actual = Gain - RSS(start:end_)';

error = PL_actual-PL_corrected;
% 
% st = (min(find(d_PL >=245)));
% ed = (min(find(d_PL <=50)));


% plot(ddd,error,'d')
% xlim([50 400])

% plot(d_PL,PL_actual)
% hold on
% plot(d_PL,PL_corrected)
% xlim([0 250])
% box on
% grid on
% grid minor

idx = find(d_PL <= 0);
error(idx) = [];
d_PL(idx) = [];

st = (min(find(d_PL >=245)));
ed = (min(find(d_PL <=50)));

rms(error(st:ed-1),'omitnan')
rms(error(ed:end),'omitnan')
rms(error,'omitnan')
PL_actual(idx) = [];
PL_corrected(idx) = [];
%r_square(PL_actual,PL_corrected)
% figure;
% h1 = histfit(error,50,'normal');
% print('Results/KIA_Normal_Hist','-dpng');
% 
% figure;
% h2 = histfit(error.^2,50,'rician');
% print('Results/KIA_Rician_Hist','-dpng');
% 
% figure;
% h3 = histfit(error.^2,50,'rayleigh');
% print('Results/KIA_Rayleigh_Hist','-dpng');

%kurtosis(error)
%error(882:883) = 0;
save random_stat.mat error PL_actual PL_corrected RSS start end_ d_PL Gain

