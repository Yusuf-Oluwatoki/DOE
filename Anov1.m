clear all
clc



Data = load('Kolarik_21_6.txt');
clear Kolarik_21_6
% extract the variables from the data matrix
PopDens = Data(:,1);
Salinity = Data(:,2);
Position = Data(:,3);
Weight = Data(:,4);
% calculate the groups averages
Data2 = grpstats(Data,{PopDens,Salinity,Position});
I{1} = find(Data2(:,1)==300 & Data2(:,2)==10);
I{2} = find(Data2(:,1)==600 & Data2(:,2)==10);
I{3} = find(Data2(:,1)==300 & Data2(:,2)==15);
I{4} = find(Data2(:,1)==600 & Data2(:,2)==15);
ltype = {'b-x','r-x','b-o','r-o'} % for plots
figure(1)
for i = 1:4
plot(Data2(I{i},3),Data2(I{i},4),ltype{i})
hold on
end
grid on
xlabel('Position');
ylabel('Weight')
legend('Population density 300 & Salinity 10',...
'Population density 600 & Salinity 10',...
'Population density 300 & Salinity 15',...
'Population density 600 & Salinity 15')
hold off
Terms = [
0 1 0
0 0 1
1 1 0
1 0 1
0 1 1
];

[p,tbl,stats] = anovan(Weight,{PopDens,Salinity,Position},...
'model',Terms,'varnames',{'PopDens','Salinity','Position'});

S = grpstats(Data,{PopDens,Salinity,Position},'var');
sum(S(:,4))/size(S,1) % mean variance of replicates = pure error variance

%R-squared
1-sum(stats.resid.^2)/sum((Weight-mean(Weight)).^2)

%Lack-of-fit
S = grpstats(Data,{PopDens,Salinity,Position},'var');
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