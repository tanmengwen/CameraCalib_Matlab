%?????????


% clear
% 
% x = [0:50:(50*9)];
% x = x';
% 
% y= [1 1 1 1 1 1 1 1 1 1]';
% 
% X = [0 0];
% 
% for i = 0:13
%     xy=[x y*i*50];
%     X = [X
%          xy];
% end
% 
% X=X(2:end,:);
% 
% save Mode.txt X -ascii


clear

y = [0:40:(40*7)];
y = y';

x= [1 1 1 1 1 1 1 1]';

X = [0 0];

for i = 0:7
    xy=[ y x*i*40];
X = [X; xy];
end

X=X(2:end,:);

X = [X zeros(64,1)];

save Mode.txt X -ascii



