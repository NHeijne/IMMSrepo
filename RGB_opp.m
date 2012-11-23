function [ opponentColorSpace ] = RGB_opp( imagePath )
%RGB to opponent color space
RGB = imread(imagePath);
RGBsum = sum(RGB, 3);
opponentColorSpace = zeros(size(RGB));
opponentColorSpace(:,:,1) = RGBsum/3;
opponentColorSpace(:,:,2) = RGB(:,:,2) - RGB(:,:,1);
opponentColorSpace(:,:,3) = RGB(:,:,3) - (RGB(:,:,1)+RGB(:,:,2));
end

