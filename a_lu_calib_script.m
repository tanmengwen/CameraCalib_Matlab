clc
clear
addpath TOOLBOX_calib 

load corInfo.mat


Np = length(Model);
X_1 = Model;

Num = 517;
skipnum = 0;
for i=2:Num
    str=(['X_',num2str(i) '= X_1', ';']);
    eval(str)
end
    


for i=1:Num
    a = corInfo{i}.corners(:,:)';
    str=(['x_',num2str(i) '= a', ';']);
    eval(str)
end



% Loads the images:

% calib_name = 'Image_000';
% format_image = 'jpg';
% 
% ima_read_calib;

n_ima = Num;
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

%reproject_calib;

% Saves the results into a file called Calib_Results.mat:

saving_calib;

% Set the toolbox to normal mode of operation again:

dont_ask =  0;