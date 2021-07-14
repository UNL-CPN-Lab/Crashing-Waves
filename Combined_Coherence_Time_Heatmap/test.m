clc
clear all
close all

x = rand(10,100);

x(5,5) = nan;

h =  heatmap(x)

xLabels = repmat({''}, 1, 100);

for i = 1:10:size(x,2)
    xLabels{i} = sprintf('%d',i);
end



h.XDisplayLabels = xLabels;