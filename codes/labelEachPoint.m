function labelEachPoint(Tree, index)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function can label each point in dataset based on the Tree.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data: the data set (N-by-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tree :  the tree obtained from Optigrid (structure)
%      Tree.bestcut:best cutting plane and his projection (q-by-2)
%           Tree.bestcut(i,1):best cutting plane
%           Tree.bestcut(i,2):the index of used projection
%      Tree.cell: the children of the tree (1-by-~ structure)
%      Tree.labels: the clustering labels of data points
%      Tree.subspace: the index of grid which must be divided
% index: the index of points need to be labeled
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Shuai Wu
%  Date : Aug 8 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global labelData;
global num;

if isempty(index)
    return
end
diffLabel = unique(Tree.labels);
numDiffLabel = size(diffLabel,1);
temp = zeros(size(Tree.labels));
for i = 1:numDiffLabel
    temp(Tree.labels==diffLabel(i)) = i;
end
labelData(index,1) = temp + num;
labelData(index(1,Tree.labels==-2)) = -2;
num = num + size(diffLabel,1);
if numDiffLabel==1
    return
end

if ~isempty(Tree.subspace)
    numSubSpace = size(Tree.subspace,2);
    for i = 1:numSubSpace
        labelEachPoint(Tree.cell{1,i},index(Tree.labels==Tree.subspace(i)));
    end
end
end