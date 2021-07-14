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

xWidth = 0.8;
yWidth = 1;

subidx = 0;
min_d = 1;
max_d = 1000;
min_PL = -90;
max_PL= -40;
font_size = 30;

cell41={{['-g']};{['-g']};{['-g']};{['-g']}};
figure('units','normalized','outerposition',[0 0 xWidth yWidth])
C = {cell41};
[h,labelfontsize] = subplotplus(C);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(d_34AGT2_145,PL_34AGT2_145','*','Color','r');
hold on;
semilogx(d_PL_34AGT2_145,PL_corrected_34AGT2_145','-h','Linewidth',3,'Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','r');
legend(legend1, legend5, 'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(d_AGTB2_180,PL_AGTB2_180','d','Color','k');
hold on;
semilogx(d_PL_AGTB2_180,PL_corrected_AGTB2_180','-h','Linewidth',3,'Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','k');
legend(legend2, legend5, 'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(d_NJPCB7_180,PL_NJPCB7_180','s','Color','m');
hold on;
semilogx(d_PL_NJPCB7_180,PL_corrected_NJPCB7_180','-h','Linewidth',3,'Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','m');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','m');
legend( legend3,legend5, 'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(d_WIDT1_188,PL_WIDT1_188','+','Color','b');
hold on;
semilogx(d_PL_WIDT1_188,PL_corrected_WIDT1_188','-h','Linewidth',3,'Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',{'1' '10' '' '100' '' '' '' '' '' '' '1000'});
%set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 5 10 50 100 300],'XTickLabel',[0 5 10 50 100 300 ]);
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','b');
legend(legend4, legend5,'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

grid on
box on


h(2).Position(3)=0.88;
h(1).Position(3)=0.88;
h(3).Position(3)=0.88;
h(4).Position(3)=0.88;
h(1).Position(2) = h(1).Position(2) + 0.07;
h(2).Position(2) = h(2).Position(2) + 0.07;
h(3).Position(2) = h(3).Position(2) + 0.07;
h(4).Position(2) = h(4).Position(2) + 0.07;


print('Results/RSS_Upper_Log','-depsc');
print('Results/RSS_Upper_Log','-dpng');
savefig(strcat('Results/RSS_Upper_Log','.fig'));

legend1 = 'SSSB';
legend2 = 'PSSB';
legend3 = 'PCB';
legend4 = 'SSWB';
legend5 = 'Model';

subidx = 0;
min_d = 1;
max_d = 1000;
min_PL = -90;
max_PL= -20;
font_size = 30;

cell41={{['-g']};{['-g']};{['-g']};{['-g']}};
figure('units','normalized','outerposition',[0 0 xWidth yWidth])
C = {cell41};
[h,labelfontsize] = subplotplus(C);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(d_34AGT2_87,PL_34AGT2_87','*','Color','r');
hold on;
semilogx(d_PL_34AGT2_87,PL_corrected_34AGT2_87','-h','Linewidth',3,'Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','r');
legend(legend1,legend5, 'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(d_AGTB2_Omni,PL_AGTB2_Omni','d','Color','k');
hold on;
semilogx(d_PL_AGTB2_Omni,PL_corrected_AGTB2_Omni','-h','Linewidth',3,'Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','k');
legend(legend2,legend5, 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(d_NJPCB7_Omni,PL_NJPCB7_Omni','s','Color','m');
hold on;
semilogx(d_PL_NJPCB7_Omni,PL_corrected_NJPCB7_Omni','-h','Linewidth',3,'Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','m');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','m');
legend( legend3,legend5, 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(d_KIA,PL_KIA','+','Color','b');
hold on;
semilogx(d_PL_KIA,PL_corrected_KIA','-h','Linewidth',3,'Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',{'1' '10' '' '100' '' '' '' '' '' '' '1000'});
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','b');
legend(legend4, legend5,'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

grid on
box on


h(2).Position(3)=0.88;
h(1).Position(3)=0.88;
h(3).Position(3)=0.88;
h(4).Position(3)=0.88;
h(1).Position(2) = h(1).Position(2) + 0.07;
h(2).Position(2) = h(2).Position(2) + 0.07;
h(3).Position(2) = h(3).Position(2) + 0.07;
h(4).Position(2) = h(4).Position(2) + 0.07;


print('Results/RSS_Lower_Log','-depsc');
print('Results/RSS_Lower_Log','-dpng');
savefig(strcat('Results/RSS_Lower_Log','.fig'));

