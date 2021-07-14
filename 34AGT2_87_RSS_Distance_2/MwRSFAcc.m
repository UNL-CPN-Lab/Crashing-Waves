clc; 
clear all;
close all;


filename = 'Filtered_Longitudinal_Acceleration_1.csv';
M1 = csvread(filename,3,0);

filename = 'Filtered_Longitudinal_Acceleration_2.csv';
M2 = csvread(filename,3,0);


t1 = M1(:,1);
t2 = M2(:,1);
a1 =  M1(:,2)*9.8;
a2 = M2(:,2)*9.8;

v1 = cumtrapz(t1,a1);
v2 = cumtrapz(t2,a2);

d1 = cumtrapz(t1,v1);
d2 = cumtrapz(t2,v2);

t = t2;
d = d2;
v = v2;
a = a2./98;

save MwRSF_Data_VNC.mat t v d a

plot(t2,d2)

load preamble_time_shifted.mat

preamble_time = preamble_time - 5;

start = min(find(preamble_time >= -20));

end_ = max(find(preamble_time <= 20));

p = preamble_time(start:end_);

index = zeros(length(preamble_time),1);

t = t2;

j = 1;

for i = 1:length(p)
    
    index(j) = min(find(t >= p(i)));
    j = j + 1;
    
end
index = index(1:j-1);
tt = t(index);
dd = d2(index);

ref = dd(min(find(tt >=0)));
ddd = ref-dd+20.42;

save MwRSF_Data.mat tt dd start end_ ddd
