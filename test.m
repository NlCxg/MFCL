function acc = test(X, Y, D, P)

view_num = numel(X);
sum_XD = zeros(size(X{1},1), size(D{1},2));
for v = 1:view_num
    sum_XD = sum_XD+X{v}*D{v};
end
Y_test = sum_XD*P;

[~, label_pred] = min((Y_test-1).^2,[],2);
acc = sum(label_pred==Y)/length(Y);
%fprintf('Accuracy is: %f\r', acc);
