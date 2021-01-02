clear all 
clc
addpath(genpath('C:\Users\user\Desktop\DOE\rstools'))

% 
% %XX=fracfact('1 2 3 4 12 13 14 23 24 34 123 134 124 234 1234')
% XX=fracfact('a b c d ab bc ac ad bd cd abc acd abd bcd abcd');
% Y=[45 41 90 67 50 39 95 66 47 43 95 69 40 51 87 72]';
% clear options;
% options.xnames = {'A','B', 'C','D', 'AB','BC', 'AC', 'AD', 'BD', 'CD', 'ABC', 'ACD', 'ABD','BCD', 'ABCD'};
% options.yname = {'Y'};
% options.intera = 0;
% options.code = 0; % code 1 to -1 and 2 to +1
% out = rsreg(XX,Y,options)
% 
% %%
% clear options;
% XY=XX(:,[3 4 8 10 13]);
% options.xnames = {'C','D','AD', 'CD', 'ABD'};
% options.yname = {'Y'};
% options.intera = 0;
% options.code = 0; % code 1 to -1 and 2 to +1
% out = rsreg(XY,Y,options)
%%

[X names]=intera3(twon(4));
%X=[X [X(:,1).*X(:,2).*X(:,3).*X(:,4)]];
Y=[45 41 90 67 50 39 95 66 47 43 95 69 40 51 87 72]';
clear options;
options.xnames = {'A','B', 'C','D', 'AB', 'AC', 'AD', 'BC','BD', 'CD', 'ABC',  'ABD', 'ACD','BCD','ABCD'};
options.yname = {'Y'};
options.intera = 0;
options.code = 0; % code 1 to -1 and 2 to +1
out = rsreg(X,Y,options)

%%
clear options;
XY=X(:,[1 2 5 7 13]);
options.xnames = {'A','B','AB', 'AD', 'ACD'};
options.yname = {'Y'};
options.intera = 0;
options.code = 0; % code 1 to -1 and 2 to +1
out = rsreg(XY,Y,options)