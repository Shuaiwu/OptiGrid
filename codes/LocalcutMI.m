function [cutplane,score] = LocalcutMI(Data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BEGIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function can compute the cutting plane and their score of Data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data: the data set (N-by-1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cutplane: the cutting plane (n-by-Dimen)
% score   : the score of cutting plane (n-by-1)
%   n     : the number of cutting plane
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERSION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Shuai Wu
%  Date : May 23 2018 
%  E_mail: shuaiwu.ws@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bin = 25;  % the number of interval for each dimension

%% We set the noise level as 0 and the function for determination 
%% of the best local cutting planes as exp(rho) where rho is the 
%% density of probability
noiseLevel = 0;
fun = @exp;

%% Histograms
[n,x] = hist(Data,bin);
isAboveNoiseLevel = (n>= noiseLevel);
n(1,~isAboveNoiseLevel) = 0;

%% Find the minimum of density function
[~,minimum] = findpeak(n);
indexCutPlane = minimum ;
cutplane = x(1,indexCutPlane)';

%% Compute cutting score
score = fun(-n(1,indexCutPlane))';

end
