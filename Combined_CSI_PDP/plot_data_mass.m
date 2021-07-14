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
legend4 = 'Barrier-height';
legend5 = 'Pickup';
legend6 = 'Steel';


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
max_d = 400;
min_RDS = 0;
max_RDS= 30;
font_size = 60;


figure('units','normalized','outerposition',[0 0 xWidth yWidth])
semilogx(d_high,rms_high.*1e6,'*','Color','r');
hold on;
semilogx(d_model_high,rms_model_high.*1e6,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
set(gca,'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',{'1' '10' '' '100' '' '' '' '' '' '400' '1000'}, 'YTick',[0 15 30],'YTickLabel',{'0' '15' '30' });
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('RDS(\mus)', 'FontSize', font_size,'Color','r');
legend(legend1, 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RDS max_RDS]);
print('Results/RDS-Vehicle','-depsc');
print('Results/RDS-Vehicle','-dpng');
savefig(strcat('Results/RDS-Vehicle','.fig'));

figure('units','normalized','outerposition',[0 0 xWidth yWidth])
semilogx(d_low,rms_low.*1e6,'*','Color','r');
hold on;
semilogx(d_model_low,rms_model_low.*1e6,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
set(gca,'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',{'1' '10' '' '100' '' '' '250' '' '350' '400' '1000'}, 'YTick',[0 15 30],'YTickLabel',{'0' '15' '30' });
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('RDS(\mus)', 'FontSize', font_size,'Color','r');
legend(legend4, 'Location','Northeast' )
xlim([min_d 250]);
ylim([min_RDS max_RDS]);
print('Results/RDS-Barrier','-depsc');
print('Results/RDS-Barrier','-dpng');
savefig(strcat('Results/RDS-Barrier','.fig'));

figure('units','normalized','outerposition',[0 0 xWidth yWidth])
semilogx(d_sedan,rms_sedan.*1e6,'*','Color','k');
hold on;
semilogx(d_model_sedan,rms_model_sedan.*1e6,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
set(gca,'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',{'1' '10' '' '100' '' '' '250' '' '350' '400' '1000'}, 'YTick',[0 15 30],'YTickLabel',{'0' '15' '30' });
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('RDS(\mus)', 'FontSize', font_size,'Color','k');
legend(legend2, 'Location','Northeast' )
xlim([min_d 250]);
ylim([min_RDS max_RDS]);
print('Results/RDS-Sedan','-depsc');
print('Results/RDS-Sedan','-dpng');
savefig(strcat('Results/RDS-Sedan','.fig'));

figure('units','normalized','outerposition',[0 0 xWidth yWidth])
semilogx(d_pickup,rms_pickup.*1e6,'*','Color','k');
hold on;
semilogx(d_model_pickup,rms_model_pickup.*1e6,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
set(gca,'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',{'1' '10' '' '100' '' '' '' '' '350' '400' '1000'}, 'YTick',[0 15 30],'YTickLabel',{'0' '15' '30' });
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('RDS(\mus)', 'FontSize', font_size,'Color','k');
legend(legend5, 'Location','Northeast' )
xlim([min_d 350]);
ylim([min_RDS max_RDS]);
print('Results/RDS-Pickup','-depsc');
print('Results/RDS-Pickup','-dpng');
savefig(strcat('Results/RDS-Pickup','.fig'));


figure('units','normalized','outerposition',[0 0 xWidth yWidth])
semilogx(d_concrete,rms_concrete.*1e6,'*','Color','b');
hold on;
semilogx(d_model_concrete,rms_model_concrete.*1e6,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
set(gca,'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',{'1' '10' '' '100' '' '' '' '' '' '400' '1000'}, 'YTick',[0 15 30],'YTickLabel',{'0' '15' '30' });
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('RDS(\mus)', 'FontSize', font_size,'Color','b');
legend(legend3, 'Location','Northeast' )
xlim([min_d max_d]);
ylim([min_RDS max_RDS]);
print('Results/RDS-Concrete','-depsc');
print('Results/RDS-Concrete','-dpng');
savefig(strcat('Results/RDS-Concrete','.fig'));


figure('units','normalized','outerposition',[0 0 xWidth yWidth])
semilogx(d_steel,rms_steel.*1e6,'*','Color','b');
hold on;
semilogx(d_model_steel,rms_model_steel.*1e6,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
set(gca,'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',{'1' '10' '' '100' '' '' '250' '' '' '400' '1000'}, 'YTick',[0 15 30],'YTickLabel',{'0' '15' '30' });
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('RDS(\mus)', 'FontSize', font_size,'Color','b');
legend(legend6, 'Location','Northeast' )
xlim([min_d 250]);
ylim([min_RDS max_RDS]);
print('Results/RDS-Steel','-depsc');
print('Results/RDS-Steel','-dpng');
savefig(strcat('Results/RDS-Steel','.fig'));
