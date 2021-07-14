clc
clear all
close all

load PL_d_AGTB2_180.mat  
load PL_d_NJPCB7_180.mat 
load PL_d_34AGT2_145.mat 
load PL_d_AGTB2_Omni.mat  
load PL_d_NJPCB7_Omni.mat 
load PL_d_34AGT2_87.mat   
load PL_d_KIA.mat         
load PL_d_WIDT1_188.mat

PL_up = [PL_34AGT2_145; PL_AGTB2_180; PL_NJPCB7_180; PL_WIDT1_188];

%nanmean(PL_up)

PL_down = [PL_34AGT2_87; PL_AGTB2_Omni; PL_NJPCB7_Omni; PL_KIA];

%nanmean(PL_down)

PL_up = {PL_34AGT2_145; PL_AGTB2_180; PL_NJPCB7_180; PL_WIDT1_188};

PL_down = {PL_34AGT2_87; PL_AGTB2_Omni; PL_NJPCB7_Omni; PL_KIA};

d_up = {d_34AGT2_145; d_AGTB2_180; d_NJPCB7_180; d_WIDT1_188};

d_down = {d_34AGT2_87; d_AGTB2_Omni; d_NJPCB7_Omni; d_KIA};

out = [];
for i = 1:length(PL_up)
    idx = find(d_up{i} >50);
    out = [out; PL_up{i}(idx)];
end

nanmean(out)

out = [];
for i = 1:length(PL_down)
    idx = find(d_down{i} >50);
    out = [out; PL_down{i}(idx)];
end

nanmean(out)

out = [];
for i = 1:length(PL_up)
    idx = find(d_up{i} >0 & d_up{i}<=50);
    out = [out; PL_up{i}(idx)];
end

nanmean(out)

out = [];
for i = 1:length(PL_down)
    idx = find(d_down{i} >0 & d_down{i}<=50);
    out = [out; PL_down{i}(idx)];
end

nanmean(out)

