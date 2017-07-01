tic

clc
clear all

params

% formiranje liste slika
dir_list = dir([IMAGEDIR filesep '*' ext]);
Nimages = length(dir_list);


num_patches = 1000;
num_words = 1000;

 load('words') %ucitavanje kodne knjige
 hist = zeros(num_words,Nimages);

for i = 1:length(dir_list)
    filename = char(dir_list(i).name);
    I = imread([IMAGEDIR filesep filename]);
    I = im2single(I);
    I = rgb2hsv(I);
    
    [frame, desc] = vl_phow(I, 'step', 2, 'color', 'hsv', 'contrastthreshold', 0.01); %racunanje deskriprora
    descNew = vl_colsubset(desc, num_patches); %bira se 1000 vektora
    kdtree = vl_kdtreebuild(centers); %kreira se kd stablo
    nn = vl_kdtreequery(kdtree, double(centers), double(descNew)); %najblizi susjed
    hist(:,i) = histc(nn(:), 1:num_words);% generise se histogram
 
end
   

save('deskriptori.mat', 'hist');

toc
