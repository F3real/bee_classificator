function centers_test = visual_words(IMAGEDIR)

ext = '.jpg';
num_training_codebook = 100;
num_patches = 1000;
num_words = 1000;
 
% formiranje liste slika
dir_list = dir([IMAGEDIR filesep '*' ext]);
Nimages = length(dir_list);

% alokacija memorije za SIFT deskriptore koje cemo klasterizovati
data = zeros(384, num_training_codebook*num_patches, 'single');

kk = 0;
for k = 1:num_training_codebook
%     ii = randi(Nimages, 1);
    ii = ceil(Nimages * rand());
    im = im2single(imread([IMAGEDIR filesep dir_list(ii).name]));
    [frames, descrs] =  vl_phow(im, 'step', 2, 'color', 'hsv', 'contrastthreshold', 0.01);
    data(:, (k-1)*num_patches+1:k*num_patches) = vl_colsubset(descrs, num_patches);
 end

centers_test = vl_kmeans(data, num_words, 'verbose', 'algorithm', 'elkan');

save('words_test.mat', 'centers_test');

end



                    
 
