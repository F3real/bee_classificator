function test = zad4(im)

a = imread(im);
a = im2double(a);
seg = segmentacija(a);
seg = im2bw(seg);
%figure, imshow(seg);

%%
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

%%

IMAGEDIR = 'E:\ETF\VIII semestar\Digitalna obrada slike\Projektni\Rjesenja\zadatak4\test';
centers = visual_words_test(IMAGEDIR);
hist_test = sift_descriptor_test(IMAGEDIR);
p = klasifikacija_test(hist_test);

%% 
labels = bwlabel(seg);
%figure, imshow(labels);
for i = 1:numel(p)
    if p(i) == 2
        labels(labels==i) = 1;
    else
        labels(labels==i) = 0;
    end
end
%figure, imshow(labels);
labels_rgb = cat(3, labels, labels, labels);
pcele_sa_polenom = labels_rgb.*a;
figure, imshow(pcele_sa_polenom);
end