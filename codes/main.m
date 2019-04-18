clear 
close all
clc 

%% Load the data set
load('Aggregation.mat')

%% Obatin a set P of projections.
P = eye(size(X,2));

%% Map data set X into a new space
pdata = X*P; 

%% Parameter
% the number of cutting plan
q = 1;
% min_cut_score
Threshold = 0.5;


%% Clustering
Tree = Optigrid(pdata,q,Threshold);
N = size(pdata,1);
global num ;
global labelData;
num = 0;
labelData = zeros(N,1);
index = 1:N;
labelEachPoint(Tree, index)



%% Plot the result of clustering (only for 2-D dataset)
if size(pdata,2)~=2
    error('Plot the result of clustering (only for 2-D dataset)')
end
label = labelData;
Gridline(pdata,Tree,label)

