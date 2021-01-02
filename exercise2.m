%clear all 
clc
addpath(genpath('C:\Users\user\Desktop\DOE\rstools'))

X=twon(3);
X(9:16,:)=X;
Y=[705 620 700 629 672 668 715 647 680 651 685 635 654 691 672 673]';
clear options;
options.xnames = {'A','B', 'C'};
options.yname = {'Y'};
options.intera = 1;
options.code = 0; % code 1 to -1 and 2 to +1
out = rsreg(X,Y,options)
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

figure(1); clf
quadplot(out,'xfree', [1,3],'type','contour')
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

residuals(out)

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
normalplot(out)
% % res= resplot(out)
% [b,yfit,stp,res,s,R2,ypred,e,h,D]=regres(X,Y)
% ypred = regpred(X,b)
% figure
% plot(Y,ypred,'*r')
