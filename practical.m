clear all 
close all
clc
addpath(genpath('C:\Users\user\Desktop\DOE\rstools'))
%% Experiment design matrix
X =twon(3);
X(9:16,:)=X;

Y=[80 78 68 64 90 86 80 75 78 76 70 68 92 84 76 78]';
clear options;
options.xnames = {'A','B', 'C'};
options.yname = {'Y'};
options.intera = 1;
options.code = 1; % code 1 to -1 and 2 to +1
out = rsreg(X,Y,options)

X(:,4)=Y;
% extract the variables from the data matrix
A = X(:,1);
B= X(:,2);
C = X(:,3);
Y2 = X(:,4);
%% calculate the groups averages and plot group dependencies
X2 = grpstats(X,{A,B,C});
I{1} = find(X2(:,1)==-1 & X2(:,2)==-1);
I{2} = find(X2(:,1)==1 & X2(:,2)==-1);
I{3} = find(X2(:,1)==-1 & X2(:,2)==1);
I{4} = find(X2(:,1)==1 & X2(:,2)==1);
ltype = {'b-x','r-x','b-o','r-o'} % for plots
figure(1)
for i = 1:4
plot(X2(I{i},3),X2(I{i},4),ltype{i})
hold on
end
grid on
xlabel('Heating', 'interpreter', 'latex');
ylabel('Percent Popped', 'interpreter', 'latex')
legend('Type of oil (Butter) \& Type of Pop corn (Micro-wave)',...
'Type of oil (oil) \& Type of Pop corn (Micro-wave)',...
'Type of oil (Butter) \& Type of Pop corn (Plain)',...
'Type of oil (oil) \& Type of Pop corn (Plain)', 'interpreter', 'latex')
title("Variable effect on percentage popped corn", 'interpreter', 'latex')
hold off
axis tight
grid on
x0=10;
y0=10;
width=750;
height=500;
set(gcf,'position',[x0,y0,width,height])
ax=gca;
ax.FontSize = 12;
%% Model for significant terms only

XX =twon(3);
XX(9:16,:)=XX;

YY=[80 78 68 64 90 86 80 75 78 76 70 62 88 84 76 76]';
clear options;
options.xnames = {'A','B', 'C'};
options.yname = {'YY'};
options.intera = 0;
options.code = 0; % code 1 to -1 and 2 to +1
out1 = rsreg(XX,YY,options)

%% Model for quadratic terms
[X3 namess] =intera(twon(3));
X3(9:16,:)=X3;
X3=X3(:,[1,2,3,4,7,9]);
Y3=[80 78 68 64 90 86 80 75 78 76 70 62 88 84 76 76]';
clear options;
options.xnames = {'A','B', 'C','AA','BB', 'CC'};
options.yname = {'YY'};
options.intera = 0;
options.code = 0; % code 1 to -1 and 2 to +1
out2 = rsreg(X3,Y3,options)
%% Residuals and model results in plots
res=residuals(out);
%figure
%plot(res,Y,'.')


y=predicted(out);

figure
plot(Y,y,'*b',[min(Y),max(Y)],[min(Y),max(Y)],'r')
ylabel('Measured values','interpreter', 'latex')
xlabel('Fitted values','interpreter', 'latex')
title('Goodness of fit','interpreter', 'latex')
axis tight
grid on
x0=10;
y0=10;
width=550;
height=300;
set(gcf,'position',[x0,y0,width,height])
ax=gca;
ax.FontSize = 12;

%% plot for goodness of fit

plot([1:16],Y,'*b')
hold on
plot([1:16],y,'r')
ylabel('Percent popped corn','interpreter', 'latex')
xlabel('Experiment order','interpreter', 'latex')
legend('Measurement', 'Prediction', 'Location','best','interpreter', 'latex')
title('Goodness of fit','interpreter', 'latex')
axis tight
grid on
x0=10;
y0=10;
width=550;
height=300;
set(gcf,'position',[x0,y0,width,height])
ax=gca;
ax.FontSize = 12;

%% plot for variable effect

figure; clf
quadplot(out,'xfree', [1,2],'type','contour')
title('Variable effect','interpreter', 'latex')
axis tight
grid on
x0=10;
y0=10;
width=550;
height=300;
set(gcf,'position',[x0,y0,width,height])
ax=gca;
ax.FontSize = 12;

figure; clf
quadplot(out,'xfree', [2,3],'type','contour')
title('Variable effect','interpreter', 'latex')
axis tight
grid on
x0=10;
y0=10;
width=550;
height=300;
set(gcf,'position',[x0,y0,width,height])
ax=gca;
ax.FontSize = 12;

cana(out)

residuals(out);

figure;
efectplot(out);
axis tight
grid on
x0=10;
y0=10;
width=550;
height=300;
set(gcf,'position',[x0,y0,width,height])
ax=gca;
ax.FontSize = 12;

parameters(out)

figure
qqplot(residuals(out))
% hold on
%normalplot(out)
% % res= resplot(out)
% [b,yfit,stp,res,s,R2,ypred,e,h,D]=regres(X,Y)
% ypred = regpred(X,b)
% figure
% plot(Y,ypred,'*r')


%%  significant model plots
yy=predicted(out1);
orders=[1,1,0];
%isnlarx(yy,orders);

res=residuals(out1);

[h,p] = kstest(res)

figure
cdfplot(res)
hold on
x_values = linspace(min(res),max(res));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best', 'interpreter','latex')
xlabel('x', 'interpreter','latex')
ylabel('F(x)', 'interpreter','latex')
title('Empirical CDF', 'interpreter','latex')
%plot(res,Y,'.')
%%
figure
histogram(res, 'Normalization', 'pdf')
xlabel('residuals', 'interpreter','latex')
ylabel('PDF', 'interpreter','latex')
title('Histogram of residuals', 'interpreter','latex')
%%
figure
plot(YY,y,'*b',[min(YY),max(YY)],[min(YY),max(YY)],'k')
ylabel('Measured values','interpreter', 'latex')
xlabel('Fitted values','interpreter', 'latex')
title('Goodness of fit','interpreter', 'latex')
axis tight
grid on
x0=10;
y0=10;
width=550;
height=300;
set(gcf,'position',[x0,y0,width,height])
ax=gca;
ax.FontSize = 12;

%%



figure
plot([1:16],Y,'*b')
hold on
plot([1:16],yy,'r')
ylabel('Percent popped corn','interpreter', 'latex')
xlabel('Experiment order','interpreter', 'latex')
legend('Measurement', 'Prediction', 'Location','best','interpreter', 'latex')
title('Goodness of fit','interpreter', 'latex')
axis tight
grid on
x0=10;
y0=10;
width=550;
height=300;
set(gcf,'position',[x0,y0,width,height])
ax=gca;
ax.FontSize = 12;
%saveas(gcf,'C:\Users\user\Downloads\ODE\ODE\pos11.eps')


figure; clf
quadplot(out1,'xfree', [1,3],'type','contour')
title('Variable effect','interpreter', 'latex')
axis tight
grid on
x0=10;
y0=10;
width=550;
height=300;
set(gcf,'position',[x0,y0,width,height])
ax=gca;
ax.FontSize = 12;
%saveas(gcf,'C:\Users\user\Downloads\ODE\ODE\pos8.eps')



figure; clf
quadplot(out1,'xfree', [2,3],'type','contour')
title('Variable effect','interpreter', 'latex')
axis tight
grid on
x0=10;
y0=10;
width=550;
height=300;
set(gcf,'position',[x0,y0,width,height])
ax=gca;
ax.FontSize = 12;
%saveas(gcf,'C:\Users\user\Downloads\ODE\ODE\pos9.eps')
%%
cana(out1)

residuals(out1);

figure;
efectplot(out1);
axis tight
grid on
x0=10;
y0=10;
width=550;
height=300;
set(gcf,'position',[x0,y0,width,height])
ax=gca;
ax.FontSize = 12;

parameters(out1)

figure
normalplot(out1)
% % res= resplot(out)
% [b,yfit,stp,res,s,R2,ypred,e,h,D]=regres(X,Y)
% ypred = regpred(X,b)
% figure
% plot(Y,ypred,'*r')