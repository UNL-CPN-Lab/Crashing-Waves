clc
clear all
close all

samp_rate = 500e3;

ts = 1/samp_rate;

symbol_time = ts*192;

fd = linspace(0,600,10000);

bessel_bin_all = zeros(10000,25);

for i = 0:24
    bessel_bin_all(:,i+1) = besselj(0,2*pi*fd*symbol_time*i) ;
end
 
save bessel_bin_all.mat bessel_bin_all