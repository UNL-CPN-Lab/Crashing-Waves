clc;
clear variables;
close all;

load sinr_ber.mat
load PL_d_AGTB2_180.mat

xWidth = 0.8;
yWidth = 1;
font_size = 40;

%frame_ber(find(frame_ber == 1)) = NaN;

figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
yyaxis left
plot(d_AGTB2_180,sinr_eq(start:end_),'*','Color','b');
ylim([-5 25])
ylabel('SINR (dB)', 'FontSize', font_size);
hold on;
yyaxis right
plot(d_AGTB2_180,frame_ber(start:end_),'d','Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
grid on
box on
xlim([0 300])
ylim([0 1])
ylabel('BER', 'FontSize', font_size);
xlabel('Distance (m)', 'FontSize', font_size,'Color','k');
print('Results/AGTB2_180_SINR_BER','-depsc');
print('Results/AGTB2_180_SINR_BER','-dpng');
savefig(strcat('Results/AGTB2_180_SINR_BER','.fig'));

t_AGTB2_180 = preamble_time_shifted(start:end_);
SINR_AGTB2_180 = sinr_eq(start:end_);
BER_AGTB2_180 = frame_ber(start:end_);
save SINR_BER_AGTB2_180.mat t_AGTB2_180 SINR_AGTB2_180 BER_AGTB2_180 d_AGTB2_180