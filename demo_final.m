%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file is the demo of proposed MFCL by Chaoxun Guo 
% The used dataset is a publicly available dataset from existing work.
% For pravicy protection, the pulse dataset will be publicly available later.
% Any problem please contact: guochaoxun@cuhk.edu.cn
% 2022/07/26
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear
load data
K_fold = 10;  
%% initialize parameter
param.beta    = 0.10;
param.eta     = 1;
param.lambda  = 1;
param.q       = 9;
param.iter_num= 10;

for k = 1:K_fold
    % k_fold
    [data_tr, data_tt, trls, ttls] = k_fold(class1,class2, lable1, lable2, K_fold, k);
    % initialization
    [D, Z, P, L, Y_mat] = initialization(data_tr, trls, param);
    % training
    [D, P, obj] = train(data_tr, Y_mat, D, Z, P, L, param);
    % testing
    acc(k) = test(data_tt, ttls, D, P);
end
final_accuracy = mean(acc)