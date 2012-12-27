function cImage = compress_image(image, stepSize)
% stepSize must be > 1 !

    [hIm,wIm,dIm] = size(image);
    height = ceil(hIm / (stepSize));
    width = ceil(wIm / (stepSize));
    
    cImage = zeros(height, width, dIm);
    
    cI = 1;    
    for i=1:stepSize:hIm
        cJ = 1;
        for j=1:stepSize:wIm
            nbh_matrix = nbh(image, i, j, stepSize-1);
            meanValue = mean(mean(nbh_matrix));
            cImage(cI, cJ,:) = meanValue;
            cJ = cJ + 1;
            
        end
        cI = cI + 1;        
    end
    cImage = uint8(cImage);
end