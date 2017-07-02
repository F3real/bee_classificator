rootFolder = '../../Beedata/';
imgSets = [ imageSet(fullfile(rootFolder, 'NoPollen')), ...
            imageSet(fullfile(rootFolder, 'WithPollen')) ];

{imgSets.Description}
[imgSets.Count]

% Split sets into training and validation
[trainingSets, validationSets] = partition(imgSets, 0.3, 'randomize');
% extracts SURF features from all images and constructs the visual vocabulary 
% by reducing the number of features using K-means clustering
bag = bagOfFeatures(trainingSets);
categoryClassifier = trainImageCategoryClassifier(trainingSets, bag);

confMatrix = evaluate(categoryClassifier, trainingSets);
confMatrix = evaluate(categoryClassifier, validationSets);

%average accuracy
mean(diag(confMatrix));

%%
%img = imread(fullfile(rootFolder, 'NoPollen', 'image_100.jpg'));
img = imread(fullfile(rootFolder, 'WithPollen', 'Bee_120.jpg'));
[labelIdx, scores] = predict(categoryClassifier, img);
categoryClassifier.Labels(labelIdx)
