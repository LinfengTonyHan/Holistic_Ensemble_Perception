%% This script is for analyzing the slope of all individuals in upright and inverted conditions
clear all;
close all;
clc;

global Num_Face;
Num_Face = 1:6;

load Upr.mat 
load Inv.mat 

SUB = 11;
for ite = 1:SUB
  [~,slope_inv,~] = regression(Num_Face,Inv(ite,:));
  [~,slope_upr,~] = regression(Num_Face,Upr(ite,:));
 
  SLOPE_INV(ite) = slope_inv;
  SLOPE_UPR(ite) = slope_upr;
end

%paired-sample t-test
[h,p,CI,stats] = ttest(SLOPE_UPR,SLOPE_INV);
