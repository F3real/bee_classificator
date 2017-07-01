
%% ucitavanje slike i segmentacija

clc
clear all

a = imread('Bee_frame_20.jpg');
a = im2double(a);
seg = segmentacija(a);
seg = im2bw(seg);


%% izdvajanje pcela u slike 86x86
s = regionprops(seg,'centroid');
imshow(seg); hold on;
for x = 1: numel(s)
    plot(s(x).Centroid(1),s(x).Centroid(2),'ro');
end

centroids = cat(1, s.Centroid);

[row col] = size(centroids);



for i = 1:row
    c1 = centroids(i,1) - 43;
    c2 = centroids(i,2) - 43;
    I = imcrop(a,[c1 c2 85 85]);
    %figure, imshow(I);
   
    pathname = 'E:\ETF\VIII semestar\Digitalna obrada slike\Projektni\Rjesenja\zadatak4\test\';
    imwrite(I,[pathname,'Bee_', int2str(i), '.jpg']);
end 

%% racunanje deskriptora i klasifikacija

IMAGEDIR = 'E:\ETF\VIII semestar\Digitalna obrada slike\Projektni\Rjesenja\zadatak4\test';
centers = visual_words_test(IMAGEDIR);
hist_test = sift_descriptor_test(IMAGEDIR);
p20 = klasifikacija_test(hist_test);

%% prikazivanje pcela koje nose polen
labels = bwlabel(seg);
%figure, imshow(labels);
for i = 1:numel(p20)
    if p20(i) == 2
        labels(labels==i) = 1;
    else
        labels(labels==i) = 0;
    end
end
labels_rgb = cat(3, labels, labels, labels);
pcele_sa_polenom = labels_rgb.*a;
figure, imshow(pcele_sa_polenom);

% cuvanje oznaka
save('predicted_labels_20.mat', 'p20')

%% matrica konfuzija
%load oznake19
%cm = conf_mat(p,oznake19 ,2)