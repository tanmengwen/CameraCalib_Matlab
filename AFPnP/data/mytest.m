clear all; close all;

addpath data;

[A,point,Rt,centroid]=generate_noisy_input_data(100,0,'donotplot');

save('data\datasim.mat','A','point','Rt','centroid');