function [ hsvImageMatrix ] = RGB_HSV( imagePath )
%RGB to HSV
	RGBmatrix = imread(imagePath);
	hsvImageMatrix = zeros(size(RGBmatrix));
	RminG = RGBmatrix(:,:,1)-RGBmatrix(:,:,2);
	RminB = RGBmatrix(:,:,1)-RGBmatrix(:,:,3);
	GminB = RGBmatrix(:,:,2)-RGBmatrix(:,:,3);
	sumRGB = sum(RGBmatrix,3);
	allOnes = zeros(size(sumRGB))+1.0;
	hsvImageMatrix(:,:,1) = atan((sqrt(3)*double(GminB))./double(RminG+RminB));
	hsvImageMatrix(:,:,2) = allOnes - (double(min(RGBmatrix,[], 3)))./double(sumRGB);
	hsvImageMatrix(:,:,3) = sumRGB/3;
end

