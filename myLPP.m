function [Xz, mapping] = myLPP(X, Lap, n)

% Finds a discriminative subpsace of the input data based on Locality
% Preserving Projections. The Laplacian matrix, Lap with the structure of
% the data needs to be defined, as well as the desirable size of the space,
% n.

X = standardize(X, 1);

DP = X' * X ;
LP = X' * Lap * X;
DP = (DP + DP')/2;
LP = (LP + LP')/2;

[eigvec, eigval]=eig(LP,DP);
eigval = diag(eigval);

[eigval, ind] = sort(eigval);
eigvec = eigvec(:, ind);

for i = 1:size(eigvec,2)
    mapping(:,i) = eigvec(:,i)./norm(eigvec(:,i));
end
mapping = mapping(:,1:n);

Xz = X*mapping;
end