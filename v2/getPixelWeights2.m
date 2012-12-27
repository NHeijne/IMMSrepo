function [pixelWeights,rows,cols] = getPixelWeights2(column,row,width,height,wholeIm,targetHistogram)

    [imCells,histogram] = weightedHist3D(column,row, width, height, wholeIm);
    
    %histogram
    %imCells
    
    [imHeight,imWidth,imDim] = size(imCells);
    imSize = imWidth*imHeight;
    
   
    pixelWeights = ones(imHeight,imWidth)*-1;
    
    v1 =  reshape(imCells(:,:,1),imSize,1);
    v2 =  reshape(imCells(:,:,2),imSize,1);
    v3 =  reshape(imCells(:,:,3),imSize,1);
    bins=[v1,v2,v3];    
    
    
    [rows,cols] = ind2sub([imHeight,imWidth],linspace(1,imSize,imSize));
    
    for i=1:imSize
        bin = bins(i,:);
        
         %histogram(bin(1),bin(2),bin(3))
         %targetHistogram(bin(1),bin(2),bin(3))
         
        pixelWeights(rows(i),cols(i)) = ...
            sqrt( ...
                targetHistogram(bin(1),bin(2),bin(3)) / histogram(bin(1),bin(2),bin(3))  ...
            );
        
        if (isnan(pixelWeights(rows(i),cols(i))) || pixelWeights(rows(i),cols(i)) == Inf)
            disp('is NaN or is Inf')
            pixelWeights(rows(i),cols(i)) = 0;
        end
    end
    
    %pixelWeights
    pixelWeights = reshape(pixelWeights,imSize,1)
    
     [Xi,Yi] = meshgrid(-(height-1)/2:(height-1)/2, -(width-1)/2:(width-1)/2);
     rows = reshape(Xi',1,imSize);
     cols = reshape(Yi',1,imSize);
end