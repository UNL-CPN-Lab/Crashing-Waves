clc;
clear variables;
close all;

load sinr_ber.mat
load PL_d_AGTB2_Omni.mat

xWidth = 0.8;
yWidth = 1;
font_size = 40;


figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
yyaxis left
plot(d_AGTB2_Omni,sinr_eq,'*','Color','b');
ylim([-5 25])
ylabel('SINR (dB)', 'FontSize', font_size);
hold on;
yyaxis right
plot(d_AGTB2_Omni,frame_ber,'d','Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
grid on
box on
%xlim([-20 20])
xlim([0 300])
ylim([0 1])
ylabel('BER', 'FontSize', font_size);
xlabel('Distance (m)', 'FontSize', font_size,'Color','k');
print('Results/AGTB2_Omni_SINR_BER','-depsc');
print('Results/AGTB2_Omni_SINR_BER','-dpng');
savefig(strcat('Results/AGTB2_Omni_SINR_BER','.fig'));

t_AGTB2_Omni = preamble_time_shifted;
SINR_AGTB2_Omni= sinr_eq;
BER_AGTB2_Omni = frame_ber;
save SINR_BER_AGTB2_Omni.mat t_AGTB2_Omni SINR_AGTB2_Omni BER_AGTB2_Omni d_AGTB2_Omni