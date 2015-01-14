function a_random300_calib_script(totalNum)



load Mode.txt;
Np = length(Mode);
X_1 = [Mode zeros(1,Np)']';

Num = totalNum;
skipnum = 0;
for i=2:Num
    str=(['X_',num2str(i) '= X_1', ';']);
    eval(str)
end


% Loads the Image coordinates

load corners.txt;
% y = randi(1,300,[1 596]);
y = randi(595,1,300);
for i=1:Num
    a = corners((140*(y(1,i)-1)+1):140*y(1,i),:)';
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