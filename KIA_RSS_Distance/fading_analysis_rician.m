clc;
clear all;
close all;

format long g

load rx_ofdm_iq_clean.mat
load header_full.mat
load evm_ts_gapped.mat
load preamble_time_shifted.mat
load MwRSF_Data.mat
load 34AGT2_145_csi.mat

csi = csi_34AGT2_145;
csi(isnan(csi))=0;
cir = ones(size(csi)).*NaN;

for i = 1:length(frame_idx)
    slice = frame_idx(i):frame_idx(i)+24;
    ts = ifft(csi(:,slice));
    cir(:,slice) = ts;
end

h = cir(:);

W = 6217;
l = floor(W/2);
w = W-100;

r = [zeros(l,1); abs(h); zeros(l,1)];
M = movmean(r,W,'omitnan');
r_norm = M(l+1:end-l);

r_env = h./r_norm;

% u2 = mean(abs(r_env).^2,'omitnan');
% u4 = mean(abs(r_env).^4,'omitnan');
% 
% % u2 = movmean(abs(r_env).^2,w,'omitnan');
% % u4 = movmean(abs(r_env).^4,w,'omitnan');
% 
% K = (-u2.^2 + u4 -u2.* sqrt(2.*u2.^2 - u4))./(u2.^2 - u4);
% %K = reshape(K,64,[]);


u1 = movmean(abs(r_env),w,'omitnan');
u2 = movmean(abs(r_env).^2,w,'omitnan');
u4 = movmean(abs(r_env).^4,w,'omitnan');

f12 = (u1.^2)./u2;

roots = ones(size(f12)).*NaN;

K0 = 0;

f12(isnan(f12)) = 0;

for i = 1:length(f12)

    fun = @(K) ((pi.*exp(-K))./(4.*(K+1))).*((K+1).*besseli(0,K./2) + K .* besseli(1,K./2)).^2 - f12(i);
    roots(i) = fzero(fun,K0);
end
