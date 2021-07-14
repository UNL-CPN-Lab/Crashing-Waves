clc;
clear all;
close all;

load CH_d_AGTB2_180.mat  
load CH_d_NJPCB7_180.mat 
load CH_d_34AGT2_145.mat  
load CH_d_AGTB2_Omni.mat  
load CH_d_NJPCB7_Omni.mat 
load CH_d_34AGT2_87.mat   
load CH_d_KIA.mat         
load CH_d_WIDT1_188.mat

legend1 = '1.45m Sedan Steel CT';
legend2 = '1.8m Pickup Steel CT';
legend3 = '1.8m Pickup Concrete CT';
legend4 = '1.88m Pickup Concrete LOS CT';
legend5 = '1.45m Sedan Steel Velocity';
legend6 = '1.8m Pickup Steel Velocity';
legend7 = '1.8m Pickup Concrete Velocity';
legend8 = '1.88m Pickup Concrete LOS Velocity';

xWidth = 1;
yWidth = 1;

subidx = 0;
min_d = 0;
max_d = 400;
min_CH = 0;
max_CH= 50;
min_V = 0;
max_V= 50;
font_size = 30;

cell41={{['-g']};{['-g']};{['-g']};{['-g']}};
figure('units','normalized','outerposition',[0 0 xWidth yWidth])
C = {cell41};
[h,labelfontsize] = subplotplus(C);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_34AGT2_145,CH_34AGT2_145','*','Color','r');
ylim([min_CH max_CH]);
ylabel('CT (ms)', 'FontSize', font_size,'Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
hold on;
yyaxis right;
plot(d_v_34AGT2_145,v_34AGT2_145','h','Color','b');
ylim([min_V max_V]);
ylabel('V (m/s)', 'FontSize', font_size,'Color','b');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
legend(legend1, legend5, 'Location','Northeast','Orientation','horizontal' )
xlim([min_d max_d]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_AGTB2_180,CH_AGTB2_180','d','Color','k');
ylim([min_CH max_CH]);
ylabel('CT (ms)', 'FontSize', font_size,'Color','k');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
hold on;
yyaxis right;
plot(d_v_AGTB2_180,v_AGTB2_180','s','Color','m');
ylim([min_V max_V]);
ylabel('V (m/s)', 'FontSize', font_size,'Color','m');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','m');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
legend(legend2, legend6, 'Location','Northeast','Orientation','horizontal' )
xlim([min_d max_d]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_NJPCB7_180,CH_NJPCB7_180','+','Color','r');
ylim([min_CH max_CH]);
ylabel('CT (ms)', 'FontSize', font_size,'Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
hold on;
yyaxis right;
plot(d_v_NJPCB7_180,v_NJPCB7_180','>','Color','b');
ylim([min_V max_V]);
ylabel('V (m/s)', 'FontSize', font_size,'Color','b');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
legend(legend3, legend7, 'Location','Northeast', 'Orientation','horizontal' )
xlim([min_d max_d]);


subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_WIDT1_188,CH_WIDT1_188','p','Color','k');
ylim([min_CH max_CH]);
ylabel('CT (ms)', 'FontSize', font_size,'Color','k');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
hold on;
yyaxis right;
plot(d_v_WIDT1_188,v_WIDT1_188','<','Color','m');
ylim([min_V max_V]);
ylabel('V (m/s)', 'FontSize', font_size,'Color','m');
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


print('Results/Upper_CH_d_Combined','-depsc');
print('Results/Upper_CH_d_Combined','-dpng');
savefig(strcat('Results/Upper_CH_d_Combined','.fig'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
legend1 = '0.87m Sedan Steel CT';
legend2 = '0.82m Pickup Steel CT';
legend3 = '0.82m Pickup Concrete CT';
legend4 = '1.0m Sedan Steel Wire CT';
legend5 = '0.87m Sedan Steel Velocity';
legen6 = '0.82m Pickup Steel Velocity';
legend7 = '0.82m Pickup Concrete Velocity';
legend8 = '1.0m Sedan Steel Wire Velocity';

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
plot(d_34AGT2_87,CH_34AGT2_87','*','Color','r');
ylim([min_CH max_CH]);
ylabel('CT (ms)', 'FontSize', font_size,'Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
hold on;
yyaxis right;
plot(d_v_34AGT2_87,v_34AGT2_87','h','Color','b');
ylim([min_V max_V]);
ylabel('V (m/s)', 'FontSize', font_size,'Color','b');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
legend(legend1, legend5, 'Location','Northeast','Orientation','horizontal' )
xlim([min_d max_d]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_AGTB2_Omni,CH_AGTB2_Omni','d','Color','k');
ylim([min_CH max_CH]);
ylabel('CT (ms)', 'FontSize', font_size,'Color','k');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
hold on;
yyaxis right;
plot(d_v_AGTB2_Omni,v_AGTB2_Omni','s','Color','m');
ylim([min_V max_V]);
ylabel('V (m/s)', 'FontSize', font_size,'Color','m');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','m');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
legend(legend2, legend6, 'Location','Northeast','Orientation','horizontal' )
xlim([min_d max_d]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_NJPCB7_Omni,CH_NJPCB7_Omni','+','Color','r');
ylim([min_CH max_CH]);
ylabel('CT (ms)', 'FontSize', font_size,'Color','r');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
hold on;
yyaxis right;
plot(d_v_NJPCB7_Omni,v_NJPCB7_Omni','>','Color','b');
ylim([min_V max_V]);
ylabel('V (m/s)', 'FontSize', font_size,'Color','b');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[]);
%xlabel('Time (sec)', 'FontSize', font_size);
legend(legend3, legend7, 'Location','Northeast', 'Orientation','horizontal' )
xlim([min_d max_d]);


subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
yyaxis left;
plot(d_KIA,CH_KIA','p','Color','k');
ylim([min_CH max_CH]);
ylabel('CT (ms)', 'FontSize', font_size,'Color','k');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
hold on;
yyaxis right;
plot(d_v_KIA,v_KIA','<','Color','m');
ylim([min_V max_V]);
ylabel('V (m/s)', 'FontSize', font_size,'Color','m');
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','m');
hold off;
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[0 50 100 150 200 250 300 350 400],'XTickLabel',[0 50 100 150 200 250 300 350 400]);
xlabel('Distance (m)', 'FontSize', font_size);
legend(legend4, legend8, 'Location','Northeast','Orientation','horizontal' )
xlim([min_d max_d]);


% 
% h(2).Position(3)=0.88;
% h(1).Position(3)=0.88;
% h(3).Position(3)=0.88;
% h(4).Position(3)=0.88;
% h(1).Position(2) = h(1).Position(2) + 0.07;
% h(2).Position(2) = h(2).Position(2) + 0.07;
% h(3).Position(2) = h(3).Position(2) + 0.07;
% h(4).Position(2) = h(4).Position(2) + 0.07;


print('Results/Lower_CH_d_Combined','-depsc');
print('Results/Lower_CH_d_Combined','-dpng');
savefig(strcat('Results/Lower_CH_d_Combined','.fig'));





