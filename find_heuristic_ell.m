function ell = find_heuristic_ell(X)

% Finds the median of the pairwise distances between the input data. It is 
% used to set heuristically the length scale of the RBF.
% Each column of X holds the D-dimensional data.

[D, N] = size(X);

tmp = dist(X);
logi = tril(true(size(tmp)), -1);
tmp = tmp(~logi);
ell = median(tmp);

end