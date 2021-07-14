clc;
close all;

% clear all;
% 
% load 34AGT2_87_csi.mat
% load 34AGT2_145_csi.mat
% load AGTB2_180_csi.mat
% load AGTB2_Omni_csi.mat
% load KIA_csi.mat
% load NJPCB_180_csi.mat
% load NJPCB_Omni_csi.mat
% load WIDT1_188_csi.mat

% load 34AGT2_87_frame_idx.mat
% load 34AGT2_145_frame_idx.mat
% load AGTB2_180_frame_idx.mat
% load AGTB2_Omni_frame_idx.mat
% load KIA_frame_idx.mat
% load NJPCB_180_frame_idx.mat
% load NJPCB_Omni_frame_idx.mat
% load WIDT1_188_frame_idx.mat

csi_34AGT2_87(isnan(csi_34AGT2_87))=0;
csi_34AGT2_145(isnan(csi_34AGT2_145))=0;
csi_AGTB2_180(isnan(csi_AGTB2_180))=0;
csi_AGTB2_Omni(isnan(csi_AGTB2_Omni))=0;
csi_KIA(isnan(csi_KIA))=0;
csi_NJPCB_180(isnan(csi_NJPCB_180))=0;
csi_NJPCB_Omni(isnan(csi_NJPCB_Omni))=0;
csi_WIDT1_188(isnan(csi_WIDT1_188))=0;

len_idx = 9;

final_idx1 = [];
final_idx2 = [];
final_idx3 = [];
final_idx4 = [];



for i = 1:len_idx
    idx1 = idx_cell_34AGT2_87{i};
    idx2 = idx_cell_AGTB2_Omni{i};
    idx3 = idx_cell_NJPCB_Omni{i};
    idx4 = idx_cell_KIA{i};   
    m = min([length(idx1) length(idx2) length(idx3) length(idx4)]);
    idx1 = idx1(1:m);
    idx2 = idx2(1:m);
    idx3 = idx3(1:m);
    idx4 = idx4(1:m);
    C = repmat(0:24',m,1)';
    cdx1 = repmat(frame_idx_34AGT2_87(idx1),25,1) + C;
    cdx2 = repmat(frame_idx_AGTB2_Omni(idx2),25,1) + C;
    cdx3 = repmat(frame_idx_NJPCB_Omni(idx3),25,1) + C;
    cdx4 = repmat(frame_idx_KIA(idx4),25,1) + C;
    
    final_idx1 = [final_idx1 cdx1];
    final_idx2 = [final_idx2 cdx2];
    final_idx3 = [final_idx3 cdx3];
    final_idx4 = [final_idx4 cdx4];

end

csi1 = csi_34AGT2_87(:,final_idx1(:));
csi2 = csi_AGTB2_Omni(:,final_idx2(:));
csi3 = csi_NJPCB_Omni(:,final_idx3(:));
csi4 = csi_KIA(:,final_idx4(:));

e = linspace(-pi,pi,64);

maximum = 0;
index = 0;

for i = 1:length(e)
    csi3 = correct_phase(csi3,e(i));
    sim = similarity(csi2,csi3);
    if sim > maximum
        maximum = sim;
        index = i;
    end
end



