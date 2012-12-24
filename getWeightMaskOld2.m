%function [weightMask] = getWeightMask2(im, h) 

    [height,width,dim] = size(im);
     
      
    if (height < width)
        smallestDim = height;
        largestDim = width;
    else
        smallestDim = width;
        largestDim = height;
    end
    
    if (mod(smallestDim,2) == 0) % even
        halfSize1 = floor(smallestDim/2) - 1
        smallestDimMatrixPart = [[halfSize1:-1:0],[0:halfSize1]]
    else
        halfSize1 = floor(smallestDim/2)
        smallestDimMatrixPart = [[halfSize1:-1:0],[1:halfSize1]]
    end
    
    if (mod(largestDim,2) == 0) % even
        halfSize2 = floor(largestDim/2) - 1
        largestDimMatrixPart = [[halfSize2:-1:0],[0:halfSize2]]
    else
        halfSize2 = floor(largestDim/2)
        largestDimMatrixPart = [[halfSize2:-1:0],[1:halfSize2]]
    end
    
    % norm(x1-x2)/3 =  norm((x1-x2)/3)
    MatrixHalf1 = repmat(smallestDimMatrixPart,smallestDim,1)
    MatrixHalf2 = repmat(largestDimMatrixPart,largestDim,1)
    
    MatrixHalf1Empty = zeros(size(MatrixHalf2));
    if (largestDim-smallestDim == 0)
        limitDiff = 1;
    else
        limitDiff  = largestDim-smallestDim;
    end
    
    MatrixHalf1Empty(limitDiff:size(MatrixHalf1,1)+(limitDiff-1),limitDiff:size(MatrixHalf1,2)+(limitDiff-1)) = MatrixHalf1
    
    Matrix = sqrt(MatrixHalf2 .* MatrixHalf2 + (MatrixHalf1Empty' .* MatrixHalf1Empty'))
    %M2 = (1-(Matrix ./ halfSize2).^2);
    %Index = M2<=0;
    %M2(Index) = 0;
     
    % sum has to be 1, so   
    M2 =  Matrix(limitDiff:height,limitDiff:width);
    M2 = (1- (M2 ./ ((height * width))));
    weightMask = M2 ./ sum(sum(M2))
    %weightMask = M2
%end