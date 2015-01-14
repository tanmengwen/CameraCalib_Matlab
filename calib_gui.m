%open camera calibration TOOLBOX
addpath TOOLBOX_calib


cell_list = {};

fig_number = 1;

title_figure = 'Camera Calibration Toolbox - Select mode of operation:';

cell_list{1,1} = {'Standard (all the images are stored in memory)','calib_gui_normal;'};
cell_list{2,1} = {'Memory efficient (the images are loaded one by one)','calib_gui_no_read;'};
cell_list{3,1} = {'Exit',['disp(''Bye. To run again, type calib_gui.''); close(' num2str(fig_number) ');']};


show_window(cell_list,fig_number,title_figure,290,18,0,'clean',12);