function [D, P, obj] = train(X, Y, D, Z, P, L, param)
beta     = param.beta;
eta      = param.eta;
lambda   = param.lambda;
iter_num = param.iter_num;
view_num = numel(X);
for v = 1:view_num
    XTX{v} = X{v}'*X{v};
end
[N, q] = size(Z);
for iter = 1:iter_num
    % update D
    for v = 1:view_num
        tmp1 = XTX{v}+lambda*eye(size(XTX{v}));
        
        view_list = 1:view_num;
        view_list(v) = [];
        sum_XD = zeros(N,q);
        for j = view_list
            sum_XD = sum_XD + X{j}*D{j};
        end
        tmp2 = X{v}'*(Z-sum_XD);
        D{v} = tmp1\tmp2;
    end
    
    % update Z
    sum_XD = zeros(N,q);
    for v = 1:view_num
        sum_XD = sum_XD + X{v}*D{v};
    end
    A = beta*L+lambda*eye(size(L));
    B = eta*(P*P')+eye(size(P,1));
    C = -(sum_XD+eta*Y*P');
    Z = lyap(A,B,C);
    
    % update P
    tmp1 = eta*(Z'*Z)+lambda*eye(q);
    tmp2 = eta*Z'*Y;
    P = tmp1\tmp2;
    
    % calculate the objective function
    obj(iter) = (norm(sum_XD-Z,'fro')).^2 + beta*trace(Z'*L*Z) + eta*(norm(Z*P-Y,'fro')).^2;
    obj(iter) = obj(iter) + lambda*((norm(Z,'fro')).^2+(norm(P,'fro')).^2);
    for v = 1:view_num
        obj(iter) = obj(iter) + lambda*(norm(D{v},'fro')).^2;
    end
end













