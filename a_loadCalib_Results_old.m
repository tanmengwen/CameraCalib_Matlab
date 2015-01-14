clc
clear

num = 22;

% vpa(KK(1:1),9)   %????



str=(['load Calib_Results_old',num2str(1) '.mat', ';']);
eval(str);

ff = [KK(1,1) KK(2,2)];
fcerror = fc_error';
FC = [ff fcerror];
    
ccc = [KK(1,3) KK(2,3)];
ccerror = cc_error';
FCC = [ccc ccerror];

PE = err_std';

for i = 1:num
    str=(['load Calib_Results_old',num2str(i) '.mat', ';']);
    eval(str)
    
    ff = [KK(1,1) KK(2,2)];
    fcerror = fc_error';
    Fc = [ff fcerror];
    FC = [FC;Fc];
    
    ccc = [KK(1,3) KK(2,3)];
    ccerror = cc_error';
    fcc = [ccc ccerror];
    FCC = [FCC; fcc];
    
    PE=[PE;err_std'];
end


save fc.txt FC -ascii
save fcc.txt FCC -ascii
save picelError.txt PE -ascii




load fc.txt
load fcc.txt
load picelError.txt


l = length(fc);
plot(1:l, fc(:,1),'r*-')
hold on
plot (1:l, fc(:,2),'g*-')
xlabel('Num*10','FontSize',14);ylabel('fc/pixel','FontSize',14);
le = legend('fc_x','fc_y',1)
set(le,'FontSize',15)
title('Focus','FontSize',16)

figure
plot(1:l, fc(:,3),'r*-')
hold on
plot (1:l, fc(:,4),'g*-')
xlabel('Num*10');ylabel('fc error/pixel','FontSize',12);
le = legend('fc_x error','fc_y error',1)
set(le,'FontSize',15)
title('Focus Error','FontSize',16)


figure
plot(1:l, fcc(:,1),'r*-')
hold on
plot (1:l, fcc(:,2),'g*-')
xlabel('Num*10','FontSize',12);ylabel('cc/pixel','FontSize',12);
le = legend('cc_U','cc_V',1)
set(le,'FontSize',15)
title('Principal Point -- uv','FontSize',16)

figure
plot(1:l, fcc(:,3),'r*-')
hold on
plot (1:l, fcc(:,4),'g*-')
xlabel('Num*10','FontSize',12);ylabel('cc error/pixel','FontSize',12);
le = legend('cc_u error','cc_v error',1)
set(le,'FontSize',15)
title('Principal Point Error','FontSize',16)


figure
plot(1:l, picelError(:,1),'r*-')
hold on
plot (1:l, picelError(:,2),'g*-')
xlabel('Num*10','FontSize',12);ylabel('reprojection error/pixel','FontSize',12);
le = legend('reprojection x error','reprojection y error',1)
set(le,'FontSize',15)
title('Reprojection Error','FontSize',16)




