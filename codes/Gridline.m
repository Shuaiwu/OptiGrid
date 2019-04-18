function Gridline(Data,Tree,label)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function can plot 2-D dataset and the grid which are defined in
%  Tree.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data: the data set (N-by-dimen)
% q: the number of cutting plan (integer)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data: the data set (N-by-2)
% Tree :  a tree of clustering (structure)
%      Tree.bestcut:best cutting plane and his projection (q-by-2)
%           Tree.bestcut(i,1):best cutting plane
%           Tree.bestcut(i,2):the index of used projection
%      Tree.cell: the children of the tree (1-by-~ structure)
%      Tree.labels: the clustering labels of data points
%      Tree.subspace: the index of grid which must be divided
% label: the clusters of each points (N-b-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Shuai Wu
%  Date : May 20 2018
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on
cmap = colormap;
cluster = unique(label);
nclust = length(cluster);
for i = 1:nclust
    tmp_data = Data(label==cluster(i),:);
    ic = int8(mod((i*64.)/(nclust*1.),63)+1);
    col = cmap(ic,:);
    plot(tmp_data(:,1),tmp_data(:,2),...
        '.','MarkerSize',8,'MarkerFaceColor',col,'MarkerEdgeColor',col);
end
plot(Data(label==-2,1),Data(label==-2,2),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k');
Cellline(Data,Tree)
hold off
end

function Cellline(Data,Tree)
if isempty(Tree.bestcut)
    return
end
cmap=colormap;
for i = 1:size(Tree.bestcut,1)
    indexp = Tree.bestcut(i,2);
    if indexp ==1
        line([Tree.bestcut(i,1),Tree.bestcut(i,1)],[min(Data(:,2)),...
            max(Data(:,2))],'color',cmap(unidrnd(63),:),'LineWidth',1);
    end
    if indexp ==2
        line([min(Data(:,1)),max(Data(:,1))],[Tree.bestcut(i,1),...
            Tree.bestcut(i,1)],'color',cmap(unidrnd(63),:),'LineWidth',1);
    end
end
if isempty(Tree.subspace)
    return
end
for i = 1:size(Tree.subspace,2)
    sub = Tree.subspace(1,i);
    Cellline(Data((Tree.labels==sub),:),Tree.cell{1,i})
end

end
