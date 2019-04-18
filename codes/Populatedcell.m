function populated = Populatedcell(Labels,Threshold)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function can output the populated cell which's points are greater
% than Threshold.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Labels(i,1): the cell which the ponits belongs to (numData-by-1)
% Threshold: the threshold which the populated cell must be larger than
%             (integer)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% populated: the name of populated cell  (~-by-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Shuai Wu
%  Date : May 23 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
diffLablel = unique(Labels);
populated = [];
for i = 1:size(diffLablel,1)
    index = (Labels==diffLablel(i,1));
    if sum(index)>Threshold
        populated = [populated;diffLablel(i,1)];
    end 
end
end
