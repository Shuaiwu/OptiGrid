function labels = MultidimensionalGrid(cut,data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This function can construct a multidimensional grid defined by the 
%  cutting planes in bestcut and insert all data points into grid.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cut(i,1): No.i best cutting plane
% cut(i,2): the index of used projection for No.i best cutting plane
% data: the data set (numData-by-dimen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% labels: the cluster which the point belongs to (numDat-by-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Shuai Wu
%  Date : May 20 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[numCutPlane,~] = size(cut);
numData = size(data,1);
temp = zeros(numData,numCutPlane);
for i = 1:numCutPlane
    temp(:,i) = (data(:,cut(i,2))>=cut(i,1));
end

%% Code each cell
code = arrayfun(@(i) 2^i,(1:numCutPlane)');
labels = temp*code;

end
