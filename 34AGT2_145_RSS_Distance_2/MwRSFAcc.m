clc; 
clear all;
close all;


filename = 'Filtered_Longitudinal_Acceleration_1.csv';
M1 = csvread(filename,3,0);

filename = 'Filtered_Longitudinal_Acceleration_2.csv';
M2 = csvread(filename,3,0);


t1 = M1(:,1);
t2 = M2(:,1);
a1 =  M1(:,2)*9.8;
a2 = M2(:,2)*9.8;

font_size = 30;
transperency = 0.2;
xWidth = 0.8;
yWidth = 0.8;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
plot(t1,a1,'*')
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
xlabel('Time (s)', 'FontSize', font_size);
ylabel('Acceleration (m/s^2)', 'FontSize', font_size,'Color','k');
grid on
grid minor
box on
print('Results/34agt2_145_Acceleration','-depsc');
print('Results/34agt2_145_Acceleration','-dpng');
savefig(strcat('Results/34agt2_145_Acceleration','.fig'));

v1 = cumtrapz(t1,a1);
v2 = cumtrapz(t2,a2);

xx = -12.2720;

figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
plot(t1,v1,'*')
hold on
plot(t1, zeros(1,length(t1)))
line([xx xx],[-30 30],'LineWidth',5,'Color','g')
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
xlabel('Time (s)', 'FontSize', font_size);
ylabel('Velocity (m/s)', 'FontSize', font_size,'Color','k');
grid on
grid minor
box on
print('Results/34agt2_145_Velocity','-depsc');
print('Results/34agt2_145_Velocity','-dpng');
savefig(strcat('Results/34agt2_145_Velocity','.fig'));

d1 = cumtrapz(t1,v1);
d2 = cumtrapz(t2,v2);

figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
plot(t1,d1,'*')
hold on
plot(t1, zeros(1,length(t1)))
line([xx xx],[-30 30],'LineWidth',5,'Color','g')
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
xlabel('Time (s)', 'FontSize', font_size);
ylabel('Distance (m)', 'FontSize', font_size,'Color','k');
grid on
grid minor
box on
print('Results/34agt2_145_Distance','-depsc');
print('Results/34agt2_145_Distance','-dpng');
savefig(strcat('Results/34agt2_145_Distance','.fig'));



load preamble_time_shifted.mat

preamble_time = preamble_time - 5;

start = min(find(preamble_time >= -20));

end_ = max(find(preamble_time <= 20));

p = preamble_time(start:end_);

index = zeros(length(preamble_time),1);

t = t1;

j = 1;

for i = 1:length(p)
    
    index(j) = min(find(t >= p(i)));
    j = j + 1;
    
end
index = index(1:j-1);
tt = t(index);
dd = d1(index);

ref = dd(min(find(tt >=0)));
ddd = ref-dd+20.42;

v = v1;

save MwRSF_Data.mat tt dd start end_ ddd vv v

