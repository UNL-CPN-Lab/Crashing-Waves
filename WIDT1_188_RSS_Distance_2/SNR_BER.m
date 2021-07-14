clc;
clear variables;
close all;

load sinr_ber.mat
load PL_d_WIDT1_188.mat

xWidth = 0.8;
yWidth = 1;
font_size = 40;

%frame_ber(find(frame_ber == 1)) = NaN;

figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
yyaxis left
plot(d_WIDT1_188,sinr_eq(start:end_),'*','Color','b');
ylim([-5 25])
ylabel('SINR (dB)', 'FontSize', font_size);
hold on;
yyaxis right
plot(d_WIDT1_188,frame_ber(start:end_),'d','Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
grid on
box on
xlim([0 300])
ylim([0 1])
ylabel('BER', 'FontSize', font_size);
xlabel('Distance (m)', 'FontSize', font_size,'Color','k');
print('Results/WIDT1_188_SINR_BER','-depsc');
print('Results/WIDT1_188_SINR_BER','-dpng');
savefig(strcat('Results/WIDT1_188_SINR_BER','.fig'));

t_WIDT1_188 = preamble_time_shifted(start:end_);
SINR_WIDT1_188= sinr_eq(start:end_);
BER_WIDT1_188 = frame_ber(start:end_);
save SINR_BER_WIDT1_188.mat t_WIDT1_188 SINR_WIDT1_188 BER_WIDT1_188 d_WIDT1_188