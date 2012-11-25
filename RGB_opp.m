function [ opponentColorSpace ] = RGB_opp( image )
%RGB to opponent color space
RGB = image;
RGBsum = sum(RGB, 3);
opponentColorSpace = zeros(size(RGB));
opponentColorSpace(:,:,1) = RGBsum/3;
opponentColorSpace(:,:,2) = RGB(:,:,2) - RGB(:,:,1);
opponentColorSpace(:,:,3) = RGB(:,:,3) - (RGB(:,:,1)+RGB(:,:,2));
end

