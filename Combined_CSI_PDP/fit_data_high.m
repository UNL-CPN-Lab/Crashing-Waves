clc;
close all;

clear all;

load rms_high.mat

load 34AGT2_87_d.mat
load 34AGT2_145_d.mat
load AGTB2_180_d.mat
load AGTB2_Omni_d.mat
load KIA_d.mat
load NJPCB_180_d.mat
load NJPCB_Omni_d.mat
load WIDT1_188_d.mat

d = {d_34AGT2_145, d_AGTB2_180, d_NJPCB_180, d_WIDT1_188};

s = zeros(size(d));
for i = 1:length(d)
    s(i) = length(d{i});
end
d_all = zeros(sum(s),1);
rms_all = zeros(sum(s),1);

start_idx = 1;
for i = 1:length(d)
    stop_idx = start_idx + s(i) - 1;
    d_all(start_idx:stop_idx) = d{i};
    rms_all(start_idx:stop_idx) = rms{i};
    start_idx = stop_idx + 1;
end



rms_all(isnan(rms_all))=1e-20;

total = [d_all rms_all];
total = sortrows(total);
d_all = total(:,1);
rms_all = total(:,2);
% 
% ref = min(find(d_all >100));
% T = rms_all(ref);

idx = find(d_all <0 );
d_all(idx) = [];
rms_all(idx) = [];
idx = [3200:44250 45400:55425];
d_all(idx) = [];
rms_all(idx) = [];

%f = fit(d_all,rms_all,'exp1')


X = log(d_all+1e-20);
XX = [ones(size(X)) X];
Y = log(rms_all);
B = XX\Y;
a = exp(B(1));
b = B(2);
% a = T;
% b = -b;

% merror = 1e9;
% idx = 0;
% power = linspace(-1,1,20001);
% for i = 1:length(power)
%     x = T.*(d_all.^power(i));
%     e = norm(rms_all - x);
%     if e < merror
%         merror = e;
%         idx = i;
%     end
% end
% %power(idx)
% 
%d_model = linspace(0,450,9000);
d_model = logspace(0,3,1000);
% a = T;
% b = power(idx);
rms_model = a.*(d_model.^b);

xWidth = 1;
yWidth = 1;
lineWidth = 3;
fontsize = 33;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
semilogx(d_all,rms_all.*1e6,'*')
hold on
semilogx(d_model, rms_model.*1e6,'d')
set(gca, 'FontSize', fontsize, 'FontWeight', 'Bold');
legend('Calculated','Model')
grid on;
box on;
xlim([0 450]);
ylim([0 30]);
xlabel('Distances(m)');
ylabel('RMS Delay Spread (\mus)');

% a * 1e6
% b
% rms_comp = a.*(d_all.^b);
% error = rms_all./rms_comp;
% error(1:2) = [];
% rms_comp(1:2) = [];
% rms_all(1:2) = [];
% edB = 10*log10(error);
% %edB([553 2038]) = [];
% std(edB,'omitnan')
% k = kurtosis(edB)
% %Rsquared = 1-sum((rms_all - rms_comp).^2)/sum((rms_all - mean(rms_all)).^2)
% Rsquared = 1-sum((log10(rms_all) - log10(rms_comp)).^2)/sum((log10(rms_all) - mean(log10(rms_all))).^2)

rms_high = rms_all;
d_high = d_all;
rms_model_high = rms_model;
d_model_high = d_model;
save rds_high.mat rms_high d_high rms_model_high d_model_high
