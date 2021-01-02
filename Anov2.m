clear all
clc

Data = load('candies.txt');
clear candies
% extract the variables from the data matrix
Temp = Data(:,1);
SStrength = Data(:,2);
Container = Data(:,3);
SLife = Data(:,4);
% calculate the groups averages
Data2 = grpstats(Data,{Temp,SStrength,Container});
I{1} = find(Data2(:,1)==5 & Data2(:,3)==8);
I{2} = find(Data2(:,1)==-5 & Data2(:,3)==8);
I{3} = find(Data2(:,1)==5 & Data2(:,3)==16);
I{4} = find(Data2(:,1)==-5 & Data2(:,3)==16);
I{5} = find(Data2(:,1)==5 & Data2(:,3)==32);
I{6} = find(Data2(:,1)==-5 & Data2(:,3)==32);
ltype = {'b-x','r-x','b-o','r-o','b-+','r-+'} % for plots
figure(1)
for i = 1:6
plot(Data2(I{i},2),Data2(I{i},4),ltype{i})
hold on
end
grid on
xlabel('SStrength','interpreter', 'latex');
ylabel('SLife','interpreter', 'latex')
legend('Temp 5 \& Container 8 oz',...
'Temp -5 \& Container 8 oz',...
'Temp 5 \& Container 16 oz',...
'Temp -5 \& Container 16 oz',...
'Temp 5 \& Container 32 oz',...
'Temp -5 \& Container 32 oz','interpreter', 'latex')
title('Variable dependence','interpreter', 'latex')
axis tight
grid on
x0=10;
y0=10;
width=750;
height=400;
set(gcf,'position',[x0,y0,width,height])
ax=gca;
ax.FontSize = 12;
hold off


% figure
% boxplot(Data2(:,1:3),'Notch','on','Labels',{'Temp','SStrength', 'Container'})
% title('Compare Random Data from Different Distributions')
%%
Terms = [
1 0 0
0 1 0
% 1 1 0
% 1 0 1
% 0 1 1
];

[p,tbl,stats] = anovan(SLife,{Temp,SStrength,Container},...
'model',Terms,'varnames',{'Temp','SStrength','Container'});

S = grpstats(Data,{Temp,SStrength,Container},'var');
sum(S(:,4))/size(S,1) % mean variance of replicates = pure error variance

%R-squared
1-sum(stats.resid.^2)/sum((SLife-mean(SLife)).^2)
%%
%Lack-of-fit
S = grpstats(Data,{Temp,SStrength,Container},'var');
SSE = sum(S(:,4)); % pure error SS
dfE = size(S,1); % pure error df
MSE = SSE/dfE; % pure error MS
SSR = stats.mse*stats.dfe; % redidual SS
dfR = stats.dfe; % residual df
SSlof = SSR-SSE; % lack-of-fit SS
dflof = dfR-dfE; % lack-of-fit df
MSlof = SSlof/dflof; % lack-of-fit MS
Flof = MSlof/MSE, % F-statistic (variance ratio)
plof = 1-fcdf(Flof,dflof,dfE) % p-value