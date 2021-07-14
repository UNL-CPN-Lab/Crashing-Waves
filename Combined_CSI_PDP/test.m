clc;
close all;

clear all;

format long g

load 34AGT2_87_csi.mat
load 34AGT2_87_frame_idx.mat
load 34AGT2_87_d.mat

csi_34AGT2_87(isnan(csi_34AGT2_87))=0;

dat_loc = [9:31,34:56];

x = csi_34AGT2_87(:,frame_idx_34AGT2_87(100):frame_idx_34AGT2_87(100)+24);

x = ifft(x);

t_samp = 1/(500e3);
t = (0:63).*t_samp;
t = t(dat_loc)';

for i = 1:size(x,2)
    P_x = 20*log10(abs(x(dat_loc,i))./(max(abs(x(dat_loc,i))))) -5;
    idx = find(P_x > -10);
    r(i) = rms_delay_spread(t(idx),abs(x(idx,i)).^2);
end

1./r