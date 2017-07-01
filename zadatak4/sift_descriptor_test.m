function hist_test = sift_descriptor(IMAGEDIR)


ext = '.jpg';

% formiranje liste slika
dir_list = dir([IMAGEDIR filesep '*' ext]);
Nimages = length(dir_list);


num_patches = 1000;
num_words = 1000;

 load('words_test') 
 hist_test = zeros(num_words,Nimages);

for i = 1:length(dir_list)
    filename = char(dir_list(i).name);
    I = imread([IMAGEDIR filesep filename]);
    I = im2single(I);
    I = rgb2hsv(I);
    
    [frame, desc] = vl_phow(I, 'step', 2, 'color', 'hsv', 'contrastthreshold', 0.01);
    descNew = vl_colsubset(desc, num_patches); 
    kdtree = vl_kdtreebuild(centers_test); 
    nn = vl_kdtreequery(kdtree, double(centers_test), double(descNew));
    hist_test(:,i) = histc(nn(:), 1:num_words);% generise histogram
 
end
   

save('deskriptori_test.mat', 'hist_test');

end