%% Post processing
% SNR, EVM, PE
close all;
load evm_ts_clean.mat
load pe_ts.mat
load sinr_ts.mat
load rx_ofdm_iq_f1.mat
load channel_estimate.mat
len_frames = 598219;
dat_loc = [9:31,34:56];

eq_ofdm_iq_f1 = rx_ofdm_iq_f1(dat_loc,:)./channel_estimate(dat_loc,:);
eq_ofdm_bit_f1 = zeros(size(eq_ofdm_iq_f1));
eq_ofdm_bit_f1(real(eq_ofdm_iq_f1)<0)=1;
%eq_ofdm_bit_f1 = eq_ofdm_bit_f1(pe1_idx);
[lia,locb] = ismember(pe1_idx-1,frame_idx);
eq_ofdm_bit_f1=eq_ofdm_bit_f1(:,locb);
bits_idx = frame_idx(locb);
%%
UTC_of_start = 'October 31, 2016 15:04:19.728'; % starting time of reception
UTC_of_stop = 'October 31, 2016 15:11:39.631'; % ending time of reception

UTC_of_crash = 'October 31, 2016 15:10:20.631'; % ending time of reception
Ts = 0.000002;
symbol_time = (128+64).*Ts;
start_time = datevec(UTC_of_start,'mmmm dd, yyyy HH:MM:SS.FFF');
stop_time = datevec(UTC_of_stop,'mmmm dd, yyyy HH:MM:SS.FFF');
crash_time = datevec(UTC_of_crash,'mmmm dd, yyyy HH:MM:SS.FFF');

num_of_total_sec = len_frames.*symbol_time;%get_num_of_secs(start_time,stop_time);
num_of_sec_crash = 392490.*symbol_time;%get_num_of_secs(start_time,crash_time);

sec_per_ofdm = symbol_time;
%% Ploting
evm1_time = evm1_idx.*sec_per_ofdm;
evm2_time = evm2_idx.*sec_per_ofdm;
pe1_time = pe1_idx.*sec_per_ofdm;
snr_time = frame_idx.*sec_per_ofdm;
bits_time = bits_idx.*sec_per_ofdm;
chest_occupied = channel_estimate([9:55],:);

figure;
plot(evm1_time,evm1_ts);
hold on;
plot(evm2_time,evm2_ts);
plot([num_of_sec_crash,num_of_sec_crash],[0,120],'r','LineWidth',2);
hold off;
xlabel('Time (s)');
ylabel('EVM (%)');
legend('EVM 1','EVM Kmean');
grid on;

figure;
plot(pe1_time,pe1_ts,':+');
hold on;
plot([num_of_sec_crash,num_of_sec_crash],[-1,1],'r','LineWidth',2);
hold off;
xlabel('Time (s)');
ylabel('Phase Error (rad)');
grid on;

figure;
plot(snr_time,sinr,':o');
hold on;
plot([num_of_sec_crash,num_of_sec_crash],[0,25],'r','LineWidth',2);
hold off;
xlabel('Time (s)');
ylabel('SNR (dB)');
grid on;

figure;
plot(mean(eq_ofdm_bit_f1,2),':o');

errbit = sum(abs(eq_ofdm_bit_f1([1:32,40],:)-eq_ofdm_bit_f1([1:32,40],1)),1);
figure;
plot(bits_time,errbit,':*');
hold on;
plot([num_of_sec_crash,num_of_sec_crash],[0,25],'r','LineWidth',2);
hold off;
xlabel('Time (s)');
ylabel('Error Bits');
grid on;

[x,y]=meshgrid(bits_time,[1:46]);
figure;
surf(x,y,eq_ofdm_bit_f1,'EdgeColor','None');
ylim([0,47]);
view(2);

%meshgrid()
[x,y]=meshgrid(snr_time,[1:47]);
figure;
surf(x,y,20.*log10(abs(chest_occupied)),'EdgeColor','None');
hold on;
plot3(num_of_sec_crash.*ones(1,6),[0,10,20,30,40,50],[-10,-70,-10,-70,-10,-70],'r','LineWidth',2);
hold off;
xlabel('time (s)');ylabel('Subcarrier');zlabel('Channel Gain');

figure;
surf(x,y,unwrap(angle(chest_occupied),[],1),'EdgeColor','None');
hold on;
plot3(num_of_sec_crash.*ones(1,6),[0,10,20,30,40,50],[70,-70,70,-70,70,-70],'r','LineWidth',2);
hold off;
xlabel('time (s)');ylabel('Subcarrier');zlabel('Channel Phase (rad)');

