clc;
clear all;

res = zeros(1,20);

for n = 1:20
    IMAGE_NAME = strcat('Bee_frame_', num2str(n));
    
    IMAGE_NAME_RES_AUTO = strcat(IMAGE_NAME, 'auto.jpg');
    IMAGE_RES_AUTOMATIC = strcat('.\automatic\',IMAGE_NAME_RES_AUTO);
    IMAGE_NAME_RES_MANUAL= strcat(IMAGE_NAME, '_manual.jpg');
    IMAGE_RES_MANUAL = strcat('.\manual\',IMAGE_NAME_RES_MANUAL);
    
    manual = imread(IMAGE_RES_MANUAL);
    automatic = imread(IMAGE_RES_AUTOMATIC);
    union = logical(manual + automatic);
    diff = logical(manual .* automatic);
    res(n) =  sum(diff(:)) / sum(union(:));
end