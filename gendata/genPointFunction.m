function genPointFunction(n,fc,w,h,noise)

num = n

[A,point,Rt,centroid]=generate_noisy_input_data(num,fc,w,h,noise,'donotplot');
% [A,point,Rt,centroid]=generate_noisy_input_data2(140,fc,w,h,noise,'donotplot');

% save('data\datasim.mat','A','point','Rt','centroid');

XX = [];
xx = [];
for i = 1:num
    XX = [XX; point(i).Xworld'];
    xx = [xx; point(i).Ximg_pix_true'];
end


save imagepoint.txt xx -ascii
save worldpoint.txt XX -ascii
