% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1989.264493343998083 ; 1990.236208464767742 ];

%-- Principal point:
cc = [ 678.852845344066850 ; 546.509211567576699 ];

%-- Skew coefficient:
alpha_c = -0.002156605396347;

%-- Distortion coefficients:
kc = [ 0.133330178708118 ; -0.894963618263895 ; -0.002115350245826 ; 0.004871475096177 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 31.759366650778222 ; 31.816646769561316 ];

%-- Principal point uncertainty:
cc_error = [ 57.131522139359070 ; 58.365360894531477 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.013403869933893;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.128744156678519 ; 0.390434192645322 ; 0.015401275623559 ; 0.016102285387134 ; 0.000000000000000 ];

%-- Image size:
nx = 1280;
ny = 1024;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 1;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 1;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -2.311849e-01 ; -2.944376e-02 ; -1.639306e-01 ];
Tc_1  = [ -1.146292e+02 ; -1.110298e+02 ; 6.384426e+02 ];
omc_error_1 = [ 3.120555e-02 ; 2.649780e-02 ; 8.872231e-03 ];
Tc_error_1  = [ 1.882693e+01 ; 1.881038e+01 ; 7.814721e+00 ];

