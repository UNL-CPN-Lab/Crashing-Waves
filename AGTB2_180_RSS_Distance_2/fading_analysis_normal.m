clc;
clear all;
close all;

format long g

load random_stat.mat

mu = mean(error,'omitnan');

sigma = std(error,'omitnan');

pd = makedist('Normal','mu',mu,'sigma',sigma);

%[h,p,stat] = chi2gof(error);

k = 8;

h = histogram(error,k);
hold on;


v = h.Values;
b = h.BinEdges;

x = b(1:end-1) + diff(b)/2;

y = pdf(pd,x);

xx = linspace(-25,25,1000);
yy = pdf(pd,xx);

plot(xx,yy.*(max(v)/max(yy)),'Linewidth',3)

observed = v./(sum(v));
expected = y./(sum(y));
chi2 = sum(((observed-expected).^2)./expected);

chi2inv(0.95,k-1)

p = gammainc(chi2/2,(k-1)/2,'upper');

kurtosis(error)