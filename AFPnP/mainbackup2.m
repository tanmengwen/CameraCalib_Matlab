% MAIN Illustrates how to use the EPnP algorithm described in:
%
%       Francesc Moreno-Noguer, Vincent Lepetit, Pascal Fua.
%       Accurate Non-Iterative O(n) Solution to the PnP Problem. 
%       In Proceedings of ICCV, 2007. 
%
% Copyright (C) <2007>  <Francesc Moreno-Noguer, Vincent Lepetit, Pascal Fua>
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the version 3 of the GNU General Public License
% as published by the Free Software Foundation.
% 
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
% General Public License for more details.       
% You should have received a copy of the GNU General Public License
% along with this program. If not, see <http://www.gnu.org/licenses/>.
%
% Francesc Moreno-Noguer, CVLab-EPFL, September 2007.
% fmorenoguer@gmail.com, http://cvlab.epfl.ch/~fmoreno/ 

clear all; close all;

addpath data;
addpath error;
addpath EPnP;


fprintf('\n---------EPnP--------------\n');
%1.-Generate simulated input data------------------------------------------
load_points=0;
if ~load_points
    n=50; %number of points
    std_noise=5; %noise in the measurements (in pixels)
    [A,point,Rt,centroid]=generate_noisy_input_data(n,std_noise,'donotplot');
    save('data\input_data_noise.mat','A','point','Rt','centroid');
    
else
    load('data\input_data_noise.mat','A','point','Rt','centroid');
%     draw_noisy_input_data(point);
end


temp=Rt(1:3,1:3);
R_true=inv(temp);
T_true=centroid;
P_true=A(:,1:3)*[R_true,T_true];

%2.-Inputs format--------------------------------
n=size(point,2);
fprintf('Number of points: %.1f\n',n);
x3d=zeros(n,4);
x2d=zeros(n,3); 
A=A(:,1:3);

for i=1:n
    x3d_h(i,:)=[point(i).Xworld',1]; 
    x2d_h(i,:)=[point(i).Ximg(1:2)',1];
    x2d_h_true(i,:)=[point(i).Ximg_true(1:2)',1];
    %world and camera coordinates
    X3d_world(i,:)=point(i).Xworld';
    X3d_cam(i,:)=point(i).Xcam';
end


%3.-EPnP----------------------------------------------------
Xw=x3d_h(:,1:3);
U=x2d_h(:,1:2);
U_true=x2d_h_true(:,1:2);

[K,R,T,P] = DLT(x3d_h,x2d_h);
[err,Urep] = reprojection_error_usingRT(Xw,U,R,T,K);
fprintf('error of DLT: %.3f\n',err);

% e=R*R_true';
% q0=0.5*sqrt(1+e(1,1)+e(2,2)+e(3,3));
% errofRDLT=2*acos(q0);
errofRDLT_=R-R_true;
errofRDLT=sqrt(sum(sum(errofRDLT_.^2),2));
fprintf('Error of R of DLT: %.5f\n',errofRDLT);

% errofTDLT_=R'*T-R_true'*T_true;
errofTDLT_=T-T_true;
errofTDLT=sqrt(sum(errofTDLT_.^2));
fprintf('Error of T of DLT: %.5f\n',errofTDLT);

errofKDLT_=K-[800,0,0;0,800,0;0,0,1];
errofKDLT=sqrt(sum(sum(errofKDLT_.^2),2));
fprintf('Error of K of DLT: %.5f\n',errofKDLT);


[Rp,Tp,Xc,sol]=efficient_pnp(x3d_h,x2d_h,A);


%compute error
error=reprojection_error_usingRT(Xw,U,Rp,Tp,A);
fprintf('error EPnP: %.3f\n',error);



%========Error of Epnp R,T==============
errofREpnp_=Rp-R_true;
errofREpnp=sqrt(sum(sum(errofREpnp_.^2),2));
fprintf('Error of R of Epnp: %.5f\n',errofREpnp);

% errofTDLT_=R'*T-R_true'*T_true;
errofTEpnp_=Tp-T_true;
errofTEpnp=sqrt(sum(errofTEpnp_.^2));
fprintf('Error of T of Epnp: %.5f\n',errofTEpnp);
%========End of Error of Epnp R,T==============


%===========UnEpnp=============================

%1. Compute f
[f,u,v]=test_compute_f_beta(x3d_h,x2d_h);
A=[f,0,0;0,f,0;0,0,1];
A0=[800,0,0;0,800,0;0,0,1];
[Ru,Tu,Xcu,solu]=efficient_pnp(x3d_h,x2d_h,A);
[errofunepnp,Urep] = reprojection_error_usingRT(Xw,U,Ru,Tu,A);

errofRUnEpnp_=Ru-R_true;
errofRUnEpnp=sqrt(sum(sum(errofRUnEpnp_.^2),2));
fprintf('Error of R of UnEpnp: %.5f\n',errofRUnEpnp);

% errofTDLT_=R'*T-R_true'*T_true;
errofTUnEpnp_=Tu-T_true;
errofTUnEpnp=sqrt(sum(errofTUnEpnp_.^2));
fprintf('Error of T of UnEpnp: %.5f\n',errofTUnEpnp);

errofKUnEpnp_=A-[800,0,0;0,800,0;0,0,1];
errofKUnEpnp=sqrt(sum(sum(errofKUnEpnp_.^2),2));
fprintf('Error of K of UnEpnp: %.5f\n',errofKUnEpnp);

fprintf('error UnEPnP: %.5f\n',errofunepnp);


Pe=zeros(3,4);
for i=1:2
    for j=1:4
        Pe(i,j)=P(i,j)/f;
    end
end
for j=1:4
    Pe(3,j)=P(3,j);
end
R_=sign(det(Pe(:,1:3)))*(det(Pe(:,1:3))^(-1/3))*Pe(:,1:3);
T_=sign(det(Pe(:,1:3)))*(det(Pe(:,1:3))^(-1/3))*Pe(:,4);
[Ur,Sr,Vr]=svd(R_);
R_test=Ur*Vr';
T_test=T_;

errofRUnEpnpTest_=R_test-R_true;
errofRUnEpnpTest=sqrt(sum(sum(errofRUnEpnpTest_.^2),2));
fprintf('Error of R of UnEpnpTest: %.5f\n',errofRUnEpnpTest);

% errofTDLT_=R'*T-R_true'*T_true;
errofTUnEpnpTest_=T_test-T_true;
errofTUnEpnpTest=sqrt(sum(errofTUnEpnpTest_.^2));
fprintf('Error of T of UnEpnpTest: %.5f\n',errofTUnEpnpTest);

error_of_unepnp_test=reprojection_error_usingRT(Xw,U,R_test,T_test,A);
fprintf('error UnEPnP_test: %.3f\n',error_of_unepnp_test);


%===========End of UnEpnp=======================

[error_dlt_true,Urep_dlt_true] = reprojection_error_usingRT(Xw,U_true,R,T,K);
[error_epnp_true,Urep_epnp_true]=reprojection_error_usingRT(Xw,U_true,Rp,Tp,A0);
[error_unepnp_true,Urep_unepnp_true]=reprojection_error_usingRT(Xw,U_true,Ru,Tu,A);

error_of_unepnp_test_true=reprojection_error_usingRT(Xw,U_true,R_test,T_test,A);

fprintf('reprojection error of DLT true: %.4f\n',error_dlt_true);
fprintf('reprojection error of EPnP true: %.4f\n',error_epnp_true);
fprintf('reprojection error of unEPnP true: %.4f\n',error_unepnp_true);
fprintf('reprojection error of EPnP_test true: %.4f\n',error_of_unepnp_test_true);



%3.-EPnP_GAUSS_NEWTON----------------------------------------------------
Xw=x3d_h(:,1:3);
U=x2d_h(:,1:2);

[Rg,Tg,Xcg,sol]=efficient_pnp_gauss(x3d_h,x2d_h,A0);

errofREpnpG_=Rg-R_true;
errofREpnpG=sqrt(sum(sum(errofREpnpG_.^2),2));
fprintf('Error of R of EpnpG: %.5f\n',errofREpnpG);

% errofTDLT_=R'*T-R_true'*T_true;
errofTEpnpG_=Tg-T_true;
errofTEpnpG=sqrt(sum(errofTEpnpG_.^2));
fprintf('Error of T of EpnpG: %.5f\n',errofTEpnpG);

% % %draw Results
% for i=1:n
%     point(i).Xcam_est=Xc(i,:)';
% end
% figure; h=gcf;
% plot_3d_reconstruction(point,'EPnP Gauss Newton',h);

%compute error
error=reprojection_error_usingRT(Xw,U,Rg,Tg,A);
fprintf('error EPnP_Gauss_Newton: %.3f\n',error);





