clc;
clear variables;
close all;

load sinr_ber.mat
load PL_d_34AGT2_145.mat

xWidth = 0.8;
yWidth = 1;
font_size = 40;
start = 224;
end_ = 832;

%frame_ber(find(frame_ber == 1)) = NaN;

figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
yyaxis left
plot(d_34AGT2_145,sinr_eq(start:end_),'*','Color','b');
%ylim([5 25])
ylabel('SINR (dB)', 'FontSize', font_size);
hold on;
yyaxis right
plot(d_34AGT2_145,frame_ber(start:end_),'d','Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
grid on
box on

xlim([20 260])
ylim([0 1])
ylabel('BER', 'FontSize', font_size);
xlabel('Distance (m)', 'FontSize', font_size,'Color','k');
print('Results/34agt2_145_SINR_BER','-depsc');
print('Results/34agt2_145_SINR_BER','-dpng');
savefig(strcat('Results/34agt2_145_SINR_BER','.fig'));

t_34AGT2_145 = preamble_time_shifted(start:end_);
SINR_34AGT2_145 = sinr_eq(start:end_);
BER_34AGT2_145 = frame_ber(start:end_);
save SINR_BER_34AGT2_145.mat t_34AGT2_145 SINR_34AGT2_145 BER_34AGT2_145 d_34AGT2_145 