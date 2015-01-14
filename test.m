addpath gendata;
addpath TOOLBOX_calib

clc
clear


width = 1280;
height = 1024;
focus = 2009;
noise = 0;


genchessPointFunction(focus,width,height,noise)

load imagepoint.txt
load worldpoint.txt

plot(imagepoint(:,1),imagepoint(:,2),'-');

plot3(worldpoint(:,1),worldpoint(:,2),worldpoint(:,3),'*-');


% xini=-8; xend=4;%bounds 
% yini=-8; yend=4;
% 
% zini=4; zend=9;
% 
% %intrinsic camera parameters------------------
% fx=1000; %focal length in pixels
% fy=1000; 
% f=0.05; %50 mm of focal length
% 
% m=fx/f;
% m=1; f=1; %<<<<<<----------------------------
% 
% u0=1280/2; v0=1024/2;
% width=u0; height=v0;
% A=[fx/m 0 u0/m 0; 
%     0 fy/m v0/m 0; 
%     0 0 1       0];
% 
% n = 100;
% i=1;
% while i<=n
%     point(i).Xcam(1,1)=random(xini,xend,1);
%     point(i).Xcam(2,1)=random(yini,yend,1);
%     point(i).Xcam(3,1)=random(zini,zend,1);
%     
%     %project points into the image plane
%     point(i).Ximg_true=project_3d_2d(A,point(i).Xcam);
%     point(i).Ximg_true(3)=f;
%     
%     %coordinates in pixels
%     point(i).Ximg_pix_true=point(i).Ximg_true(1:2)*m;    
%     
%    %check if the point is into the limits of the image
%    uv=point(i).Ximg_pix_true;
%    if uv(1)>-width & uv(1)<width & uv(2)>-height & uv(2)<height
%        i=i+1;
%        fprintf('%.1f,%.1f,%d\n',uv(1),uv(2),i);
%    end
%    
% end