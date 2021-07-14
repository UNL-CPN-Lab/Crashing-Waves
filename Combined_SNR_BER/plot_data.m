clc;
clear all;
close all;

load SINR_BER_AGTB2_180.mat  
load SINR_BER_NJPCB7_180.mat 
load SINR_BER_34AGT2_145.mat  
load SINR_BER_AGTB2_Omni.mat  
load SINR_BER_NJPCB7_Omni.mat 
load SINR_BER_34AGT2_87.mat   
load SINR_BER_KIA.mat         
load SINR_BER_WIDT1_188.mat

legend1 = '1.45m Sedan Steel SINR';
legend2 = '1.8m Pickup Steel SINR';
legend3 = '1.8m Pickup Concrete SINR';
legend4 = '1.88m Pickup Concrete LOS SINR';
legend5 = '1.45m Sedan Steel BER';
legend6 = '1.8m Pickup Steel BER';
legend7 = '1.8m Pickup Concrete BER';
legend8 = '1.88m Pickup Concrete LOS BER';

xWidth = 1;
yWidth = 1;

subidx = 0;
min_d = 0;
max_d = 400;
min_SINR = -5;
max_SINR= 40;
min_BER = 0;
max_BER= 1;
font_size = 30;

cell41={{['-g']};{['-g']};{['-g']};{['-g']}};
figure('units','normalized','outerposition',[0 0 xWidth yWidth])
C = {cell41};
[h,labelfontsize] = subplotplus(C);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_34AGT2_145,SINR_34AGT2_145','*','Color','r');
ylim([min_SINR max_SINR]);
ylabel('SINR (dB)', 'FontSize', font_size,'Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
hold on;
yyaxis right;
plot(d_34AGT2_145,BER_34AGT2_145','h','Color','b');
ylim([min_BER max_BER]);
ylabel('BER', 'FontSize', font_size,'Color','b');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
legend(legend1, legend5, 'Location','Northeast','Orientation','horizontal' )
xlim([min_d max_d]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_AGTB2_180,SINR_AGTB2_180','d','Color','k');
ylim([min_SINR max_SINR]);
ylabel('SINR (dB)', 'FontSize', font_size,'Color','k');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
hold on;
yyaxis right;
plot(d_AGTB2_180,BER_AGTB2_180','s','Color','m');
ylim([min_BER max_BER]);
ylabel('BER', 'FontSize', font_size,'Color','m');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','m');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
legend(legend2, legend6, 'Location','Northeast','Orientation','horizontal' )
xlim([min_d max_d]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_NJPCB7_180,SINR_NJPCB7_180','+','Color','r');
ylim([min_SINR max_SINR]);
ylabel('SINR (dB)', 'FontSize', font_size,'Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
hold on;
yyaxis right;
plot(d_NJPCB7_180,BER_NJPCB7_180','>','Color','b');
ylim([min_BER max_BER]);
ylabel('BER', 'FontSize', font_size,'Color','b');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
legend(legend3, legend7, 'Location','Northeast', 'Orientation','horizontal' )
xlim([min_d max_d]);


subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_WIDT1_188,SINR_WIDT1_188','p','Color','k');
ylim([min_SINR max_SINR]);
ylabel('SINR (dB)', 'FontSize', font_size,'Color','k');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
hold on;
yyaxis right;
plot(d_WIDT1_188,BER_WIDT1_188','<','Color','m');
ylim([min_BER max_BER]);
ylabel('BER', 'FontSize', font_size,'Color','m');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','m');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[0 50 100 150 200 250 300 350 400]);
xlabel('Distance (m)', 'FontSize', font_size);
legend(legend4, legend8, 'Location','Northeast','Orientation','horizontal' )
xlim([min_d max_d]);



% h(2).Position(3)=0.88;
% h(1).Position(3)=0.88;
% h(3).Position(3)=0.88;
% h(4).Position(3)=0.88;
% h(1).Position(2) = h(1).Position(2) + 0.07;
% h(2).Position(2) = h(2).Position(2) + 0.07;
% h(3).Position(2) = h(3).Position(2) + 0.07;
% h(4).Position(2) = h(4).Position(2) + 0.07;


print('Results/Upper_SINR_BER_Combined','-depsc');
print('Results/Upper_SINR_BER_Combined','-dpng');
savefig(strcat('Results/Upper_SINR_BER_Combined','.fig'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
legend1 = '0.87m Sedan Steel SINR';
legend2 = '0.82m Pickup Steel SINR';
legend3 = '0.82m Pickup Concrete SINR';
legend4 = '1.0m Sedan Steel Wire SINR';
legend5 = '0.87m Sedan Steel BER';
legen6 = '0.82m Pickup Steel BER';
legend7 = '0.82m Pickup Concrete BER';
legend8 = '1.0m Sedan Steel Wire BER';

subidx = 0;
min_d = 0;
max_d = 250;
font_size = 30;


cell41={{['-g']};{['-g']};{['-g']};{['-g']}};
figure('units','normalized','outerposition',[0 0 xWidth yWidth])
C = {cell41};
[h,labelfontsize] = subplotplus(C);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_34AGT2_87,SINR_34AGT2_87','*','Color','r');
ylim([min_SINR max_SINR]);
ylabel('SINR (dB)', 'FontSize', font_size,'Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
hold on;
yyaxis right;
plot(d_34AGT2_87,BER_34AGT2_87','h','Color','b');
ylim([min_BER max_BER]);
ylabel('BER', 'FontSize', font_size,'Color','b');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
legend(legend1, legend5, 'Location','Northeast','Orientation','horizontal' )
xlim([min_d max_d]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_AGTB2_Omni,SINR_AGTB2_Omni','d','Color','k');
ylim([min_SINR max_SINR]);
ylabel('SINR (dB)', 'FontSize', font_size,'Color','k');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
hold on;
yyaxis right;
plot(d_AGTB2_Omni,BER_AGTB2_Omni','s','Color','m');
ylim([min_BER max_BER]);
ylabel('BER', 'FontSize', font_size,'Color','m');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','m');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
legend(legend2, legend6, 'Location','Northeast','Orientation','horizontal' )
xlim([min_d max_d]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_NJPCB7_Omni,SINR_NJPCB7_Omni','+','Color','r');
ylim([min_SINR max_SINR]);
ylabel('SINR (dB)', 'FontSize', font_size,'Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
hold on;
yyaxis right;
plot(d_NJPCB7_Omni,BER_NJPCB7_Omni','>','Color','b');
ylim([min_BER max_BER]);
ylabel('BER', 'FontSize', font_size,'Color','b');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
legend(legend3, legend7, 'Location','Northeast', 'Orientation','horizontal' )
xlim([min_d max_d]);


subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_KIA,SINR_KIA','p','Color','k');
ylim([min_SINR max_SINR]);
ylabel('SINR (dB)', 'FontSize', font_size,'Color','k');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
hold on;
yyaxis right;
plot(d_KIA,BER_KIA','<','Color','m');
ylim([min_BER max_BER]);
ylabel('BER', 'FontSize', font_size,'Color','m');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','m');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[0 50 100 150 200 250 300 350 400]);
xlabel('Distance (m)', 'FontSize', font_size);
legend(legend4, legend8, 'Location','Northeast','Orientation','horizontal' )
xlim([min_d max_d]);



% h(2).Position(3)=0.88;
% h(1).Position(3)=0.88;
% h(3).Position(3)=0.88;
% h(4).Position(3)=0.88;
% h(1).Position(2) = h(1).Position(2) + 0.07;
% h(2).Position(2) = h(2).Position(2) + 0.07;
% h(3).Position(2) = h(3).Position(2) + 0.07;
% h(4).Position(2) = h(4).Position(2) + 0.07;


print('Results/Lower_SINR_BER_Combined','-depsc');
print('Results/Lower_SINR_BER_Combined','-dpng');
savefig(strcat('Results/Lower_SINR_BER_Combined','.fig'));





