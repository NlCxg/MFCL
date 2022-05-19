function [L, W, D] = gmrf_create_L(labels, varargin)

% [L, W, D] = gmrf_create_L(labels, data_in, ind)
%
% Creates the Laplacian matrix based on the labels. If input data is
% specified then the Heat kernel is used and the normalized the Laplacian
% is created for each view.

tmp = dist(labels');
W_l = zeros(size(tmp));
W_l(tmp==0) = 1;
W_l(logical(eye(size(W_l)))) = 0;

if nargin > 1
    num_mod = numel(varargin{1});
    Lap = 0; L = cell(num_mod,1); D = cell(num_mod,1); W = cell(num_mod,1);
    for i = 1:num_mod
        Y = standardize(varargin{1}{i}, 1);
        t = find_heuristic_ell(Y');
        K = covSEisoU(log(t), Y);
        W{i} = K .* W_l;
        
        D{i} = sum(W{i}, 2);
        D{i} = diag(D{i});
        
        L{i} = D{i} - W{i};
        D{i} = diag(diag(D{i}).^-.5);
        L{i} = D{i}*L{i}*D{i};
        
        L{i}(isnan(L{i})) = 0; D{i}(isnan(D{i})) = 0;
        L{i}(isinf(L{i})) = 0; D{i}(isinf(D{i})) = 0;
    end
    for i = 1:num_mod
        Lap = Lap + L{i};
    end
    clear L;
    L = Lap + 1*10^-3*eye(size(Lap));
else
    D = sum(W_l, 2);
    D = diag(D);
    
    L = D - W_l;
    
    D = diag(diag(D).^-.5);
    L = D*L*D;
    % L = L + 1*10^-3*eye(size(L));
    
    L(isnan(L)) = 0; D(isnan(D)) = 0;
    L(isinf(L)) = 0; D(isinf(D)) = 0;
%     L = L; D = D;
end

end