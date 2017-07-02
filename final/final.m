clear all;
clc;
%add folder klasifikacija to path (for custom feature extractor)
load('../klasifikacija/classifier.mat');

[baseName, folder] = uigetfile();
testImagePath = fullfile(folder, baseName);

%load our test image
img = imread(testImagePath);
%figure, imshow(img);


%segment image
im = double(img);

res2 = ones(size(im));
% remove shadow
im(:,:, 1) = im(:,:, 1) + 20;
pixel_diff2 = im(:,:, 1) - im(:,:,2);

border = 1;
pixel_diff2(pixel_diff2 < border) = 0;
pixel_diff2(pixel_diff2 >= border) = 1;
pixel_diff2(1:120, :) = 0;
pixel_diff2(:, 1:55) = 0;
pixel_diff2 = logical(pixel_diff2);

res2(:,:,1) = im(:,:,1) .* pixel_diff2;
res2(:,:,2) = im(:,:,2) .* pixel_diff2;
res2(:,:,3) = im(:,:,3) .* pixel_diff2;

res2 = im2bw(res2, 0.5);
se = strel('disk',8);
res2 = imopen(res2,se);
res2 = imclearborder(res2);
res2 = bwareaopen(res2, 1600);



%figure, imshow(res2);

[B,L] = bwboundaries(res2, 'noholes');
stats = regionprops(L, 'all'); 

imshow(img); hold on;
for n=1:size(stats)
    croppedImage = imcrop(img, stats(n).BoundingBox);
    %figure, imshow(croppedImage);
    [labelIdx, scores] = predict(categoryClassifier, croppedImage);
    categoryClassifier.Labels{labelIdx}
    if strcmp(categoryClassifier.Labels{labelIdx},'NoPollen') == 0
        plot(stats(n).Centroid(1),stats(n).Centroid(2),'ro');
    else
        plot(stats(n).Centroid(1),stats(n).Centroid(2),'go');
    end
end
