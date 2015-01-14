function [f,u,v] = test_compute_f_beta(x3d_h,x2d_h)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
A=[1,0,0;0,1,0;0,0,1];
Cw=define_control_points();

Xw=x3d_h(:,1:3);
U=x2d_h(:,1:2);

Alph=compute_alphas(Xw,Cw); 
M=compute_M_ver2(U,Alph,A); 

Km=kernel_noise(M,4);
X1=Km(:,end);
[f1,beta]=compute_f_beta(X1);

u=zeros(4,1);
v=zeros(4,1);
for i=1:4
    u(i)=X1(i*3-2)/X1(i*3);
    v(i)=X1(i*3-1)/X1(i*3);
end



% Km1=Km(:,end-1);
% Km2=Km(:,end);
% [f2,beta1,beta2]=compute_f_beta1_beta2(Km1,Km2);

% if abs(f1-8)<abs(f2-8)
%     f=f1;
% else
%     f=f2;
% end

f=f1;

end

