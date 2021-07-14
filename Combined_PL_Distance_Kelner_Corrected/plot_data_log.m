clc;
clear all;
close all;

load PL_d_AGTB2_180.mat  
load PL_d_NJPCB7_180.mat 
load PL_d_34AGT2_145.mat 
load PL_d_AGTB2_Omni.mat  
load PL_d_NJPCB7_Omni.mat 
load PL_d_34AGT2_87.mat   
load PL_d_KIA.mat         
load PL_d_WIDT1_188.mat

legend1 = 'SSSB';
legend2 = 'PSSB';
legend3 = 'PCB';
legend4 = 'PCBL';
legend5 = 'Model';

d_model_up = [d_PL_34AGT2_145(:); d_PL_AGTB2_180(:); d_PL_NJPCB7_180(:); d_PL_WIDT1_188(:)];
PL_model_up = [PL_corrected_34AGT2_145(:); PL_corrected_AGTB2_180(:); PL_corrected_NJPCB7_180(:); PL_corrected_WIDT1_188(:)];
total = [d_model_up PL_model_up];
total = sortrows(total);
d_model_up = total(:,1);
PL_model_up = abs(total(:,2));
idx = find(d_model_up <= 0);
d_model_up(idx) = [];
PL_model_up(idx) = [];

xWidth = 0.8;
yWidth = 1;


min_d = 1;
max_d = 430;
min_PL = 40;
max_PL= 130;
font_size = 40;


figure('units','normalized','outerposition',[0 0 xWidth yWidth])
semilogx(d_34AGT2_145,PL_34AGT2_145','*','Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
hold on
semilogx(d_AGTB2_180,PL_AGTB2_180','d','Color','k');
semilogx(d_NJPCB7_180,PL_NJPCB7_180','s','Color','m');
semilogx(d_WIDT1_188,PL_WIDT1_188','+','Color','b');
semilogx(d_model_up,PL_model_up','-h','Linewidth',3,'Color','g');
hold off
grid on
box on
xlim([min_d max_d]);
ylim([min_PL max_PL]);
legend(legend1, legend2, legend3, legend4, legend5,'Location','Southeast' )
xlabel('Distance (m) in Log Scale', 'FontSize', font_size);
ylabel('PL (dB)', 'FontSize', font_size);

h(2).Position(3)=0.88;
h(1).Position(3)=0.88;
h(3).Position(3)=0.88;
h(4).Position(3)=0.88;
h(1).Position(2) = h(1).Position(2) + 0.07;
h(2).Position(2) = h(2).Position(2) + 0.07;
h(3).Position(2) = h(3).Position(2) + 0.07;
h(4).Position(2) = h(4).Position(2) + 0.07;


print('Results/Log_Upper_PL_Combined','-depsc');
print('Results/Log_Upper_PL_Combined','-dpng');
savefig(strcat('Results/Log_Upper_PL_Combined','.fig'));

d_model_down = [d_PL_34AGT2_87(:); d_PL_AGTB2_Omni(:); d_PL_NJPCB7_Omni(:); d_PL_KIA(:)];
PL_model_down = [PL_corrected_34AGT2_87(:); PL_corrected_AGTB2_Omni(:); PL_corrected_NJPCB7_Omni(:); PL_corrected_KIA(:)];
total = [d_model_down PL_model_down];
total = sortrows(total);
d_model_down = total(:,1);
PL_model_down = abs(total(:,2));
idx = find(d_model_down <= 0);
d_model_down(idx) = [];
PL_model_down(idx) = [];

legend1 = 'SSSB';
legend2 = 'PSSB';
legend3 = 'PCB';
legend4 = 'SSWB';
legend5 = 'Model';

min_d = 1;
max_d = 430;
min_PL = 40;
max_PL= 130;
font_size = 40;

figure('units','normalized','outerposition',[0 0 xWidth yWidth])
semilogx(d_34AGT2_87,PL_34AGT2_87','*','Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
hold on
semilogx(d_AGTB2_Omni,PL_AGTB2_Omni','d','Color','k');
semilogx(d_NJPCB7_Omni,PL_NJPCB7_Omni','s','Color','m');
semilogx(d_KIA,PL_KIA','+','Color','b');
semilogx(d_model_down,PL_model_down','-h','Linewidth',3,'Color','g');
hold off
grid on
box on
xlim([min_d max_d]);
ylim([min_PL max_PL]);
legend(legend1, legend2, legend3, legend4, legend5,'Location','Southeast' )
xlabel('Distance (m) in Log Scale', 'FontSize', font_size);
ylabel('PL (dB)', 'FontSize', font_size);

h(2).Position(3)=0.88;
h(1).Position(3)=0.88;
h(3).Position(3)=0.88;
h(4).Position(3)=0.88;
h(1).Position(2) = h(1).Position(2) + 0.07;
h(2).Position(2) = h(2).Position(2) + 0.07;
h(3).Position(2) = h(3).Position(2) + 0.07;
h(4).Position(2) = h(4).Position(2) + 0.07;


print('Results/Log_Lower_PL_Combined','-depsc');
print('Results/Log_Lower_PL_Combined','-dpng');
savefig(strcat('Results/Log_Lower_PL_Combined','.fig'));

