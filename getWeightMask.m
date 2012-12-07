function [weightMask] = getWeightMask(im, h) 

    [height,width,dim] = size(im);
     
    if (height < width)
        smallestDim = height;
    else
        smallestDim = width;
    end
    
    if (mod(smallestDim,2) == 0) % even
        halfSize = floor(smallestDim/2) - 1;
        smallestDimMatrixPart = [[halfSize:-1:0],[0:halfSize]]
    else
        halfSize = floor(smallestDim/2);
        smallestDimMatrixPart = [[halfSize:-1:0],[1:halfSize]]
    end
    
    % norm(x1-x2)/3 =  norm((x1-x2)/3)
    MatrixHalf = repmat(smallestDimMatrixPart,5,1);
    Matrix = sqrt(MatrixHalf .*MatrixHalf + MatrixHalf' .*MatrixHalf');
    M2 = (1-(Matrix ./ halfSize).^2);
    Index = M2<=0;
    M2(Index) = 0;
     
    % sum has to be 1, so
    numberDiv = sum(sum(M2)); 
    M3=M2./numberDiv;
    weightMask=M3;
end