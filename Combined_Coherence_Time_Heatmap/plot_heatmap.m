clc;
clear all;
close all;

load 34AGT2_87_coh_time_hm.mat
load 34AGT2_145_coh_time_hm.mat
load AGTB2_180_coh_time_hm.mat
load AGTB2_Omni_coh_time_hm.mat
load KIA_coh_time_hm.mat
load NJPCB_180_coh_time_hm.mat
load NJPCB_Omni_coh_time_hm.mat
load WIDT1_188_coh_time_hm.mat

n = 100;

H = zeros(n,n);
C = zeros(n,n);
d = linspace(0,450,n);
v=linspace(0,30,n);

coh_time_high = [coh_time_34AGT2_145'; coh_time_AGTB2_180'; coh_time_NJPCB_180'; coh_time_WIDT1_188'  ].*1000;

d_high = [d_34AGT2_145; d_AGTB2_180; d_NJPCB_180; d_WIDT1_188  ];

v_high = [v_34AGT2_145; v_AGTB2_180; v_NJPCB_180; v_WIDT1_188  ];

for i = 1:length(coh_time_high)
    if d_high(i) < 0 | d_high(i) > 450 | v_high(i) < 0 | v_high(i) > 30
        continue;
    end
    
    idx_d = min(find(d >= d_high(i)));
    idx_v = min(find(v >= v_high(i)));
    H(idx_d,idx_v) = H(idx_d,idx_v)+coh_time_high(i);
    C(idx_d,idx_v) = C(idx_d,idx_v)+1;
end

H_mean = H./C;
fontsize = 20;
xWidth = 1;
yWidth = 1;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
h =  heatmap(H_mean);
colormap summer
set(gca, 'FontSize', fontsize);
xLabels = repmat({''}, 1, n);
for i = 1:10:n
    xLabels{i} = sprintf('%f',d(i));
end
h.XDisplayLabels = xLabels;

yLabels = repmat({''}, 1, n);
for i = 1:10:n
    yLabels{i} = sprintf('%f',v(i));
end
h.YDisplayLabels = yLabels;
h.XLabel = 'Distance (m)';
h.YLabel = 'Velocity(m/s)';

print('Results/Coh_time_Combined_High_HM','-depsc');
print('Results/Coh_time_Combined_High_HM','-dpng');
savefig(strcat('Results/Coh_time_Combined_High_HM','.fig'));

n = 100;

H = zeros(n,n);
C = zeros(n,n);
d = linspace(0,450,n);
v=linspace(0,30,n);

coh_time_low = [coh_time_34AGT2_87'; coh_time_AGTB2_Omni'; coh_time_NJPCB_Omni'; coh_time_KIA'  ].*1000;

d_low = [d_34AGT2_87; d_AGTB2_Omni; d_NJPCB_Omni; d_KIA  ];

v_low = [v_34AGT2_87; v_AGTB2_Omni; v_NJPCB_Omni; v_KIA  ];


for i = 1:length(coh_time_low)
    if d_low(i) < 0 | d_low(i) > 450 | v_low(i) < 0 | v_low(i) > 30
        continue;
    end
    
    idx_d = min(find(d >= d_low(i)));
    idx_v = min(find(v >= v_low(i)));
    H(idx_d,idx_v) = H(idx_d,idx_v)+coh_time_low(i);
    C(idx_d,idx_v) = C(idx_d,idx_v)+1;
end

H_mean = H./C;
fontsize = 20;
xWidth = 1;
yWidth = 1;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
h =  heatmap(H_mean);
colormap summer
set(gca, 'FontSize', fontsize);
xLabels = repmat({''}, 1, n);
for i = 1:10:n
    xLabels{i} = sprintf('%f',d(i));
end
h.XDisplayLabels = xLabels;

yLabels = repmat({''}, 1, n);
for i = 1:10:n
    yLabels{i} = sprintf('%f',v(i));
end
h.YDisplayLabels = yLabels;
h.XLabel = 'Distance (m)';
h.YLabel = 'Velocity(m/s)';

print('Results/Coh_time_Combined_Low_HM','-depsc');
print('Results/Coh_time_Combined_Low_HM','-dpng');
savefig(strcat('Results/Coh_time_Combined_Low_HM','.fig'));