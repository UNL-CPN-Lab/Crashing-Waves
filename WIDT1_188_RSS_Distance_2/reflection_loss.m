clc;
clear all;
close all;

format long g

n1 = 1.003;
n2 = (sqrt(4.94-0.69j));

h = 1.06;
l = 27.73;

theta = 90 - atand(h/l);
theta1 = linspace(0,90,10000);
theta2 = asind((n1*sind(theta1))./n2);

gamma = (n2*cosd(theta1) - n1*cosd(theta2))./(n2*cosd(theta1) + n1*cosd(theta2));

figure;
plot(theta1,abs(gamma))
figure;
%plot(theta1,atan2(imag(gamma), real(gamma)))
plot(theta1,angle(gamma))
%ylim([0 pi])

idx = min(find(theta1 >=theta));
R = gamma(idx);

RL = -20*log10(abs(R))
