


clear all; close all;

addpath data;
addpath error;
addpath EPnP;
fprintf('\n---------DLT TEST--------------\n');
%1.-Generate simulated input data------------------------------------------


%     n=50; %number of points
%     std_noise=5; %noise in the measurements (in pixels)
%      fprintf('Number of point: %.3f\n',n);
%      fprintf('noise: %.3f\n',std_noise);
% 
%     
% 
%     
%     errofrdlt=0;
%     erroftdlt=0;
%     errofkdlt=0;
%     timofdlt=0;
%     errofrecon=0;
%     num=0;
%     
%     total=100;
% 
% 
% %2.-Inputs format--------------------------------
% for k=1:total
%     [A,point,Rt,centroid]=generate_noisy_input_data(n,std_noise,'donotplot');
% 
%     temp=Rt(1:3,1:3);
%     R_true=inv(temp);
%     T_true=temp*centroid;
%     P_true=A(:,1:3)*[R_true,T_true];
%     x3d=zeros(n,4);
%     x2d=zeros(n,3);
% 
%     A=A(:,1:3);
%     for i=1:n
%         x3d_h(i,:)=[point(i).Xworld',1]; 
%         x2d_h(i,:)=[point(i).Ximg(1:2)',1];
% 
%         %world and camera coordinates
%         X3d_world(i,:)=point(i).Xworld';
%         X3d_cam(i,:)=point(i).Xcam';
%     end
% 
% 
% %3.-EPnP----------------------------------------------------
% Xw=x3d_h(:,1:3);
% U=x2d_h(:,1:2);
% 
% tic;
% [K,R,T,P] = DLT(x3d_h,x2d_h);
% % K(1,2)=0;
% % K(1,3)=0;
% % K(2,3)=0;
% tim=toc;
% timofdlt=timofdlt+tim;
% 
% % [err,Urep] = reprojection_error_usingP(x3d_h,x2d_h,P);
% [err,Urep] = reprojection_error_usingRT(Xw,U,R,T,K);
% errofrecon=errofrecon+err;
% 
% 
% % e=R*R_true';
% % q0=0.5*sqrt(1+e(1,1)+e(2,2)+e(3,3));
% % errofRDLT=2*acos(q0);
% errofRDLT_=R-R_true;
% errofRDLT=sqrt(sum(sum(errofRDLT_.^2),2));
% errofrdlt=errofrdlt+errofRDLT;
% 
% % errofTDLT_=R'*T-R_true'*T_true;
% errofTDLT_=T-T_true;
% errofTDLT=sqrt(sum(errofTDLT_.^2));
% erroftdlt=erroftdlt+errofTDLT;
% 
% 
% errofKDLT_=K-[8,0,0;0,8,0;0,0,1];
% errofKDLT=sqrt(sum(sum(errofKDLT_.^2),2));
% errofkdlt=errofkdlt+errofKDLT;
% 
% end
% 
% fprintf('error reconstruction of DLT: %.3f\n',errofrecon/total);
% fprintf('error R of DLT: %.5f\n',errofrdlt/total);
% fprintf('error T of DLT: %.5f\n',erroftdlt/total);
% fprintf('error K of DLT: %.5f\n',errofkdlt/total);
% fprintf('Runtime of DLT: %.5f\n',timofdlt/total);

k=1;

for i=7:-1:0
    for j=0:8
        Xw(k,1:3)=[0,j,i];
        k=k+1;
    end
end

for i=1:7
    for j=0:8
        Xw(k,1:3)=[i,j,0];
        k=k+1;
    end
end    
  
load('tu1.mat','x','y');

U=[x,y];
U=U./1000;

%==========DLT===================
[K,R,T,P] = DLT(Xw,U);
K
R
T
P
[err,Urep] = reprojection_error_usingRT(Xw,U,R,T,K);
err

%==========END OF DLT===================


%===========UnEPnP=======================












%=========END OF UnEPnP=================



