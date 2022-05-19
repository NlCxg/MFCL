clc;clear
load data
for v = 1:numel(data_tr)
    data_tr{v} = (normcol_equal(data_tr{v}))';
    data_tt{v} = (normcol_equal(data_tt{v}))';
end
%% initialize parameter
param.beta    = 0.10;
param.eta     = 1;
param.lambda  = 1;
param.q       = 9;
param.iter_num= 10;
[D, Z, P, L, Y_mat] = initialization(data_tr, trls, param);
%% training
[P, obj] = train(data_tr, Y_mat, D, Z, P, L, param);
%% testing
acc = test(data_tt, ttls, D, P);