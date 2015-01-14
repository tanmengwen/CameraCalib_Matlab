clc
clear all; close all;

num = 100

[A,point,Rt,centroid]=generate_noisy_input_data2(140,2333,1280,1024,0,'donotplot');

save('data\datasim.mat','A','point','Rt','centroid');

XX = [];
xx = [];
for i = 1:num
    XX = [XX; point(i).Xworld'];
    xx = [xx; point(i).Ximg_pix_true'];
end


save imagepoint.txt xx -ascii
save worldpoint.txt XX -ascii
