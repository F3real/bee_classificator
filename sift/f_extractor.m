function [features, metrics] = f_extractor(I) 

Ilab = rgb2lab(I);                                                                             
Ilab = imresize(Ilab, 1/16);

% Reshape L*a*b* image into "number of features"-by-3 matrix.
[Mr,Nr,~] = size(Ilab);    
colorFeatures = reshape(Ilab, Mr*Nr, []); 
           
% L2 normalize color features
rowNorm = sqrt(sum(colorFeatures.^2,2));
colorFeatures = bsxfun(@rdivide, colorFeatures, rowNorm + eps);
        
% Normalize pixel coordinates to handle different image sizes.
xnorm = linspace(-0.5, 0.5, Nr);      
ynorm = linspace(-0.5, 0.5, Mr);    
[x, y] = meshgrid(xnorm, ynorm);
    
% Concatenate the spatial locations and color features.
features = [colorFeatures y(:) x(:)];
    
% Use color variance as feature metric.
metrics  = var(colorFeatures(:,1:3),0,2); 
end