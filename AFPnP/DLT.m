function [K,R,T,P] = DLT(x3d_h,x2d_h)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%构造矩阵
 
n=size(x3d_h,1);


nrows_M=2*n;
ncols_M=12;
M=zeros(nrows_M,ncols_M);

for i=1:n
    
    M_=[0,0,0,0,-x3d_h(i,1),-x3d_h(i,2),-x3d_h(i,3),-1,x2d_h(i,2)*x3d_h(i,1),x2d_h(i,2)*x3d_h(i,2),x2d_h(i,2)*x3d_h(i,3),x2d_h(i,2);
        x3d_h(i,1),x3d_h(i,2),x3d_h(i,3),1,0,0,0,0,-x2d_h(i,1)*x3d_h(i,1),-x2d_h(i,1)*x3d_h(i,2),-x2d_h(i,1)*x3d_h(i,3),-x2d_h(i,1)];
    
    %put M_ in the whole matrix
    row_ini=i*2-1;
    row_end=i*2;
        
    M(row_ini:row_end,:)=M_;
end
%End of 构造矩阵
[U,S,V]=svd(M);

P_=V(:,end);

lisj=sqrt(sum(P_.^2));

for i=1:3
    P(i,:)=P_(4*i-3:4*i);
end

if P(3,4)<0
    P=-P;
end
temp=P(3,1:3);
lamda=sqrt(sum(temp.^2));

%=======摄像机矩阵分解================
K=zeros(3,3);
R=zeros(3,3);

R(3,1)=P(3,1)/lamda;
R(3,2)=P(3,2)/lamda;
R(3,3)=P(3,3)/lamda;

K(1,3)=(P(1,1)*R(3,1)+P(1,2)*R(3,2)+P(1,3)*R(3,3))/lamda;
K(2,3)=(P(2,1)*R(3,1)+P(2,2)*R(3,2)+P(2,3)*R(3,3))/lamda;
K(2,2)=sqrt(P(2,1)*(P(2,1)-lamda*K(2,3)*R(3,1))+P(2,2)*(P(2,2)-lamda*K(2,3)*R(3,2))+P(2,3)*(P(2,3)-lamda*K(2,3)*R(3,3)))/lamda;

R(2,1)=(P(2,1)-lamda*K(2,3)*R(3,1))/(lamda*K(2,2));
R(2,2)=(P(2,2)-lamda*K(2,3)*R(3,2))/(lamda*K(2,2));
R(2,3)=(P(2,3)-lamda*K(2,3)*R(3,3))/(lamda*K(2,2));

K(1,2)=(P(1,1)*R(2,1)+P(1,2)*R(2,2)+P(1,3)*R(2,3))/lamda;

R(1,1)=R(2,2)*R(3,3)-R(2,3)*R(3,2);
R(1,2)=-R(2,1)*R(3,3)+R(2,3)*R(3,1);
R(1,3)=R(2,1)*R(3,2)-R(2,2)*R(3,1);

K(1,1)=(P(1,1)*R(1,1)+P(1,2)*R(1,2)+P(1,3)*R(1,3))/lamda;

K(3,3)=1;

if K(1,1)<0
    R(1,1)=-R(2,2)*R(3,3)+R(2,3)*R(3,2);
    R(1,2)=R(2,1)*R(3,3)-R(2,3)*R(3,1);
    R(1,3)=-R(2,1)*R(3,2)+R(2,2)*R(3,1);
    K(1,1)=(P(1,1)*R(1,1)+P(1,2)*R(1,2)+P(1,3)*R(1,3))/lamda;
end

test=det(R);


T=inv(K)*P(:,4)/lamda;
%=======End of 摄像机矩阵分解================

%=======摄像机矩阵分解================
% K=zeros(3,3);
% R=zeros(3,3);
% temp=P(:,1:3);
% lisj=det(temp);
% K(1,1)=sqrt(det(temp)/lamda);
% K(2,2)=K(1,1);
% K(3,3)=1;
% 
% R=lamda*inv(P(:,1:3))*K;

%=======End of 摄像机矩阵分解================

end

