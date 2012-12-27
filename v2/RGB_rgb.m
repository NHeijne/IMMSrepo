function [ convertedImageMatrix ] = RGB_rgb( image )
% conversion function from RGB to normalized rgb
    RGBmatrix = image;
    denominator = sum(RGBmatrix, 3);
    convertedImageMatrix = double(RGBmatrix)./repmat(double(denominator), [1,1,size(RGBmatrix, 3)]);
    [row, col] = find(isnan(convertedImageMatrix));
    convertedImageMatrix(row,col,:) = 1/3; 
end

