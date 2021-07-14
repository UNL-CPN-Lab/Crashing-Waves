clc;
clear variables;
close all;

load sinr_ber.mat
load PL_d_34AGT2_87.mat

xWidth = 0.8;
yWidth = 1;
font_size = 40;

figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
yyaxis left
plot(d_34AGT2_87,sinr_eq,'*','Color','b');
ylim([5 25])
ylabel('SINR (dB)', 'FontSize', font_size);
hold on;
yyaxis right
plot(d_34AGT2_87,frame_ber,'d','Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
grid on
box on
xlim([0 300])
ylim([0 1])
ylabel('BER', 'FontSize', font_size);
xlabel('Distance (m)', 'FontSize', font_size,'Color','k');
print('Results/34agt2_87_SINR_BER','-depsc');
print('Results/34agt2_87_SINR_BER','-dpng');
savefig(strcat('Results/34agt2_87_SINR_BER','.fig'));

t_34AGT2_87 = preamble_time_shifted;
SINR_34AGT2_87 = sinr_eq;
BER_34AGT2_87 = frame_ber;
save SINR_BER_34AGT2_87.mat t_34AGT2_87 SINR_34AGT2_87 BER_34AGT2_87 d_34AGT2_87