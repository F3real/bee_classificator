categories = {'bez_polena','sa_polenom'};
Nclasses = length(categories);

% broj trening slika po klasi
Ntraining_class = 100;

%% Ucitavanje deskriptora

%load deskriptori
load deskriptori
%hist = cat(2,hist);


Nsamples = size(hist, 2);

% ucitati oznake klasa za sve slike
load ground_truth_1
C = truth;

%% Klasifikacija 


    % Podjela na trening i validacioni skup
     train_ind = [];
     
     for c = 1:Nclasses
         class_ind = find(C == c);
         ii = randperm(length(class_ind));
         train_ind = [train_ind; class_ind(ii(1:Ntraining_class))];
     end
     validation_ind = setdiff(1:Nsamples, train_ind);
    
    
    % LIBSVM ocekuje primjere u redovima
    training_set = transpose(hist(:, train_ind)); 
    validation_set = transpose(hist(:, validation_ind));
   
    % L2 normalizacija
    training_set = training_set ./ repmat(sqrt(sum(training_set.^2, 2)), 1, size(training_set, 2));
    validation_set = validation_set ./ repmat(sqrt(sum(validation_set.^2, 2)), 1, size(validation_set, 2));
    
    % L1 normalizacija
   % training_set = training_set ./ repmat(sum(training_set, 2), 1, size(training_set, 2));
   % validation_set = validation_set ./ repmat(sum(validation_set, 2), 1, size(validation_set, 2));
    
    
    % obucavanje klasifikatora i klasifikacija
    
    Ctraining = C(train_ind);
    Cvalidation = C(validation_ind);
    model = libsvmtrain(double(Ctraining), training_set, ['-c 10 -t 2 -g 1e-3']);
    [predict_label_svm, accuracy, prob_est] = libsvmpredict(Cvalidation, validation_set, model);
    
    acc_svm = sum(predict_label_svm == Cvalidation) / length(Cvalidation)
    cm_svm = conf_mat(predict_label_svm, Cvalidation, 2)
    
    save('model_svm.mat','model');


