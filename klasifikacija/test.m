clear all;
load('classifier.mat');
rootDir = uigetdir();
%%
files = dir(rootDir);

res = fopen('res.txt','w');
% we start from 3 to avoid . and ..
for n = 3 : size(files)
    img = imread(fullfile(rootDir, files(n).name));
    [labelIdx, scores] = predict(categoryClassifier, img);
    fprintf(res,'%s; %s\n',files(n).name,categoryClassifier.Labels{labelIdx});
end
fclose(res);
%%