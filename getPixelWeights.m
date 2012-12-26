function [pixelWeights,rows,cols] = getPixelWeights(x, y,width,height,wholeIm,targetHistogram)

    [imCells,histogram] = weightedHist3D(y, x, width, height, wholeIm);
    
    %histogram
    imCells
    
    [imHeight,imWidth,imDim] = size(imCells);
    imSize = imWidth*imHeight;
    
   
    pixelWeights = zeros(imHeight,imWidth);
    
    v1 =  reshape(imCells(:,:,1),imSize,1);
    v2 =  reshape(imCells(:,:,2),imSize,1);
    v3 =  reshape(imCells(:,:,3),imSize,1);
    bins=[v1,v2,v3]
    [rows,cols] = ind2sub([imHeight,imWidth],linspace(1,imSize,imSize))
    
    for i=1:imSize
        bin = bins(i,:);
        
         %histogram(bin(1),bin(2),bin(3))
         %targetHistogram(bin(1),bin(2),bin(3))
         
        pixelWeights(rows(i),cols(i)) = ...
            sqrt( ...
                targetHistogram(bin(1),bin(2),bin(3)) / histogram(bin(1),bin(2),bin(3))  ...
            );
    end

%     for hi=1:imHeight
%         for wj = 1:imWidth
%             for ni=1:5
%                 for nj=1:5
%                     for nk=1:5
%                         if (imCells(hi,wj) == [ni,nj,nk])
%                             pixelWeights(hi,wj) = pixelWeights(hi,wj) + sqrt(targetHistogram(ni,nj,nk) / histogram(ni,nj,nk));
%                         end
%                     end
%                 end
%             end
%         end
%     end

    pixelWeights 
    pixelWeights = reshape(pixelWeights,imSize,1);
    
end