function oznake = klasifikacija(hist_test)

load deskriptori
load ground_truth_1
C = truth;

test_set = transpose(hist_test(:, :));

% L2 normalizacija
%test_set = test_set ./ repmat(sqrt(sum(test_set.^2, 2)), 1, size(test_set, 2));

% L1 normalizacija
test_set = test_set ./ repmat(sum(test_set, 2), 1, size(test_set, 2));


load model_svm

[predict_label_svm, accuracy, prob_est] = libsvmpredict(zeros(size(test_set, 1), 1), test_set, model);
oznake = predict_label_svm;
 
end