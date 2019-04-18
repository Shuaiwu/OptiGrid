function Tree = Optigrid(Data, q, minCutScore)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is an implementation of Optimal Grid-Clustering.
% (Alexander Hinneburg and Daniel A. Keim.Optimal grid-clustering: Towards 
% breaking the curse of dimensionality in high-dimensional clustering. In 
% Proceedings of the 25 th International Conference on Very Large
% Databases, 1999, pages 506¨C517, 1999.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data: the data set (N-by-dimen)
% q: the number of cutting plan (integer)
% Threshold: min_cut_score
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tree :  a tree of clustering (structure)
%      Tree.bestcut:best cutting plane and his projection (q-by-2)
%           Tree.bestcut(i,1):best cutting plane
%           Tree.bestcut(i,2):the index of used projection
%      Tree.cell: the children of the tree (1-by-~ structure)
%      Tree.labels: the clustering labels of data points
%      Tree.subspace: the index of grid which must be divided
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Shuai Wu
%  Date : May 20 2018
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ADDITION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  We set the noise level as 0 and the function for determination of the 
% best local cutting planes as exp(rho) where rho is the density of 
% probability. What's more, the inner function of Matlab ksdensity is 
% employed to estimate the probability density function. (Noise level,
% cutting score function, density function can be rewritten in Localcut.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = size(Data,1);
thresholdPopulatedCell = 0.1*N;

%% Initialize
Tree.bestcut = [];
Tree.cell = [];
Tree.labels = [];
Tree.subspace = [];
bestcut = [];             
scorecut = [] ;

%% Detemine best local cutting plane
for i = 1:size(Data,2)
    % cutting plane
    [cutplane,score] = Localcut(Data(:,i));
    % compare
    if~isempty(score)
        index = (score'>=minCutScore);
        bestcut = [bestcut;[cutplane(index,1),i*ones(sum(index),1)]];
        scorecut = [scorecut;score(index,1)];
    end
end

%% If the space can't be divided,make all data as a cluster.
if isempty(scorecut) 
    Tree.labels = -1*ones(size(Data,1),1); 
    return;
end

%% Determine the q cutting planes with highest score.
[~,index] = sort(scorecut,'descend');
numplane = min(q,size(scorecut,1));
bestcut = bestcut(index(1:numplane,1),:);
Tree.bestcut = bestcut;

%% Construct a multidimensional grid defined by the cutting planes
%%  in bestcut and insert all data points into grid.
labels = MultidimensionalGrid(bestcut,Data); 

%% Determine the highly populated grid cells.
cell = Populatedcell(labels,thresholdPopulatedCell);
if isempty(cell)
    return;
end
Tree.subspace = cell';
%% Add the highly populated grid cells into the set of clusters
Tree.labels = -2*ones(size(Data,1),1); %the label of noise is -2.
for i = 1:size(cell,1)
    Tree.labels(labels==cell(i)) = cell(i);
end

%% Operate the same process on highly populated cell
for i = 1:size(cell,1)   
    Tree.cell{1,i} = Optigrid(Data((labels==cell(i,1)),:), q, minCutScore);
end

end


