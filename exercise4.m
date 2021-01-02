clear all 
clc
addpath(genpath('C:\Users\user\Desktop\DOE\rstools'))

%% Question a
X =twon(3);
Y=[4.44 6.39 4.48 4.44 8.37 8.92 7.89 7.83]';
clear options;
options.xnames = {'A','B', 'C'};
options.yname = {'Y'};
options.intera = 0;
options.code = 0; % code 1 to -1 and 2 to +1
out = rsreg(X,Y,options)

%% Question b

[XX,names] =intera(twon(3),[],[],-2);
YY=[4.44 6.39 4.48 4.44 8.37 8.92 7.89 7.83]';
clear options;
options.xnames = {'A','B', 'C', 'AB', 'AC', 'BC'};
options.yname = {'Y'};
options.intera = 0;
options.code = 0; % code 1 to -1 and 2 to +1
out = rsreg(XX,YY,options)
%% Question d
[X3 namess] =intera(twon(3,1));
X3=X3(:,[4,7,9]);
Y3=[4.44 6.39 4.48 4.44 8.37 8.92 7.89 7.83 7.53]';
clear options;
options.xnames = {'AA','BB', 'CC'};
options.yname = {'Y'};
options.intera = 0;
options.code = 0; % code 1 to -1 and 2 to +1
out = rsreg(X3,Y3,options)

%% Question e
[X4 namess] =intera(twon(3,1))
X4=X4(:,[1,2,3,9]);
Y4=[4.44 6.39 4.48 4.44 8.37 8.92 7.89 7.83 7.53]';
clear options;
options.xnames = {'A','B', 'C', 'CC'};
options.yname = {'Y'};
options.intera = 0;
options.code = 0; % code 1 to -1 and 2 to +1
out = rsreg(X4,Y4,options)
res=residuals(out)

figure
plot(res,Y4)
