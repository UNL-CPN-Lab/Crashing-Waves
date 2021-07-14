clc;
clear all;
close all;

load rds_high.mat
load rds_sedan.mat
load rds_concrete.mat
load rds_low.mat
load rds_pickup.mat
load rds_steel.mat

legend1 = 'Vehicle-height';
legend2 = 'Sedan';
legend3 = 'Concrete';
legend4 = 'Model';

high = mean(rms_high)
low = mean(rms_low)

sedan = mean(rms_sedan)
pickup = mean(rms_pickup)

concrete = mean(rms_concrete)
steel= mean(rms_steel)

xWidth = 1;
yWidth = 1;

subidx = 0;
min_d = 1;
max_d = 1000;
min_RDS = 0;
max_RDS= 50;
font_size = 30;

cell31={{['-g']};{['-g']};{['-g']}};
figure('units','normalized','outerposition',[0 0 xWidth yWidth])
C = {cell31};
[h,labelfontsize] = subplotplus(C);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(d_high,rms_high.*1e6,'*','Color','r');
hold on;
semilogx(d_model_high,rms_model_high.*1e6,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',[], 'YTick',[0 20 40],'YTickLabel',{'0' '20' '40' });
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RDS(\mus)', 'FontSize', font_size,'Color','r');
legend(legend1, legend4, 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RDS max_RDS]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(d_sedan,rms_sedan.*1e6,'*','Color','b');
hold on;
semilogx(d_model_sedan,rms_model_sedan.*1e6,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',[], 'YTick',[0 20 40],'YTickLabel',{'0' '20' '40' });
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RDS(\mus)', 'FontSize', font_size,'Color','b');
legend(legend2, legend4, 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RDS max_RDS]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(d_concrete,rms_concrete.*1e6,'*','Color','k');
hold on;
semilogx(d_model_concrete,rms_model_concrete.*1e6,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',{'1' '10' '' '100' '' '' '' '' '' '' '1000'}, 'YTick',[0 20 40],'YTickLabel',{'0' '20' '40' });
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('RDS(\mus)', 'FontSize', font_size,'Color','k');
legend(legend3, legend4, 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RDS max_RDS]);

grid on
box on


h(2).Position(3)=0.88;
h(1).Position(3)=0.88;
h(3).Position(3)=0.88;
h(1).Position(2) = h(1).Position(2) + 0.07;
h(2).Position(2) = h(2).Position(2) + 0.07;
h(3).Position(2) = h(3).Position(2) + 0.07;


print('Results/RDS1','-depsc');
print('Results/RDS1','-dpng');
savefig(strcat('Results/RDS1','.fig'));

legend1 = 'Barrier-height';
legend2 = 'Pickup';
legend3 = 'Steel';
legend4 = 'Model';

subidx = 0;
min_d = 1;
max_d = 1000;
min_RDS = 0;
max_RDS= 50;
font_size = 30;

cell31={{['-g']};{['-g']};{['-g']}};
figure('units','normalized','outerposition',[0 0 xWidth yWidth])
C = {cell31};
[h,labelfontsize] = subplotplus(C);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(d_low,rms_low.*1e6,'*','Color','r');
hold on;
semilogx(d_model_low,rms_model_low.*1e6,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',[], 'YTick',[0 20 40],'YTickLabel',{'0' '20' '40' });
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RDS(\mus)', 'FontSize', font_size,'Color','r');
legend(legend1, legend4, 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RDS max_RDS]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(d_pickup,rms_pickup.*1e6,'*','Color','b');
hold on;
semilogx(d_model_pickup,rms_model_pickup.*1e6,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',[], 'YTick',[0 20 40],'YTickLabel',{'0' '20' '40' });
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('RDS(\mus)', 'FontSize', font_size,'Color','b');
legend(legend2, legend4, 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RDS max_RDS]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(d_steel,rms_steel.*1e6,'*','Color','k');
hold on;
semilogx(d_model_steel,rms_model_steel.*1e6,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',{'1' '10' '' '100' '' '' '' '' '' '' '1000'}, 'YTick',[0 20 40],'YTickLabel',{'0' '20' '40' });
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('RDS(\mus)', 'FontSize', font_size,'Color','k');
legend(legend3, legend4, 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RDS max_RDS]);

grid on
box on


h(2).Position(3)=0.88;
h(1).Position(3)=0.88;
h(3).Position(3)=0.88;
h(1).Position(2) = h(1).Position(2) + 0.07;
h(2).Position(2) = h(2).Position(2) + 0.07;
h(3).Position(2) = h(3).Position(2) + 0.07;


print('Results/RDS2','-depsc');
print('Results/RDS2','-dpng');
savefig(strcat('Results/RDS2','.fig'));