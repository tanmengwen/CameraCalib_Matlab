function [u_t,v_t]=efficient_pnp_posit(x3d_h,x2d_h,f)

% EFFICIENT_PNP Main Function to solve the PnP problem 
%       as described in:
%
%       Francesc Moreno-Noguer, Vincent Lepetit, Pascal Fua.
%       Accurate Non-Iterative O(n) Solution to the PnP Problem. 
%       In Proceedings of ICCV, 2007. 
%
%       x3d_h: homogeneous coordinates of the points in world reference
%       x2d_h: homogeneous position of the points in the image plane
%       A: intrincic camera parameters
%       R: Rotation of the camera system wrt world reference
%       T: Translation of the camera system wrt world reference
%       Xc: Position of the points in the camera reference
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


Xw=x3d_h(:,1:3);
U=x2d_h(:,1:2);
A=[f,0,0;0,f,0;0,0,1];
 

%define control points in a world coordinate system (centered on the 3d
%points centroid)
Cw=define_control_points();

%compute alphas (linear combination of the control points to represent the 3d
%points)
Alph=compute_alphas(Xw,Cw);

%Compute M
M=compute_M_ver2(U,Alph,A);

%Compute kernel M
Km=kernel_noise(M,4); %in matlab we have directly the funcion km=null(M);
    


%1.-Solve assuming dim(ker(M))=1. X=[Km_end];------------------------------
X1=Km(:,end);
u_t=zeros(4,1);
v_t=zeros(4,1);
for i=1:4
    u_t(i)=f*X1(i*3-2)/X1(i*3);
    v_t(i)=f*X1(i*3-1)/X1(i*3);
end
