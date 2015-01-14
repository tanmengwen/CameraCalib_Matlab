function [f,beta] = compute_f_beta(X1)
%以下为测试代码函数头
%function [f,beta] = compute_f_beta(X1,Alph,Xw)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Cc_=zeros(4,3);
for i=1:4
    Cc_(i,:)=X1(3*i-2:3*i);
end

dsq=define_distances_btw_control_points();

dv(1,1)=(Cc_(1,1)-Cc_(2,1))^2 + (Cc_(1,2)-Cc_(2,2))^2;
dv(1,2)=(Cc_(1,3)-Cc_(2,3))^2;
dv(2,1)=(Cc_(1,1)-Cc_(3,1))^2 + (Cc_(1,2)-Cc_(3,2))^2;
dv(2,2)=(Cc_(1,3)-Cc_(3,3))^2;
dv(3,1)=(Cc_(1,1)-Cc_(4,1))^2 + (Cc_(1,2)-Cc_(4,2))^2;
dv(3,2)=(Cc_(1,3)-Cc_(4,3))^2;
dv(4,1)=(Cc_(2,1)-Cc_(3,1))^2 + (Cc_(2,2)-Cc_(3,2))^2;
dv(4,2)=(Cc_(2,3)-Cc_(3,3))^2;
dv(5,1)=(Cc_(2,1)-Cc_(4,1))^2 + (Cc_(2,2)-Cc_(4,2))^2 ;
dv(5,2)=(Cc_(2,3)-Cc_(4,3))^2;
dv(6,1)=(Cc_(3,1)-Cc_(4,1))^2 + (Cc_(3,2)-Cc_(4,2))^2;
dv(6,2)=(Cc_(3,3)-Cc_(4,3))^2;

r1=dv'*dv;
r2=dv'*dsq;
result=inv(dv'*dv)*(dv'*dsq);
f=result(2)/result(1);
f=sqrt(abs(f));
beta=result(2);
beta=sqrt(beta);

%===============测试代码=======================
% 
% Cc=Cc_*beta;
% 
% Xc=Alph*Cc;
% 
% n=size(Xc,1);
% 
% for i=1:n
%     U(2*i-1)=Xc(i,1)/(f*Xc(i,3));
%     U(2*i)=Xc(i,2)/(f*Xc(i,3));
%     V(2*i-1)=x2d_h(i,1);
%     V(2*i)=x2d_h(i,2);
% end
% U=U';
% V=V';
% 
% f=(U'*V)/(U'*U);
%==============End of 测试代码=================


%===============测试代码=======================

% Xc_=Alph*Cc_;
% 
% n=size(Xc_,1);
% 
% centr_w=mean(Xw);
% centroid_w=repmat(centr_w,[n,1]);
% tmp1=Xw-centroid_w;
% dw=sqrt(sum(tmp1.^2,2));
% 
% centr_c=mean(Xc_);
% centroid_c=repmat(centr_c,[n,1]);
% tmp2=Xc_-centroid_c;
% 
% for i=1:n
%     
%     dc(i,1)=tmp2(i,1)^2+tmp2(i,2)^2;
%     dc(i,2)=tmp2(i,3)^2;
% end
% 
% result2=inv(dc'*dc)*(dc'*dw);
% f2=result2(2)/result2(1);
% f2=sqrt(f2);
% beta2=result2(2);
% beta2=sqrt(beta2);



%==============End of 测试代码=================

end

