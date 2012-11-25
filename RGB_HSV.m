function [ hsvImageMatrix ] = RGB_HSV( image )
%RGB to HSV
RGB = double(image);
hsvImageMatrix = zeros(size(RGB));
V = max(RGB, [], 3);
C = V-min(RGB, [], 3);
Rh = (RGB(:,:,1) == V);
Gh = (RGB(:,:,2) == V);
Bh = (RGB(:,:,3) == V);
Ch = C;
Ch(C==0) = V(C==0);
H = zeros(size(V));
GminB = RGB(:,:,2)-RGB(:,:,3);
BminR = RGB(:,:,3)-RGB(:,:,1);
RminG = RGB(:,:,1)-RGB(:,:,2);
H(Rh==1) = mod(GminB(Rh==1)./Ch(Rh==1),6);
H(Gh==1) = (BminR(Gh==1)./Ch(Gh==1))+2;
H(Bh==1) = (RminG(Bh==1)./Ch(Bh==1))+4;
H = H * 60;
%(allOnes-atan2(((sqrt(3)/2)*double(GminB)), double(RminG+RminB)/2)) * 360;
hsvImageMatrix(:,:,1) = H;
hsvImageMatrix(:,:,2) = C./V;
hsvImageMatrix(:,:,3) = V;
end

