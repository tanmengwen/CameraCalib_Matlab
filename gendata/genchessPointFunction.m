function genchessPointFunction(fc,w,h,noise)


[A,point,Rt,centroid]=generate_input_data(140,fc,w,h,noise,'donotplot');

% save('data\datasim.mat','A','point','Rt','centroid');

XX = [];
xx = [];
for i = 1:140
    XX = [XX; point(i).Xworld'];
    xx = [xx; point(i).Ximg_pix_true'];
end


save imagepoint.txt xx -ascii
save worldpoint.txt XX -ascii

