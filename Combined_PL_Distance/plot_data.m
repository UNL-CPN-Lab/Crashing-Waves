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

legend1 = 'Upper Sedan Steel';
legend2 = 'Upper Pickup Steel';
legend3 = 'Upper Pickup Concrete';
legend4 = 'Upper Pickup Concrete LOS';
legend5 = 'Upper Calculated';

n = 2.21821821821822 ; % upper
constant = 20*log10(5.8e3)+32.44;
d_PL_U = linspace(0,400,200);
PL_Calc_U = constant+n.*(10*log10(abs(d_PL_U./1000)));

xWidth = 0.8;
yWidth = 1;
font_size = 40;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
semilogy(d_34AGT2_145,PL_34AGT2_145','*','Color','r');
hold on;
semilogy(d_AGTB2_180,PL_AGTB2_180','d','Color','k');
semilogy(d_NJPCB7_180,PL_NJPCB7_180','s','Color','m');
semilogy(d_WIDT1_188,PL_WIDT1_188','+','Color','b');
semilogy(d_PL_U,PL_Calc_U','h','Color','g');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
grid on
box on
legend(legend1, legend2, legend3, legend4,legend5, 'Location','Southeast' )
xlim([0 400])
ylim([60 130])
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('Pathloss (dB) in Log Scale', 'FontSize', font_size,'Color','k');


print('Results/Upper_PL_All','-depsc');
print('Results/Upper_PL_All','-dpng');
savefig(strcat('Results/Upper_PL_All','.fig'));

subidx = 0;
min_d = 0;
max_d = 400;
min_PL = 60;
max_PL= 130;
font_size = 30;

cell51={{['-g']};{['-g']};{['-g']};{['-g']};{['-g']}};
figure('units','normalized','outerposition',[0 0 xWidth yWidth])
C = {cell51};
[h,labelfontsize] = subplotplus(C);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogy(d_34AGT2_145,PL_34AGT2_145','*','Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('PL (dB)', 'FontSize', font_size,'Color','r');
legend(legend1, 'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogy(d_AGTB2_180,PL_AGTB2_180','d','Color','k');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('PL (dB)', 'FontSize', font_size,'Color','k');
legend(legend2, 'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogy(d_NJPCB7_180,PL_NJPCB7_180','s','Color','m');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','m');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('PL (dB)', 'FontSize', font_size,'Color','m');
legend( legend3, 'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogy(d_WIDT1_188,PL_WIDT1_188','+','Color','b');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('PL (dB)', 'FontSize', font_size,'Color','b');
legend(legend4, 'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogy(d_PL_U,PL_Calc_U','h','Color','g');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','g');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[0 50 100 150 200 250 300 350 400]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('PL (dB)', 'FontSize', font_size,'Color','g');
legend(legend5, 'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);


h(2).Position(3)=0.88;
h(1).Position(3)=0.88;
h(3).Position(3)=0.88;
h(4).Position(3)=0.88;
h(5).Position(3)=0.88;
h(1).Position(2) = h(1).Position(2) + 0.07;
h(2).Position(2) = h(2).Position(2) + 0.07;
h(3).Position(2) = h(3).Position(2) + 0.07;
h(4).Position(2) = h(4).Position(2) + 0.07;
h(5).Position(2) = h(5).Position(2) + 0.07;

print('Results/Upper_PL_Combined','-depsc');
print('Results/Upper_PL_Combined','-dpng');
savefig(strcat('Results/Upper_PL_Combined','.fig'));

legend1 = 'Lower Sedan Steel';
legend2 = 'Lower Pickup Steel';
legend3 = 'Lower Pickup Concrete';
legend4 = 'Lower Sedan Steel Wire';
legend5 = 'Lower Calculated';

n = 2.12812812812813; %  Lower
constant = 20*log10(5.8e3)+32.44;
d_PL_L = linspace(0,400,200);
PL_Calc_L = constant+n.*(10*log10(abs(d_PL_U./1000)));

font_size = 40;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
semilogy(d_34AGT2_87,PL_34AGT2_87','*','Color','r');
hold on;
semilogy(d_AGTB2_Omni,PL_AGTB2_Omni','d','Color','k');
semilogy(d_NJPCB7_Omni,PL_NJPCB7_Omni','s','Color','m');
semilogy(d_KIA,PL_KIA','+','Color','b');
semilogy(d_PL_L,PL_Calc_L','h','Color','g');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
grid on
box on
legend(legend1, legend2, legend3, legend4, legend5, 'Location','Southeast' )
xlim([0 250])
ylim([60 130])
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('Pathloss (dB) in Log Scale', 'FontSize', font_size,'Color','k');

print('Results/Lower_PL_All','-depsc');
print('Results/Lower_PL_All','-dpng');
savefig(strcat('Results/Lower_PL_All','.fig'));


subidx = 0;
min_d = 0;
max_d = 250;
min_PL = 60;
max_PL= 130;
font_size = 30;

cell51={{['-g']};{['-g']};{['-g']};{['-g']};{['-g']}};
figure('units','normalized','outerposition',[0 0 xWidth yWidth])
C = {cell51};
[h,labelfontsize] = subplotplus(C);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogy(d_34AGT2_87,PL_34AGT2_87','*','Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('PL (dB)', 'FontSize', font_size,'Color','r');
legend(legend1, 'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogy(d_AGTB2_Omni,PL_AGTB2_Omni','d','Color','k');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('PL (dB)', 'FontSize', font_size,'Color','k');
legend(legend2, 'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogy(d_NJPCB7_Omni,PL_NJPCB7_Omni','s','Color','m');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','m');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('PL (dB)', 'FontSize', font_size,'Color','m');
legend( legend3, 'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogy(d_KIA,PL_KIA','+','Color','b');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('PL (dB)', 'FontSize', font_size,'Color','b');
legend(legend4, 'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogy(d_PL_L,PL_Calc_L,'h','Color','g');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','g');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[0 50 100 150 200 250 300 350 400]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('PL (dB)', 'FontSize', font_size,'Color','g');
legend(legend5, 'Location','Southeast' )
xlim([min_d max_d]);
ylim([min_PL max_PL]);


h(2).Position(3)=0.88;
h(1).Position(3)=0.88;
h(3).Position(3)=0.88;
h(5).Position(3)=0.88;
h(4).Position(3)=0.88;
h(1).Position(2) = h(1).Position(2) + 0.07;
h(2).Position(2) = h(2).Position(2) + 0.07;
h(3).Position(2) = h(3).Position(2) + 0.07;
h(4).Position(2) = h(4).Position(2) + 0.07;
h(5).Position(2) = h(5).Position(2) + 0.07;

print('Results/Lower_PL_Combined','-depsc');
print('Results/Lower_PL_Combined','-dpng');
savefig(strcat('Results/Lower_PL_Combined','.fig'));

