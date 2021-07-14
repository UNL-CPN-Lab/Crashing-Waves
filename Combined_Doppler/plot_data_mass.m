clc;
clear all;
close all;

load doppler_high.mat
load doppler_sedan.mat
load doppler_concrete.mat
load doppler_low.mat
load doppler_pickup.mat
load doppler_steel.mat

legend1 = 'Vehicle-height';
legend2 = 'Sedan';
legend3 = 'Concrete';
legend4 = 'Barrier-height';
legend5 = 'Pickup';
legend6 = 'Steel';

xWidth = 1;
yWidth = 1;

subidx = 0;
min_v = 1;
max_v = 30;
min_DS = 0;
max_DS= 500;
font_size = 60;

figure('units','normalized','outerposition',[0 0 xWidth yWidth])
semilogx(v_high,doppler_high,'*','Color','r');
hold on;
semilogx(v_model_high,doppler_model_high,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
set(gca,'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 20 30 50 100],'XTickLabel',[1 10 20 30 50 100], 'YTick',[0 100 200 300 400 ],'YTickLabel',[0 100 200 300 400 ]);
xlabel('Velocity (m/s)', 'FontSize', font_size);
ylabel('DS(Hz)', 'FontSize', font_size,'Color','r');
legend(legend1, 'Location','Northeast' )
xlim([min_v max_v]);
ylim([min_DS max_DS]);
print('Results/DS-Vehicle','-depsc');
print('Results/DS-Vehicle','-dpng');
savefig(strcat('Results/DS-Vehicle','.fig'));


figure('units','normalized','outerposition',[0 0 xWidth yWidth])
semilogx(v_low,doppler_low,'*','Color','r');
hold on;
semilogx(v_model_low,doppler_model_low,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
set(gca,'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 20 30 50 100],'XTickLabel',[1 10 20 30 50 100], 'YTick',[0 100 200 300 400 ],'YTickLabel',[0 100 200 300 400 ]);
xlabel('Velocity (m/s)', 'FontSize', font_size);
ylabel('DS(Hz)', 'FontSize', font_size,'Color','r');
legend(legend4, 'Location','Northeast' )
xlim([min_v max_v]);
ylim([min_DS max_DS]);
print('Results/DS-Barrier','-depsc');
print('Results/DS-Barrier','-dpng');
savefig(strcat('Results/DS-Barrier','.fig'));


figure('units','normalized','outerposition',[0 0 xWidth yWidth])
semilogx(v_sedan,doppler_sedan,'*','Color','k');
hold on;
semilogx(v_model_sedan,doppler_model_sedan,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
set(gca,'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 20 30 50 100],'XTickLabel',[1 10 20 30 50 100], 'YTick',[0 100 200 300 400 ],'YTickLabel',[0 100 200 300 400 ]);
xlabel('Velocity (m/s)', 'FontSize', font_size);
ylabel('DS(Hz)', 'FontSize', font_size,'Color','k');
legend(legend2, 'Location','Northeast' )
xlim([min_v max_v]);
ylim([min_DS max_DS]);
print('Results/DS-Sedan','-depsc');
print('Results/DS-Sedan','-dpng');
savefig(strcat('Results/DS-Sedan','.fig'));


figure('units','normalized','outerposition',[0 0 xWidth yWidth])
semilogx(v_pickup,doppler_pickup,'*','Color','k');
hold on;
semilogx(v_model_pickup,doppler_model_pickup,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
set(gca,'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 20 30 50 100],'XTickLabel',[1 10 20 30 50 100], 'YTick',[0 100 200 300 400 ],'YTickLabel',[0 100 200 300 400 ]);
xlabel('Velocity (m/s)', 'FontSize', font_size);
ylabel('DS(Hz)', 'FontSize', font_size,'Color','k');
legend(legend5, 'Location','Northeast' )
xlim([min_v max_v]);
ylim([min_DS max_DS]);
print('Results/DS-Pickup','-depsc');
print('Results/DS-Pickup','-dpng');
savefig(strcat('Results/DS-Pickup','.fig'));


figure('units','normalized','outerposition',[0 0 xWidth yWidth])
semilogx(v_concrete,doppler_concrete,'*','Color','b');
hold on;
semilogx(v_model_concrete,doppler_model_concrete,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
set(gca,'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 20 30 50 100],'XTickLabel',[1 10 20 30 50 100], 'YTick',[0 100 200 300 400 ],'YTickLabel',[0 100 200 300 400 ]);
xlabel('Velocity (m/s)', 'FontSize', font_size);
ylabel('DS(Hz)', 'FontSize', font_size,'Color','b');
legend(legend3, 'Location','Northeast' )
xlim([min_v max_v]);
ylim([min_DS max_DS]);
print('Results/DS-Concrete','-depsc');
print('Results/DS-Concrete','-dpng');
savefig(strcat('Results/DS-Concrete','.fig'));


figure('units','normalized','outerposition',[0 0 xWidth yWidth])
semilogx(v_steel,doppler_steel,'*','Color','b');
hold on;
semilogx(v_model_steel,doppler_model_steel,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
set(gca,'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 20 30 50 100],'XTickLabel',[1 10 20 30 50 100], 'YTick',[0 100 200 300 400 ],'YTickLabel',[0 100 200 300 400 ]);
xlabel('Velocity (m/s)', 'FontSize', font_size);
ylabel('DS(Hz)', 'FontSize', font_size,'Color','b');
legend(legend6, 'Location','Northeast' )
xlim([min_v max_v]);
ylim([min_DS max_DS]);
print('Results/DS-Steel','-depsc');
print('Results/DS-Steel','-dpng');
savefig(strcat('Results/DS-Steel','.fig'));