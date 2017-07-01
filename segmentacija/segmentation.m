clc;
clear all;

%%
for n = 1:20

    IMAGE_NAME = strcat('Bee_frame_', num2str(n));
    IMAGE_NAME_RES = strcat(IMAGE_NAME, 'auto.jpg');
    IMAGE_NAME = strcat(IMAGE_NAME, '.jpg');

    IMAGE_PATH = strcat('../../Frejmovi/', IMAGE_NAME);
    IMAGE_RES = strcat('.\automatic\',IMAGE_NAME_RES);

    im = imread(IMAGE_PATH);
    %figure, imshow(im), title('Original'), impixelinfo;

    im = double(im);


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


    %figure, imshow(res2), title('After diff 2'), impixelinfo;  
    imwrite(res2,IMAGE_RES);
end
%%
%%
for n = 1:20
    IMAGE_NAME = strcat('Bee_frame_', num2str(n));
    IMAGE_NAME = strcat(IMAGE_NAME, '.jpg');

    IMAGE_PATH = strcat('../../Frejmovi/', IMAGE_NAME);
    IMAGE_RES = strcat('.\automatic\a',IMAGE_NAME);

    im = imread(IMAGE_PATH);
    %figure, imshow(im), title('Original'), impixelinfo;

    im = double(im);
    res = ones(size(im));
    % remove background
    pixel_diff = im(:,:, 3) - im(:,:,2);
    pixel_diff(pixel_diff < 20) = 0;
    pixel_diff(pixel_diff >= 20) = 1;
    pixel_diff = logical(pixel_diff);


    res(:,:,1) = im(:,:,1) .* pixel_diff;
    res(:,:,2) = im(:,:,2) .* pixel_diff;
    res(:,:,3) = im(:,:,3) .* pixel_diff;

    res = im2bw(res, 0.5);
    res = ~res;
    res = imclearborder(res);
    res = bwareaopen(res, 1400);
    figure, imshow(res), title('After diff 1'), impixelinfo;
end
%%
figure,
subplot(1,3,1), imshow(imread(IMAGE_PATH)), title('Org');
subplot(1,3,2), imshow(res), title('Border');
subplot(1,3,3), imshow(res2), title('Shadow');
%%

