function [D, Z, P, L, Y_mat] = initialization(X, Y, param)
q = param.q;
X_tmp = [];
for i = 1:numel(X)
    X_tmp = [X_tmp X{i}];
end

L = gmrf_create_L(Y, X);
[Z, mapping] = myLPP(X{2}, L+0.01*eye(size(L)), q);%%因为第二个view效果最好，所以先用这个学Z

for i = 1:numel(X)
    D{i} = X{i}\Z;
end

D{2} = mapping;
N = length(Y);
Y_mat = sparse(Y,1:N,1,numel(unique(Y)),N,N);
Y_mat = full(Y_mat);
Y_mat = (2*Y_mat-1)';
P = Z\Y_mat;