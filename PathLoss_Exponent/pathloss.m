clc;
clear all;
close all;
format long g;

T = xlsread('PathLoss_Data_Without_Car_Lower.xlsx');
%T = xlsread('PathLoss_Data_Without_Car.xlsx');
% 
% M = sortrows(T,1);

% d = [30.4844444444444 60.9625 114.301425 152.4006 182.880433333333 213.36022 243.84 274.32 304.8]./1000;
% 
% PL = [100.207571777778 102.16107725 106.270006625 104.638443625 107.126600833333 107.0882492 110.23695 107.65402 109.052201];

d = T(:,1)./1000;
PL = T(:,2);

%plot(PL, log10(d), '*');

n = linspace(2,3,1000);

PL_calc = zeros(length(d),length(n));

constant = 20*log10(5.8e3)+32.44;

for i = 1:length(d)
    PL_calc(i,:) = constant+n.*(10*log10(d(i)));
end

error = zeros(1,length(n));

for i = 1:length(n)
   error(i) = immse(PL,PL_calc(:,i)); 
end

[val, index] = min(error);

n(index)

%2.21821821821822  Upper
%2.12812812812813  Lower

    