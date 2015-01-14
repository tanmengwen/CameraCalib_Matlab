clc
clear

addpath TOOLBOX_calib

width = 600;
height = 800;



load worldpoint.txt;
X_1 = worldpoint';


% Loads the Image coordinates

load imgpoint.txt;
x_1 = imgpoint';


n_ima = 1;
nx = width;
ny = height;
no_image = 1;

% est_dist = [1;1;1;1;0];
% est_alpha = 1;


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