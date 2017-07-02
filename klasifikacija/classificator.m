rootFolder = '../../Beedata/';
imgSets = [ imageSet(fullfile(rootFolder, 'NoPollen')), ...
            imageSet(fullfile(rootFolder, 'WithPollen')) ];

{imgSets.Description}
[imgSets.Count]

% Split sets into training and validation
[trainingSets, validationSets] = partition(imgSets, 0.4, 'randomize');
% extracts SURF features from all images and constructs the visual vocabulary 
% by reducing the number of features using K-means clustering
bag = bagOfFeatures(trainingSets,'CustomExtractor', @f_extractor);
categoryClassifier = trainImageCategoryClassifier(trainingSets, bag);

confMatrix = evaluate(categoryClassifier, trainingSets);
% tpr and frp for no pollen
tpr = confMatrix(1,1)/ (confMatrix(1,1) + confMatrix(1,2));
fpr = confMatrix(2,1)/ (confMatrix(2,1) + confMatrix(2,2));
confMatrix = evaluate(categoryClassifier, validationSets);

%average accuracy
mean(diag(confMatrix));

%%
%img = imread(fullfile(rootFolder, 'NoPollen', 'image_100.jpg'));
img = imread(fullfile(rootFolder, 'WithPollen', 'Bee_120.jpg'));
[labelIdx, scores] = predict(categoryClassifier, img);
categoryClassifier.Labels(labelIdx)
%%
save('classifier.mat','categoryClassifier');