%% This script is for processing the data of NEW STIMULI TEMPORAL

% This is only a sample analysis for one single subject
% Find the variables Corr_U_Z & Corr_I_Z for the results
clear;
close;
clc;

cd DATA_Spatial
load Result_11.mat
cd ..
R_All = [Trial_Order;Order;MEAN;MEAN_WHOLE;RESPONSE];
R_All = sortrows(R_All',1)';
R_up = R_All(:,1:300);
R_in = R_All(:,301:600);
R_up = sortrows(R_up',2)';
R_in = sortrows(R_in',2)';

UP_Res = R_up(5,:);
IN_Res = R_in(5,:);
UP_MW = R_up(4,:);
IN_MW = R_in(4,:);
UP_M  = R_up(3,:);
IN_M = R_in(3,:);

fn1 = 1:50; fn2 = 51:100; fn3 = 101:150; fn4 = 151:200; fn5 = 201:250; fn6 = 251:300;

Corr_U = [regression(UP_MW(fn1),UP_Res(fn1)),regression(UP_MW(fn2),UP_Res(fn2)),...
    regression(UP_MW(fn3),UP_Res(fn3)),regression(UP_MW(fn4),UP_Res(fn4))...
    regression(UP_MW(fn5),UP_Res(fn5)),regression(UP_MW(fn6),UP_Res(fn6))];

%% Correlation between inverted responses and upright ratings;
Corr_I = [regression(IN_MW(fn1),IN_Res(fn1)),regression(IN_MW(fn2),IN_Res(fn2)),...
    regression(IN_MW(fn3),IN_Res(fn3)),regression(IN_MW(fn4),IN_Res(fn4))...
    regression(IN_MW(fn5),IN_Res(fn5)),regression(IN_MW(fn6),IN_Res(fn6))];

Corr_U_Z = 0.5 * (log(1+Corr_U) - log(1-Corr_U));
Corr_I_Z = 0.5 * (log(1+Corr_I) - log(1-Corr_I));
