load ground_truth
truth(truth == 1) = 2;
truth(truth == 0) = 1;

save('ground_truth_1.mat', 'truth');
