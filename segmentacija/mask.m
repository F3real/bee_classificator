clc;
clear all;


IMAGE_NAME = strcat('Bee_frame_', num2str(20));
IMAGE_NAME_RES = strcat(IMAGE_NAME, '_manual.jpg');
IMAGE_NAME = strcat(IMAGE_NAME, '.jpg');

IMAGE_PATH = strcat('../../Frejmovi/', IMAGE_NAME);
IMAGE_RES = strcat('.\manual\',IMAGE_NAME_RES);

a = imread(IMAGE_PATH);
x = size(a,1);
y = size(a,2);
mask1 = false(x,y);
mask2 = false(x,y);
 
% for bees with polen

while(1)

     f = figure;
     set(f, 'name',['Mark bees with pollen']);
     BW1 = roipoly(a); 
     mask1(BW1) = true;
     choice = menu('Add more masks ?','Yes','No');
     if choice == 2
         break;
     end
end

%for bees without polen

while(1)
    f = figure;
    set(f, 'name',['Mark bees without pollen']);
    BW2 = roipoly(a);
    mask2(BW2) = true;
    choice = menu('Add more masks ?','Yes','No');
    if choice == 2
        break;
    end
end

L1 = double(mask1);
L2 = double(mask2);

%bees with pollen are labeled 2
L1(L1 ~= 0) = 2;
%bees without pollen are labeled 1
L2(L2 ~= 0) = 1;

%figure, imshow(L1);
%figure, imshow(L2);
L = L1 + L2; 
figure, imshow(L);

%% cuvanje binarnih maski

imwrite(L,IMAGE_RES);

