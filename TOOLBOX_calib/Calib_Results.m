% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2004.000278131966525 ; 2004.000167285692896 ];

%-- Principal point:
cc = [ 640.000555489942030 ; 512.000143561016216 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.000000049375724 ; 0.000004312791270 ; 0.000000045037685 ; 0.000000141431163 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 0.000156402447734 ; 0.000108368220587 ];

%-- Principal point uncertainty:
cc_error = [ 0.000455541120478 ; 0.000744958462416 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.000000883902360 ; 0.000002666632988 ; 0.000000116900721 ; 0.000000087150725 ; 0.000000000000000 ];

%-- Image size:
nx = 1280;
ny = 1024;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 1;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -5.449500e-01 ; -4.433147e-02 ; -2.727314e-01 ];
Tc_1  = [ -1.164113e+00 ; -1.076280e+00 ; 6.626106e+00 ];
omc_error_1 = [ 3.626254e-07 ; 2.091501e-07 ; 7.688806e-08 ];
Tc_error_1  = [ 1.514633e-06 ; 2.499211e-06 ; 4.519569e-07 ];

