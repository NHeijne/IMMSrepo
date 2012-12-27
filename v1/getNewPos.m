function [xNew,yNew] = getNewPos(x,y,width,height,wholeIm,targetHistogram)

    %[wholeImHeight, wholeImWidth, wholeImDim] = size(wholeIm);
    
    [pixelWeights,rows,cols] = getPixelWeights2(y,x,width,height,wholeIm,targetHistogram);
    
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
    
   
    rows = reshape(rows,height,width);
    cols = reshape(cols,height,width);
    
    wmR = getWeightMask(rows,0) .* (rows)
    wmC = getWeightMask(cols,0) .* (cols)
    
    wmR2 = abs(wmR-yN);
    wmC2  = abs(wmC-xN);
    
    iC2 = wmC2 == min(min(wmC2));    
    iR2 = wmR2 == min(min(wmR2));
    
    %wholeX = cols(iC2);
    %wholeY = rows(iR2);
    
    wholeX = wmC(iC2);
    wholeY = wmR(iR2);
    
    %yNew = wholeY(1)*0.1;
   % xNew = wholeX(1)*0.1;
    
    %yNew = yN;
   % xNew = xN;
    
    yNew = wholeY(1);
    xNew = wholeX(1);
end