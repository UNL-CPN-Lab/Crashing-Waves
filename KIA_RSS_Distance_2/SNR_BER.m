clc;
clear variables;
close all;

load sinr_ber.mat
load PL_d_KIA.mat

xWidth = 0.8;
yWidth = 1;
font_size = 40;

%frame_ber(find(frame_ber == 1)) = NaN;

figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
yyaxis left
plot(d_KIA,sinr_eq(start:end_),'*','Color','b');
ylim([-5 25])
ylabel('SINR (dB)', 'FontSize', font_size);
hold on;
yyaxis right
plot(d_KIA,frame_ber(start:end_),'d','Color','r');
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

t_KIA = preamble_time_shifted;
SINR_KIA = sinr_eq(start:end_);
BER_KIA = frame_ber(start:end_);
save SINR_BER_KIA.mat t_KIA SINR_KIA BER_KIA d_KIA