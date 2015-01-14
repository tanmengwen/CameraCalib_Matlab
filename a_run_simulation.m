%??????

clc
clear


addpath TOOLBOX_calib
addpath gendata
    
% a_simulation_calib_script(0.1);

% for j = 1:50
%     a_simulation_calib_script(0.5);
% end


for i=0.3:0.1:2.0

    for j = 1:20
        a_simulation_calib_script(i);
    end
    
end




% clc
% clear
% rmpath noise
% addpath noise/1.5
% 
% 
% 
% 
% num = 21;
% 
% FC= [];
% FCC = [] ;
% PE=[];
% ff1=[];
% uv1=[];
% 
% for i = 1:num
%     
%     if i~=6
%         
%         str=(['load Calib_Results_old',num2str(i) '.mat', ';']);
%         eval(str)
% 
%         ff = [KK(1,1) KK(2,2)];
%         ff1 = [ff1;ff];
%         fcerror = fc_error';
%         Fc = [ff fcerror];
%         FC = [FC;Fc];
% 
%         ccc = [KK(1,3) KK(2,3)];
%         uv1 = [uv1;ccc];
%         ccerror = cc_error';
%         fcc = [ccc ccerror];
%         FCC = [FCC; fcc];
% 
%         
%         PE=[PE;err_std'];
%     end
% end
% 
% fc_std = std(ff1);
% cc_std = std(uv1);
% re_std = std(PE);
% 
% s = [fc_std ;cc_std; re_std] 
% 
% save fc.txt FC -ascii
% save fcc.txt FCC -ascii
% save picelError.txt PE -ascii



% load fc.txt
% load fcc.txt
% load picelError.txt
% 
% h_fc = figure;
% l = length(fc);
% plot(1:l, fc(:,1),'r*-')
% hold on
% plot (1:l, fc(:,2),'g*-')
% xlabel('Num*10','FontSize',14);ylabel('fc/pixel','FontSize',14);
% le = legend('fc_x','fc_y',1);
% set(le,'FontSize',15);
% title('Focus','FontSize',16);
% saveas(h_fc,'fc','jpg');
% 
% figure;
% plot(1:l, fc(:,3),'r*-');
% hold on
% plot (1:l, fc(:,4),'g*-');
% xlabel('Num*10');ylabel('fc error/pixel','FontSize',12);
% le = legend('fc_x error','fc_y error',1);
% set(le,'FontSize',15);
% title('Focus Error','FontSize',16);
% 
% 
% h_uv=figure;
% plot(1:l, fcc(:,1),'r*-')
% hold on
% plot (1:l, fcc(:,2),'g*-')
% xlabel('Num*10','FontSize',12);ylabel('cc/pixel','FontSize',12);
% le = legend('cc_U','cc_V',1);
% set(le,'FontSize',15);
% title('Principal Point -- uv','FontSize',16);
% saveas(h_uv,'uv','jpg');
% 
% figure
% plot(1:l, fcc(:,3),'r*-')
% hold on
% plot (1:l, fcc(:,4),'g*-')
% xlabel('Num*10','FontSize',12);ylabel('cc error/pixel','FontSize',12);
% le = legend('cc_u error','cc_v error',1);
% set(le,'FontSize',15);
% title('Principal Point Error','FontSize',16);
% 
% 
% re=figure;
% plot(1:l, picelError(:,1),'r*-')
% hold on
% plot (1:l, picelError(:,2),'g*-')
% xlabel('Num*10','FontSize',12);ylabel('reprojection error/pixel','FontSize',12);
% le = legend('reprojection x error','reprojection y error',1);
% set(le,'FontSize',15);
% title('Reprojection Error','FontSize',16)
% saveas(re,'re','jpg');