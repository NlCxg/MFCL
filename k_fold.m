function [data_tr, data_tt, trls, ttls] = k_fold(class1,class2, lable1, lable2, K, k)
    num_1 = size(class1{1,1},1)/K;
    num_2 = size(class2{1,1},1)/K;
    % test data
    for v = 1:numel(class1)
       data_tt{v} = [class1{v}( (k-1)*num_1+1 : k*num_1,:); class2{v}((k-1)*num_2+1 : k*num_2,:)  ];
    end
    ttls = [lable1((k-1)*num_1+1 : k*num_1,1); lable2((k-1)*num_2+1 : k*num_2,1)];
    % train_data
    for v = 1:numel(class1)
       class1{v}((k-1)*num_1+1 : k*num_1,:) = []; 
       class2{v}((k-1)*num_1+1 : k*num_1,:) = [];
       data_tr{v} = [class1{v};   class2{v}];
    end
    % label
    lable1( (k-1)*num_1+1:k*num_1) = [];
    lable2((k-1)*num_2+1 : k*num_2) = [];
    trls =  [lable1; lable2];
end

