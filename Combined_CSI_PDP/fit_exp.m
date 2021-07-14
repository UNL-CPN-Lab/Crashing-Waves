clc
close all

load rms_high.mat

for i = 1:length(rms)
    plot(d{i},rms{i},'*')
    hold on
end
