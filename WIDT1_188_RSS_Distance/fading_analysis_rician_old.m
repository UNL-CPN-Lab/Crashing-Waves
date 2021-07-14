clc;
clear all;
close all;

format long g

load rx_ofdm_iq_clean.mat
load header_full.mat
load evm_ts_gapped.mat
load preamble_time_shifted.mat
load MwRSF_Data.mat

freq = 5.8e9;
lamda = physconst('LightSpeed')/freq;

Overall_PSD_split = rx_ofdm_iq;

c = -100.999;
sample_rate=500000;
cp_length=128;  
delta_t=(64+128)/sample_rate;


PSD = (10*log10(sum(real(Overall_PSD_split).^2+imag(Overall_PSD_split).^2)/delta_t))+c;

PSD_W = ((10.^(PSD./10))./1000);

RSS = ones(1,length(frame_idx)).*NaN;
Omega = ones(1,length(frame_idx)).*NaN;

for i = 1: length(frame_idx)-1
    PSD_split = PSD_W(frame_idx(i):frame_idx(i+1));
    Omega(i) = mean(PSD_split);
    u2 = sum(PSD_split.^2)./length(PSD_split);
    u4 = sum(PSD_split.^4)./length(PSD_split);
    RSS(i) = (-u2^2 + u4 -u2 * sqrt(2*u2^2 - u4))/(u2^2 - u4);
end

K= 10*log10(RSS);
nu = sqrt(abs((K.*Omega)./(K+1)));
sigma = sqrt(abs(Omega./(2.*(1+K))));

pd = makedist('Rician','s',nanmean(nu),'sigma',nanmean(sigma));

% k = 8;
% 
% h = histogram(PSD_W,k);
% hold on;
% 
% 
% v = h.Values;
% b = h.BinEdges;
% 
% x = b(1:end-1) + diff(b)/2;
% 
% y = pdf(pd,x);
% 
% xmin = min(PSD_W);
% xmax = max(PSD_W);
% xx = linspace(xmin,xmax,1000);
% yy = pdf(pd,xx);
% 
% plot(xx,yy.*(max(v)/max(yy)),'Linewidth',3)
% 
% observed = v./(sum(v));
% expected = y./(sum(y)) ;
% chi2 = sum(((observed-expected).^2)./expected);
% 
% chi2inv(0.95,k-1)
% 
% p = gammainc(chi2/2,(k-1)/2,'upper');
% 
% %kurtosis(error)
