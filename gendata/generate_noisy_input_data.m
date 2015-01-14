function [A,point,Rt,centroid]=generate_noisy_input_data(n,fc,ww,hh,std_noise,draw_plot)


if nargin<3 draw_plot=''; end

%true 3d position of the points--------------
% xini=-2; xend=2;%bounds
% yini=-2; yend=2;

xini=-2; xend=2;%bounds
yini=-2; yend=2;

zini=4; zend=9;

%intrinsic camera parameters------------------
fx=fc; %focal length in pixels
fy=fc;



m=1; f=1; %<<<<<<----------------------------

u0=ww/2; v0=hh/2;  %630  492
width=u0; height=v0;
A=[fx 0 u0 0;
   0 fy v0 0; 
   0 0 1 0]
std_noise=std_noise*(1/m);

%add lens distoration
kc = [.18351, -1.18218, -0.00206, 0.00730, 0.00000];
alpha_c = 0;

load worldp.txt
i=1;

while i<=n
%     point(i).Xcam(1,1)=random(xini,xend,1);
%     point(i).Xcam(2,1)=random(yini,yend,1);
%     point(i).Xcam(3,1)=random(zini,zend,1);
    
    point(i).Xcam(1,1)=worldp(i,1);
    point(i).Xcam(2,1)=worldp(i,2);
    point(i).Xcam(3,1)=worldp(i,3);

    %????
    xn = [point(i).Xcam(1,1)/point(i).Xcam(3,1)  point(i).Xcam(2,1)/point(i).Xcam(3,1)];
    
    rs= xn(1,1)^2+xn(1,2)^2;
    
    scale = 1 + kc(1) * rs + kc(2) * rs.^2 + kc(5) * rs.^3;
    
    dx = [2 *kc(3) * xn(:, 1) .* xn(:, 2) + kc(4) * (rs + 2 * xn(:, 1).^2), ...
                kc(3) * (rs + 2 * xn(:, 2).^2) + 2 * kc(4) * xn(:, 1) .* xn(:, 2)];
            
    xd = repmat(scale, 1, 2) .* xn + dx;
    imagePoints = [fx * (xd(:, 1) + alpha_c * xd(:, 2)) + u0, ...
                fy * xd(:, 2) + v0];
    
    
    %project points into the image plane
%     point(i).Ximg_true=project_3d_2d(A,point(i).Xcam);
    point(i).Ximg_true=imagePoints';
    point(i).Ximg_true(3)=f;
    
    %coordinates in pixels
    point(i).Ximg_pix_true=point(i).Ximg_true(1:2)*m;    
    
   %check if the point is into the limits of the image
   uv=point(i).Ximg_pix_true;
   if uv(1)>-width & uv(1)<width & uv(2)>-height & uv(2)<height
       i=i+1;
%        fprintf('%.1f,%.1f,%d\n',uv(1),uv(2),i);
%        fprintf('%.1f,%.1f,%.1f,%d\n',point(i-1).Xcam(1,1),point(i-1).Xcam(2,1),point(i-1).Xcam(3,1),i);
   end

    %CENTER
%     if uv(1)>width/2 & uv(1)<width*6/4 & uv(2)>height/2 & uv(2)<height*6/4
%            i=i+1;
%     %        fprintf('%.1f,%.1f,%d\n',uv(1),uv(2),i);
%     %        fprintf('%.1f,%.1f,%.1f,%d\n',point(i-1).Xcam(1,1),point(i-1).Xcam(2,1),point(i-1).Xcam(3,1),i);
%     end
end



% apoint = []
% for i=1:n
%     a = [point(i).Xcam(1,1),point(i).Xcam(2,1),point(i).Xcam(3,1)];
%     apoint= [apoint;a];
% end
% save worldp.txt apoint -ascii

% randn('seed',0);



% add noise
% for i=1:n
%     noise=randn(1,2)*std_noise;
%     point(i).Ximg(1,1)=point(i).Ximg_true(1)+noise(1);
%     point(i).Ximg(2,1)=point(i).Ximg_true(2)+noise(2);
%     point(i).Ximg(3,1)=f;
%     
%     %noisy coordinates in pixels
%     point(i).Ximg_pix=point(i).Ximg(1:2)*m;
% end


   
%the observed data will not be in the camera coordinate system. We put the center of the
%world system on the centroid of the data. We also assume that the data is rotated with
%respect to the camera coordenate system. 
centroid=[0 0 0]';
for i=1:n
    centroid=centroid+point(i).Xcam;    
end
centroid=centroid/n;



% x_rotation=random(0,45,1)*pi/180;
% y_rotation=random(0,45,1)*pi/180;
% z_rotation=random(0,45,1)*pi/180;
% tx=0.1; ty=0.1; tz=1;
% Rt=return_Rt_matrix(x_rotation,y_rotation,z_rotation,tx,ty,tz)

load rt.txt
Rt = rt;

for i=1:n
   noise=randn(1,3)*std_noise;
   point(i).Xworld=transform_3d(Rt,point(i).Xcam-centroid)*100+noise';
end



%plot noisy points in the image plane
if ~strcmp(draw_plot,'donotplot')
    figure; hold on;
    for i=1:n
        plot(point(i).Ximg_pix_true(1),point(i).Ximg_pix_true(2),'.','color',[1 0 0]);
        %txt=sprintf('%d',i);
        %text(point(i).Xcam(1),point(i).Xcam(2),point(i).Xcam(3),txt);
        plot(point(i).Ximg_pix(1),point(i).Ximg_pix(2),'o','color',[0 1 0],'markersize',5);
    end
    title('Noise in image plane','fontsize',20);
    grid on;
end