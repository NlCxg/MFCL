function [x, m, s2] = standardize(x, unitvar)

% Standaridze the input matrix x to zero mean and unit variance (if unitvar
% is enabled)

m = mean(x);
x = bsxfun(@minus, x, m);

if unitvar
    s2 = std(x);
    x = bsxfun(@times, x, s2.^-1);
end
m=1;s2=1;
end