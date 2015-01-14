clear;
clc;

load Mode.txt;
n_ima = 1;
quick_init = 1;

Np = length(Mode);
X_11 = [Mode'; zeros(1,Np)];

Num = 10;
X_1 = X_11;
for i= 1:(Num-1)
   X_1 = [X_1 X_11];
end

load corners.txt;
x_11 = corners';
x_1 = x_11(:,1:(140*Num));

% Loads the images:

% calib_name = 'Image_';
% format_image = 'jpg';
% 
% ima_read_calib;

% No calibration image is available (only the corner coordinates)
nx = 1280;
ny = 1024;
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