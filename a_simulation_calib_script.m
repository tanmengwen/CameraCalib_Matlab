% ?? ?????????????????????

function a_simulation_calib_script(n)

% clc
% clear

width = 1280;
height = 1024;
focus = 2010;
noise = n;
numPoint = 1000;

genPointFunction(numPoint,focus,width,height,noise)


load worldpoint.txt;
X_1 = worldpoint';


% Loads the Image coordinates

load imagepoint.txt;
x_1 = imagepoint';


% Loads the images:

% calib_name = 'Image_000';
% format_image = 'jpg';
% 
% ima_read_calib;

n_ima = 1;
nx = width;
ny = height;
no_image = 1;

est_dist = [1;1;1;1;0];
est_alpha = 1;


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