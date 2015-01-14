% function generate_noisy_input_data2(fc,ww,hh)
addpath gendata
addpath TOOLBOX_calib

%??????
y = [0:40:(40*9)];
y = y';
x= [1 1 1 1 1 1 1 1 1 1]';
X = [];
for i = 0:13
    xy=[x*i*40 y ];
X = [X; xy];
end
WorldPoint = [X zeros(140,1)];


%?? R T K
%intrinsic camera parameters
fx=2000; %focal length in pixels
fy=2000; 
f=0.05; %50 mm of focal length

m=fx/f;
m=1; f=1; 

u0=640; v0=480;
width=u0; height=v0;
K=[fx/m 0 u0/m 0; 
    0 fy/m v0/m 0; 
    0 0 1       0];


x_rotation=random(0,45,1)*pi/180;
y_rotation=random(0,45,1)*pi/180;
z_rotation=random(0,45,1)*pi/180;
tx=0; ty=0; tz=0;
RT=return_Rt_matrix(x_rotation,y_rotation,z_rotation,tx,ty,tz);



num=size(WorldPoint,1);
 
P=K*RT;
Xw_h=[WorldPoint,ones(num,1)];
Urep_=(P*Xw_h')';
 
 
%project reference points into the image plane
Urep=zeros(num,2);
Urep(:,1)=Urep_(:,1)./Urep_(:,3);
Urep(:,2)=Urep_(:,2)./Urep_(:,3);


save image140.txt Urep -ascii
save world140.txt WorldPoint -ascii

    
X_1 = WorldPoint';
x_1 = Urep';


n_ima = 1;
nx = width;
ny = height;
no_image = 1;


% Set the toolbox not to prompt the user (choose default values)

dont_ask = 1;

% Run the main calibration routine:

go_calib_optim;

% Shows the extrinsic parameters:

ext_calib;

% Reprojection on the original images:

reproject_calib;

% Saves the results into a file called Calib_Results.mat:

saving_calib;

% Set the toolbox to normal mode of operation again:

dont_ask =  0;
