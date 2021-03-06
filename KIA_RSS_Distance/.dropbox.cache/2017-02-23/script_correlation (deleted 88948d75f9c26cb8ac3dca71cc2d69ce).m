% cyclic correlation
clc
close all;
clear all;
N = 64;
%load exp_data.mat
load exp_data.mat
%load exp_data_bogie.mat
%b = fft_out_bogie;

    
n_frames = length(b)./N;
n_frame_a = length(a)./N;
preamble = a(1:N);
pre_loc = [9:2:56];
dat_loc = [9:31,34:56];
rx_ofdm_iq = reshape(b,[N,n_frames]);
load rx_ofdm_iq_clean.mat
if 0
    len_frames = 100;
else
    len_frames = size(rx_ofdm_iq,2);
end

if 1
    % method 1 find power difference between noise and pilot subcarriers 
    iqdiff = abs(rx_ofdm_iq([9:2:56],:))-abs(rx_ofdm_iq([10:2:56],:));
    pwrdiff = sum(iqdiff,1);
    figure;
    plot(pwrdiff);
    frame_idx=find(pwrdiff>0.5);
    % method 2 correlation with preamble
%     coeff_fn = [];
%     coeff_fn = corr(preamble,rx_ofdm_iq);
%     figure;
%     plot(abs(coeff_fn));
%     peaks = abs(coeff_fn);
%     frame_idx = find(peaks>0.4);
end

noise = sum(abs(rx_ofdm_iq([10:2:56],frame_idx)).^2);
signal = sum(abs(rx_ofdm_iq([9:2:56],frame_idx)).^2);
sinr = 10.*log10(signal./noise);
plot(frame_idx,sinr,'--o')
xlabel('OFDM frame index');
ylabel('SNR (dB)');
grid on;
preamble_symbols = rx_ofdm_iq(pre_loc,frame_idx);
Hpilot_LS = preamble_symbols.*preamble(pre_loc);

% Interpolation p--->N    
% for q=1:100
for q=1:size(preamble_symbols,2)
channel_estimate(:,q) = interpolate(Hpilot_LS(:,q).',pre_loc,N,'spline'); % Linear/Spline interpolation
end

rx_ofdm_iq_f1 = rx_ofdm_iq(:,frame_idx+1);
% save sinr_ts.mat sinr
% save channel_estimate.mat channel_estimate
% save rx_ofdm_iq_f1.mat rx_ofdm_iq_f1
%% EVM, PE
evm_ts = NaN.*ones(2,len_frames);
pe_d_ts = NaN.*ones(1,len_frames);
pe_p_ts = NaN.*ones(1,len_frames);

channel_est_all = NaN.*ones(47,size(rx_ofdm_iq,2));
% bits_all = zeros(46,size(rx_ofdm_iq,2));
% figure;
load header_full.mat
%for fidx= 1:100
for fidx = 15607:size(frame_idx,2)-1
%     chest = interpolate(Hpilot_LS(:,fidx).',pre_loc,N,'spline'); % Linear/Spline interpolation
%     chest = chest';
%     channel_estimate(:,fidx) = chest;
    chest = channel_estimate(:,fidx);
    pilot_chest = chest;
    channel_est_all(:,frame_idx(fidx))=chest(9:55);
    for i = frame_idx(fidx)+1:frame_idx(fidx+1)-1
        if isnan(header_full(i))
            continue;
        end
%         subplot(2,2,1);
        %plot(rx_ofdm_iq(dat_loc,i),'*');
        %xlim([-0.06,0.06]);ylim([-0.06,0.06]);
        if ~all(rx_ofdm_iq(dat_loc,i))
            continue;
        end
        eq_data_iq_0st = rx_ofdm_iq(dat_loc,i)./pilot_chest(dat_loc);
        eq_data_iq_1st = rx_ofdm_iq(dat_loc,i)./chest(dat_loc);
%         subplot(2,2,2);
%         plot(eq_data_iq_1st,'*');
%         xlim([-1.5,1.5]);ylim([-1.5,1.5]);
         

        tx_data_iq_1st = zeros(size(eq_data_iq_1st));
        tx_data_iq_1st(real(eq_data_iq_1st)>0,1) = 1;
        tx_data_iq_1st(real(eq_data_iq_1st)<0,1) = -1;
        
        chest_2nd = tx_data_iq_1st.*rx_ofdm_iq(dat_loc,i);
        chest = interpolate(chest_2nd.',dat_loc,64,'spline'); chest = chest.';
        channel_est_all(:,i)=chest(9:55);
        % bits_all(:,i) = tx_data_iq_1st;
        % eq_data_iq_2nd = rx_ofdm_iq(dat_loc,i)./chest(dat_loc);
%         
%         % calculate EVM
%         subplot(2,2,3);
        %plot(eq_data_iq_2nd,'*');
        %xlim([-1.5,1.5]);ylim([-1.5,1.5]);
        %% EVM
        [idx,C]=kmeans([real(eq_data_iq_1st),imag(eq_data_iq_1st)],2);
        err_vec1 = (eq_data_iq_1st-tx_data_iq_1st);
        EVM1 = 100.*sqrt(sum(abs(err_vec1).^2)./sum(abs(eq_data_iq_1st).^2));
        const_cmp = complex(C(:,1),C(:,2));
        err_vec2 = eq_data_iq_1st - const_cmp(idx);
        EVM2 = 100.*sqrt(sum(abs(err_vec2).^2)./sum(abs(eq_data_iq_1st).^2));
        evm_ts(:,i)=[EVM1;EVM2];
        %% Phase Error
        pe_vec1 = eq_data_iq_0st;
        pe_vec1(tx_data_iq_1st==-1) = -pe_vec1(tx_data_iq_1st==-1);
        pe_p_ts(:,i)=mean(unwrap(angle(pe_vec1)),1);
        
        pe_vec1 = eq_data_iq_1st;
        pe_vec1(tx_data_iq_1st==-1) = -pe_vec1(tx_data_iq_1st==-1);
        pe_d_ts(:,i)=mean(angle(pe_vec1),1);        
    end
end
%save channel_est_all.mat channel_est_all
evm1_ts = evm_ts(1,:);
evm2_ts = evm_ts(2,:);
save evm_ts_gapped.mat evm1_idx evm1_ts evm2_idx evm2_ts frame_idx len_frames
save pe_ts_gapped.mat pe_d_ts pe_p_ts
save sinr_ts_gapped.mat sinr


% for i=1:length(frame_idx)
% bar(abs(rx_ofdm_iq(9:56,frame_idx(i))));
% pause(1);
% end
% figure;
% surf(abs(channel_estimate(:,1:100)));
% figure;
% len = len_frames;
% plot(1:len,evm_ts(:,1:len));
% channel_df = diff(channel_estimate(9:2:56,:),1);
% channel_angle = angle(channel_df);
% channel_angle_unwrap = unwrap(channel_angle,[],1);
% figure;
% plot(channel_angle_unwrap(:,1));
% hold on;
% plot(channel_angle_unwrap(:,2));
% plot(channel_angle_unwrap(:,3));
% plot(channel_angle_unwrap(:,4));
% hold off;
% legend({'1','2','3','4'});

% evm1_ts = evm_ts(1,frame_idx+1);
evm1_ts = evm_ts(1,:);
evm2_ts = evm_ts(2,:);
evm2_ts(evm2_ts==0)=[];
evm1_idx = 1:len_frames;%frame_idx+1;
evm1_idx(evm1_ts==0)=[];
evm1_ts(evm1_ts==0)=[];
evm2_idx = 1:frame_idx(end);
evm2_idx(frame_idx)=[];
figure;
plot(evm1_idx,evm1_ts);
hold on;
%plot(evm2_idx,evm2_ts);
hold off;

pe1_ts = pe_ts(1,evm1_idx);
pe1_idx = evm1_idx;
figure;
plot(pe_ts);
figure;
plot(pe1_idx,pe1_ts);

save evm_ts_clean.mat evm1_idx evm1_ts evm2_idx evm2_ts frame_idx len_frames
save pe_ts.mat pe1_idx pe1_ts

%% Save
% bits_all(bits_all==1)=0;
% bits_all(bits_all==-1)=1;
% save bits_all.mat bits_all
%%
figure;
for fidx=1:10
    equalized_data_iq = rx_ofdm_iq(9:56,frame_idx(fidx)+[1:24])./channel_estimate(9:56,fidx);
    for i=1:24
        subplot(1,2,1);
        plot(rx_ofdm_iq(9:56,frame_idx(fidx)+i),'*');
        subplot(1,2,2);
        plot(equalized_data_iq(:,i),'*');
        %pause(1);
    end
end
for i=1:52
    plot(rx_ofdm_iq(9:56,frame_idx(1)+i),'*');
    %pause(1);
end
%p = abs(coeff);
% load('p.mat')
% 
% 
% plot(p);
% 
% q = find(p > 1);
% 
% diff_q = get_differences(q);
%plot(diff_q);

sub_carrier_coeff = [];

for i = 1:length(q)-1
    c = b(q(i):q(i)+63);
    
    d = b(q(i+1):q(i+1)+63);
    sub_carrier_coeff(i) = corr(c,d);
    
end

plot(abs(sub_carrier_coeff));

% figure;
% plot(abs(coeff));
