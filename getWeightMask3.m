function [weightMask] = getWeightMask3(im) 
    % returns Epanechnikov kernel based weight mask given an image

    [height,width,dim] = size(im);
     
    d = 2;
    C_d = pi;
    
    h = zeros(height,width);
    R = (height + 1) / 2;
    C = (width + 1) / 2;
    sigma = 1.25;

    [X,Y] = meshgrid(-(height-1)/2:(height-1)/2, -(width-1)/2:(width-1)/2); %faster
   % h = exp(-(X.^2 + Y.^2)/(2*sigma.^2));
  
    h = (1/(2*C_d)) * (d + 2) * (1 - ((X.^2 + Y.^2)/max(max((X.^2 + Y.^2)))));
   
    weightMask = h/(sum(sum(h))); %normalise
            
        
end