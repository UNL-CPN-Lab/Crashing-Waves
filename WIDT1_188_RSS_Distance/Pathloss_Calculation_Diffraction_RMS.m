clc;
clear variables;
close all;

load rx_ofdm_iq_clean.mat
load header_full.mat
load evm_ts_gapped.mat
load preamble_time_shifted.mat
load pathloss_data_high_ref.mat
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
d_PL = ddd;
d_ref = 30.48;
PL_calc = 96.524509 + 10*n_high*log10(d_PL./d_ref);

d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];
theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);
% K = interp2(d_range,theta,V_high,d_PL,0*(pi/180),'spline');
% C = interp2(d_range,theta,C_high,d_PL,0*pi/180,'spline');

delta_PL = zeros(size(d_PL));

hV = 1.88;
hB = 0.82;

h = hV - hB;
d2 = 27.73.*ones(1,length(d_PL));
d1 = d_PL'-d2;
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

X_g = normrnd(0,sdev,size(d_PL));

Ref_Loss = 1.65216660665097;
R = zeros(size(d_PL));
slot = max(ddd)/100;
refp = 27.73*2;
idx = find(d_PL >= refp - slot & d_PL <= refp + slot);
R(idx) = Ref_Loss;

hB = ones(size(d_PL)).*1.88;
hV = ones(size(d_PL)).*1.88;

X = [log10(d_PL(:)) (delta_PL(:)) log10(hB(:)) log10(hV(:)) ];

K = zeros(size(d_PL));
C = predict(mdl_vehicle,X) ;

XX = [K C log10(hB(:)) log10(hV(:)) ];
Correction = predict(mdl_total,XX) ;

PL_corrected = PL_calc  + Correction + diff_loss' + R; 

PL_actual = Gain - RSS(start:end_)';

error = PL_actual-PL_corrected;

idx = find(ddd<=27.73);
error(idx) = [];
d_PL(idx) = [];


st = (min(find(d_PL >=432)));
ed = (min(find(d_PL <=50)));


%plot(ddd,error,'d')
% xlim([50 400])



% rms(error(st:ed-1),'omitnan')
% rms(error(ed:end),'omitnan')
% rms(error,'omitnan')
PL_actual(idx) = [];
PL_corrected(idx) = [];
r_square(PL_actual,PL_corrected)

%pd = fitdist(error,'Poisson')
% % x_values = linsp;
% % y = pdf(pd,x_values);
% % plot(x_values,y,'LineWidth',2)
% pd = fitdist(error,'Normal')
% [h,p,stat] = chi2gof(error,'CDF',pd)

% figure;
% h1 = histfit(error,50,'normal');
% print('Results/WIDT1_Normal_Hist','-dpng');
% 
% figure;
% h2 = histfit(error.^2,50,'rician');
% print('Results/WIDT1_Rician_Hist','-dpng');
% 
% figure;
% h3 = histfit(error.^2,50,'rayleigh');
% print('Results/WIDT1_Rayleigh_Hist','-dpng');

%kurtosis(error)
save random_stat.mat error PL_actual PL_corrected RSS start end_ d_PL Gain