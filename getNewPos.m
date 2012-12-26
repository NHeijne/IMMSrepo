function [xN,yN] = getNewPos(x,y,width,height,wholeIm,targetHistogram)

    [pixelWeights,rows,cols] = getPixelWeights2(x,y,width,height,wholeIm,targetHistogram);
    
    RC = [rows',cols'];
    
    RC2 = [RC(:,1).*pixelWeights, RC(:,2).*pixelWeights];
    sumRC2 = sum(RC2);
    sumWeights = sum(pixelWeights);
    
    newPos = sumRC2 ./ sumWeights;
    yN = newPos(1)*-1;
    xN = newPos(2)*-1;
end