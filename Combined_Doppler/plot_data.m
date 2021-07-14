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
legend4 = 'Model';

xWidth = 1;
yWidth = 1;

subidx = 0;
min_v = 1;
max_v = 100;
min_DS = 0;
max_DS= 500;
font_size = 30;

cell31={{['-g']};{['-g']};{['-g']}};
figure('units','normalized','outerposition',[0 0 xWidth yWidth])
C = {cell31};
[h,labelfontsize] = subplotplus(C);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(v_high,doppler_high,'*','Color','r');
hold on;
semilogx(v_model_high,doppler_model_high,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 20 30 50 100],'XTickLabel',[], 'YTick',[0 100 200 300 400 ],'YTickLabel',[0 100 200 300 400 ]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('DS (Hz)', 'FontSize', font_size,'Color','r');
legend(legend1, legend4, 'Location','Northeast' )
xlim([min_v max_v]);
ylim([min_DS max_DS]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(v_sedan,doppler_sedan,'*','Color','b');
hold on;
semilogx(v_model_sedan,doppler_model_sedan,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 20 30 50 100],'XTickLabel',[], 'YTick',[0 100 200 300 400 ],'YTickLabel',[0 100 200 300 400 ]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('DS (Hz)', 'FontSize', font_size,'Color','b');
legend(legend2, legend4, 'Location','Northeast' )
xlim([min_v max_v]);
ylim([min_DS max_DS]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(v_concrete,doppler_concrete,'*','Color','k');
hold on;
semilogx(v_model_concrete,doppler_model_concrete,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 20 30 50 100],'XTickLabel',[1 10 20 30 50 100], 'YTick',[0 100 200 300 400 ],'YTickLabel',[0 100 200 300 400 ]);
xlabel('Velocity (m/s)', 'FontSize', font_size);
ylabel('DS (Hz)', 'FontSize', font_size,'Color','k');
legend(legend3, legend4, 'Location','Northeast' )
xlim([min_v max_v]);
ylim([min_DS max_DS]);

grid on
box on


h(2).Position(3)=0.88;
h(1).Position(3)=0.88;
h(3).Position(3)=0.88;
h(1).Position(2) = h(1).Position(2) + 0.07;
h(2).Position(2) = h(2).Position(2) + 0.07;
h(3).Position(2) = h(3).Position(2) + 0.07;

% 
print('Results/DS1','-depsc');
print('Results/DS1','-dpng');
savefig(strcat('Results/DS1','.fig'));

legend1 = 'Barrier-height';
legend2 = 'Pickup';
legend3 = 'Steel';
legend4 = 'Model';

subidx = 0;
min_v = 1;
max_v = 100;
min_DS = 0;
max_DS= 500;
font_size = 30;

cell31={{['-g']};{['-g']};{['-g']}};
figure('units','normalized','outerposition',[0 0 xWidth yWidth])
C = {cell31};
[h,labelfontsize] = subplotplus(C);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(v_low,doppler_low,'*','Color','r');
hold on;
semilogx(v_model_low,doppler_model_low,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','r');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 20 30 50 100],'XTickLabel',[], 'YTick',[0 100 200 300 400 ],'YTickLabel',[0 100 200 300 400 ]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('DS (Hz)', 'FontSize', font_size,'Color','r');
legend(legend1, legend4, 'Location','Northeast' )
xlim([min_v max_v]);
ylim([min_DS max_DS]);


subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(v_pickup,doppler_pickup,'*','Color','b');
hold on;
semilogx(v_model_pickup,doppler_model_pickup,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','b');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 20 30 50 100],'XTickLabel',[], 'YTick',[0 100 200 300 400 ],'YTickLabel',[0 100 200 300 400 ]);
%xlabel('Time (sec)', 'FontSize', font_size);
ylabel('DS (Hz)', 'FontSize', font_size,'Color','b');
legend(legend2, legend4, 'Location','Northeast' )
xlim([min_v max_v]);
ylim([min_DS max_DS]);

subidx = subidx + 1;
set(gcf,'CurrentAxes',h(subidx));
semilogx(v_steel,doppler_steel,'*','Color','k');
hold on;
semilogx(v_model_steel,doppler_model_steel,'h','Color','g');
hold off;
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold','YColor','k');
set(h(subidx),'XGrid','on','YGrid','on','Box','on','XMinorTick','off','YMinorTick','off','XMinorGrid','off','YMinorGrid','off','XTick',[1 10 20 30 50 100],'XTickLabel',[1 10 20 30 50 100], 'YTick',[0 100 200 300 400 ],'YTickLabel',[0 100 200 300 400 ]);
xlabel('Velocity (m/s)', 'FontSize', font_size);
ylabel('DS (Hz)', 'FontSize', font_size,'Color','k');
legend(legend3, legend4, 'Location','Northeast' )
xlim([min_v max_v]);
ylim([min_DS max_DS]);


grid on
box on


h(2).Position(3)=0.88;
h(1).Position(3)=0.88;
h(3).Position(3)=0.88;
h(1).Position(2) = h(1).Position(2) + 0.07;
h(2).Position(2) = h(2).Position(2) + 0.07;
h(3).Position(2) = h(3).Position(2) + 0.07;

% 
print('Results/DS2','-depsc');
print('Results/DS2','-dpng');
savefig(strcat('Results/DS2','.fig'));