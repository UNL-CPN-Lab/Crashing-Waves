clc;
clear all;
close all;

load RSS_d_AGTB2_180.mat  
load RSS_d_NJPCB7_180.mat 
load RSS_d_34AGT2_145.mat  
load RSS_d_AGTB2_Omni.mat  
load RSS_d_NJPCB7_Omni.mat 
load RSS_d_34AGT2_87.mat   
load RSS_d_KIA.mat         
load RSS_d_WIDT1_188.mat

xWidth = 0.8;
yWidth = 1;
font_size = 40;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
plot(d_34AGT2_145,RSS_34AGT2_145','*','Color','r');
hold on;
plot(d_AGTB2_180,RSS_AGTB2_180','d','Color','k');
plot(d_NJPCB7_180,RSS_NJPCB7_180','s','Color','m');
plot(d_WIDT1_188,RSS_WIDT1_188','+','Color','b');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
grid on
box on
legend('Upper 34AGT2', 'Upper AGTB2', 'Upper NJPCB7', 'Upper WIDT1', 'Location','Northeast' )
xlim([0 400])
ylim([-90 -40])
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','k');

print('Results/Upper_RSS_All','-depsc');
print('Results/Upper_RSS_All','-dpng');
savefig(strcat('Results/Upper_RSS_All','.fig'));

subidx = 0;
min_d = 0;
max_d = 400;
min_RSS = -90;
max_RSS= -40;
font_size = 30;

cell31={{['-g']};{['-g']};{['-g']};{['-g']}};
figure('units','normalized','outerposition',[0 0 xWidth yWidth])
C = {cell31};
[h,labelfontsize] = subplotplus(C);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
plot(d_34AGT2_145,RSS_34AGT2_145','*','Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','r');
legend('Upper 34AGT2', 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RSS max_RSS]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
plot(d_AGTB2_180,RSS_AGTB2_180','d','Color','k');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','k');
legend('Upper AGTB2', 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RSS max_RSS]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
plot(d_NJPCB7_180,RSS_NJPCB7_180','s','Color','m');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','m');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','m');
legend( 'Upper NJPCB7', 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RSS max_RSS]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
plot(d_WIDT1_188,RSS_WIDT1_188','+','Color','b');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[0 50 100 150 200 250 300 350 400]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','b');
legend('Upper WIDT1', 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RSS max_RSS]);


h(2).Position(3)=0.88;
h(1).Position(3)=0.88;
h(3).Position(3)=0.88;
h(4).Position(3)=0.88;
h(1).Position(2) = h(1).Position(2) + 0.07;
h(2).Position(2) = h(2).Position(2) + 0.07;
h(3).Position(2) = h(3).Position(2) + 0.07;
h(4).Position(2) = h(4).Position(2) + 0.07;

print('Results/Upper_RSS_Combined','-depsc');
print('Results/Upper_RSS_Combined','-dpng');
savefig(strcat('Results/Upper_RSS_Combined','.fig'));

font_size = 40;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
plot(d_34AGT2_87,RSS_34AGT2_87','*','Color','r');
hold on;
plot(d_AGTB2_Omni,RSS_AGTB2_Omni','d','Color','k');
plot(d_NJPCB7_Omni,RSS_NJPCB7_Omni','s','Color','m');
plot(d_KIA,RSS_KIA','+');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
grid on
box on
legend('Lower 34AGT2', 'Lower Omni AGTB2', 'Lower Omni NJPCB7', 'Lower KIA', 'Location','Northeast' )
xlim([0 400])
ylim([-90 -40])
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','k');

print('Results/Lower_RSS_All','-depsc');
print('Results/Lower_RSS_All','-dpng');
savefig(strcat('Results/Lower_RSS_All','.fig'));


subidx = 0;
min_d = 0;
max_d = 400;
min_RSS = -90;
max_RSS= -40;
font_size = 30;

cell31={{['-g']};{['-g']};{['-g']};{['-g']}};
figure('units','normalized','outerposition',[0 0 xWidth yWidth])
C = {cell31};
[h,labelfontsize] = subplotplus(C);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
plot(d_34AGT2_87,RSS_34AGT2_87','*','Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','r');
legend('Lower 34AGT2', 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RSS max_RSS]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
plot(d_AGTB2_Omni,RSS_AGTB2_Omni','d','Color','k');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','k');
legend('Lower AGTB2', 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RSS max_RSS]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
plot(d_NJPCB7_Omni,RSS_NJPCB7_Omni','s','Color','m');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','m');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','m');
legend( 'Lower NJPCB7', 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RSS max_RSS]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
plot(d_KIA,RSS_KIA','+','Color','b');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[0 50 100 150 200 250 300 350 400]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RSS (dBm)', 'FontSize', font_size,'Color','b');
legend('Lower KIA', 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RSS max_RSS]);


h(2).Position(3)=0.88;
h(1).Position(3)=0.88;
h(3).Position(3)=0.88;
h(4).Position(3)=0.88;
h(1).Position(2) = h(1).Position(2) + 0.07;
h(2).Position(2) = h(2).Position(2) + 0.07;
h(3).Position(2) = h(3).Position(2) + 0.07;
h(4).Position(2) = h(4).Position(2) + 0.07;

print('Results/Lower_RSS_Combined','-depsc');
print('Results/Lower_RSS_Combined','-dpng');
savefig(strcat('Results/Lower_RSS_Combined','.fig'));

