%function [xN,yN] = getNewPos(x,y,width,height,wholeIm,targetHistogram)

    [pixelWeights,rows,cols] = getPixelWeights2(x,y,width,height,wholeIm,targetHistogram);
    
    RC = [rows',cols'];
    
    RC2 = [RC(:,1).*pixelWeights, RC(:,2).*pixelWeights];
    sumRC2 = sum(RC2);
    sumWeights = sum(pixelWeights);
    
    if (sumWeights == 0 )
        newPos = [0, 0];
    else
        newPos = sumRC2 ./ sumWeights;
    end
    yN = -1 * newPos(1);
    xN = -1 * newPos(2);
    
   
    rows = reshape(rows,3,5);
    cols = reshape(cols,3,5);
    
    wmR = getWeightMask(rows) .* (rows);
    wmC = getWeightMask(cols) .* (cols);
    
    wmR2 = (wmR-yN);
    wmC2  = (wmC-xN);
    
    iC2 = wmC2 == min(min(wmC2))
    
%end