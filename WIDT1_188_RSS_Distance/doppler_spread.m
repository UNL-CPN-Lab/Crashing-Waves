clc;
clear all;
close all;

tic

load evm_ts_gapped.mat
load channel_est_post.mat
load header_full.mat
load preamble_time_shifted.mat
load MwRSF_Data.mat
load frame_ber.mat
load bessel_bin_all.mat

data_idx = [1:23,26:48];

auto_corr = zeros(25,25,length(frame_idx));

for i = 1:length(frame_idx)
    cfr = channel_est_post(data_idx,frame_idx(i):frame_idx(i)+24);
    cir = ifft(cfr);
    for j = 1:25
        for k = 1:25
            auto_corr(j,k,i) = auto_corr_calc(cir(:,j),cir(:,k));
        end
    end
end

doppler_freq = zeros(25,25,length(frame_idx));
fd = linspace(0,600,10000);

abs_auto_corr = abs(auto_corr);
abs_auto_corr(isnan(abs_auto_corr))=0;

for i= 1:length(frame_idx)
    for j = 1:25
        for k = 1:25
            m = closest_value(bessel_bin_all(:,abs(j-k)+1),abs_auto_corr(j,k,i));
            doppler_freq(j,k,i) = fd(m);
        end
    end    
end

auto_corr_WIDT1_188 = auto_corr;
doppler_freq_WIDT1_188 = doppler_freq;

save WIDT1_188_doppler.mat auto_corr_WIDT1_188 doppler_freq_WIDT1_188

toc
