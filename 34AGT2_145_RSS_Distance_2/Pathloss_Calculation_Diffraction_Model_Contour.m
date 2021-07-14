clc;
clear variables;
close all;

load rx_ofdm_iq_clean.mat
load header_full.mat
load evm_ts_gapped.mat
load preamble_time_shifted.mat
load pathloss_data_high_ref.mat
load KV_model_RSS.mat
load MwRSF_Data.mat


freq = 5.8e9;
lamda = physconst('LightSpeed')/freq;

d_0 = 5.6;
l = 3.66;

Overall_PSD_split = rx_ofdm_iq;



r_PL = logspace(0,3,100);

delta_PL = linspace(0,pi/2,100);

[r_PL, delta_PL] = organize_vector(r_PL, delta_PL);
r_PL = r_PL';
delta_PL = delta_PL';

d_ref = 30.48;
%PL_calc = 96.524509 + 10*n_high*log10(d_PL./d_ref);
d_PL = sqrt(r_PL.^2 - l^2);
Theta_PL = asind((d_PL./r_PL));
%delta_PL = (abs(Theta_PL-Theta(1))).*(pi/180);
d_range = [30.48 60.96 91.44 121.92 152.4 182.88 213.36 243.86 274.32 304.8];
theta = [0, 3, 6, 10, 20, 30, 60, 90].*(pi/180);



hV = 1.45; %Vehicle height
hB = 0.87; %Barrier height

P1 = [d_PL.*cosd(25); d_PL.*sind(25); (hV - hB).*ones(1,length(d_PL))];
P2 = [l*cosd(65); -l*sind(65); (hV - hB)].*ones(1,length(d_PL));
P3 = [(l.*d_PL)./(r_PL.*sind(65+asind(d_PL./r_PL))); zeros(1,length(d_PL)); zeros(1,length(d_PL))];
P4 = [d_PL.*cosd(25); d_PL.*sind(25); zeros(1,length(d_PL))];

h = (hV-hB);

LOS_path = distance(P1,P2);

d2 =sqrt(distance(P2,P3).^2 - h.^2);

d1 = sqrt(distance(P1,P3).^2 - h.^2);

neu = -h.*sqrt((2/lamda).*((1./d1)+(1./d2)));

fun_real = @(s)cos(pi.*(s.^2)./2);
fun_imag = @(s)sin(pi.*(s.^2)./2);

real_loss = zeros(size(neu));
imag_loss = zeros(size(neu));

for i = 1:length(neu)
   real_loss(i) = integral(fun_real,0,neu(i)) ;
   imag_loss(i) = integral(fun_imag,0,neu(i)) ;
end

diff_loss = -20*log10(sqrt((1 - real_loss - imag_loss).^2 +  (real_loss - imag_loss).^2 )./2);

RSS_calc = RSS_ref_up - 10*n_high*log10(LOS_path./d_ref);
hB = ones(size(d_PL)).*1.45; %Barrier antenna height
hV = ones(size(d_PL)).*1.45; %Vehicle antenna height

X = [log10(d_PL(:)) (delta_PL(:)) log10(hB(:)) log10(hV(:)) ];

K = predict(mdl_angle,X) ;
C = predict(mdl_vehicle,X) ;

XX = [K C log10(hB(:)) log10(hV(:)) ];
Correction = predict(mdl_total,XX) ;

RSS_corrected = RSS_calc' - diff_loss' + Correction;
idx = find(r_PL < d_0);
RSS_corrected(idx) = NaN;
[r_PL_2D,delta_PL_2D,RSS_corrected_2D] = structure_matrix(r_PL(:),delta_PL(:),RSS_corrected(:));

maxRSS = floor(max(RSS_corrected)/5)*5;
minRSS = ceil(min(RSS_corrected)/5)*5;

xWidth = 1;
yWidth = 1;
font_size = 30;
figure('units','normalized','outerposition',[0 0 xWidth yWidth]);
set(gcf,'Colormap',jet);
surf(real(r_PL_2D),real(delta_PL_2D).*(180/pi),real(RSS_corrected_2D))
hold on
view(2) 
set(gca,'XScale','log','XMinorTick','on','YMinorTick','on', 'XTick',[1 10 50 100 150 200 250 300 350 400 1000],'XTickLabel',{'1' '10' '' '100' '' '' '' '' '' '' '1000'})
set(gca, 'FontSize', font_size, 'FontWeight', 'Bold');
colorbar
xlabel('Distance (m)', 'FontSize', font_size);
ylabel('Angle(^{\circ})', 'FontSize', font_size);
grid on
box on

slit = 0.1;
for currentRSS = minRSS:5:maxRSS
    idx = find(RSS_corrected_2D > currentRSS - slit/2 & RSS_corrected_2D < currentRSS + slit/2);
    r_c = r_PL_2D(idx);
    delta_c = delta_PL_2D(idx);
    plot(r_c, delta_c.*(180/pi),  'Linewidth',3, 'Color', 'w')
    mid = ceil(length(r_c)/2);
    str = sprintf('\t %ddBm',currentRSS);
    text(r_c(mid),delta_c(mid).*(180/pi),str,'FontWeight', 'Bold', 'Color','k', 'FontSize', font_size)
end

print('Results/34agt2_145_3D_RSS_Contour','-depsc');
print('Results/34agt2_145_3D_RSS_Contour','-dpng');
savefig(strcat('Results/34agt2_145_3D_RSS_Contour','.fig'));