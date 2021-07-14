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

Overall_PSD_split = rx_ofdm_iq(:);

samp_rate = 500e3;

W = 6217;
l = floor(W/2);
w = W-100;

r = [zeros(l,1); abs(Overall_PSD_split); zeros(l,1)];
% 
% r_norm = ones(size(Overall_PSD_split)).*NaN;
% 
% for i = 1:length(Overall_PSD_split)
%     r_norm(i) = sum(r(i:i+W-1),'omitnan')./W;
%    
% end
% 
% r_env = Overall_PSD_split - r_norm;


M = movmean(r,W,'omitnan');
r_norm = M(l+1:end-l);

r_env = Overall_PSD_split./r_norm;
%%r_env = reshape(r_env,64,[]);

% u2 = movmean(abs(r_env).^2,w,'omitnan');
% u4 = movmean(abs(r_env).^4,w,'omitnan');
% 
% 
% 
% K = (-2*u2.^2 + u4 -u2.* sqrt(2.*u2.^2 - u4))./(u2.^2 - u4);
% K = reshape(K,64,[]);
% 
% PSD = (10*log10(sum(real(K).^2+imag(K).^2)));
% PSD = (10*log10(sum(abs(K))));


%-------------------------------------------------------------------------
% 
% mu = 0;
% sigma = 1;
% pd = makedist('Normal','mu',mu,'sigma',sigma);
% x = [-2,-1,0,1,2];
% y = pdf(pd,x);
% plot(x,y)

%-------------------------------------------------------------------------
u1 = movmean(abs(r_env),w,'omitnan');
u2 = movmean(abs(r_env).^2,w,'omitnan');
u4 = movmean(abs(r_env).^4,w,'omitnan');

f12 = (u1.^2)./u2;

f12 = reshape(f12,64,[]);

f12 = mean(f12, 'omitnan');

roots = ones(size(f12)).*NaN;

K0 = 0;

f12(isnan(f12)) = 0;

for i = 1:length(f12)

    fun = @(K) ((pi.*exp(-K))./(4.*(K+1))).*((K+1).*besseli(0,K./2) + K .* besseli(1,K./2)).^2 - f12(i);
    roots(i) = fzero(fun,K0);
end
