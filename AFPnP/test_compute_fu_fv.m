function [fu,fv] = test_compute_fu_fv(x3d_h,x2d_h)

A=[1,0,0;0,1,0;0,0,1];

Cw=define_control_points();

Xw=x3d_h(:,1:3);
U=x2d_h(:,1:2);

Alph=compute_alphas(Xw,Cw); 
M=compute_M_ver2(U,Alph,A); 
tic;
Km=kernel_noise(M,4);
X1=Km(:,end);

u=zeros(4,1);
v=zeros(4,1);
for i=1:4
    u(i)=X1(i*3-2)/X1(i*3);
    v(i)=X1(i*3-1)/X1(i*3);
end

