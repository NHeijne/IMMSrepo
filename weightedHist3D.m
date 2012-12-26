function [imCells,histogram] = weightedHist3D(y,x, width, height, wholeIm, n_,scaleFactor_)
% values of wholeIm should be in [0,1] or [1,255]

	%% set default number of bins if that number is not provided    
    
	n = 5;
    scaleFactor = 0;
	if (nargin < 2)
		n = 5;
		scaleFactor = 0.6;
    elseif (nargin < 3)
		n = n_;		
        scaleFactor = 0.6;
    end    

    
    %% create candidate target im
    [wholeImHeight,wholeImWidth,imDim] = size(wholeIm);
    widthHalf = floor(width / 2);
    heightHalf = floor(height / 2);
    startX  = x - widthHalf;
    startY = y - heightHalf;
    endX = x + widthHalf;
    if ((mod(width,2)) == 0 ) 
        endX = endX - 1;
    end
    endY = y + heightHalf;
    if ((mod(height,2)) == 0 ) 
        endY = endY - 1;
    end
%     startX
%     startY
%     endX
%     endY
%     
    minXWholeIm= max(startX,1);
    minYWholeIm = max(startY,1);
    maxYWholeIm= min(endY,wholeImHeight);
    maxXWholeIm = min(endX,wholeImWidth);
    
    %IF...
    if (startX < minXWholeIm)
        sWidth = width - (maxXWholeIm - minXWholeIm);
    else
        sWidth = 1;
    end
    if (startY < minYWholeIm)
        sHeight = height - (maxYWholeIm - minYWholeIm);
    else
        sHeight=1;
    end
    if (endX > maxXWholeIm)
        eWidth = (maxXWholeIm - minXWholeIm)+1;
    else
        eWidth = width;
    end
    if (endY > maxYWholeIm)
        eHeight = (maxYWholeIm - minYWholeIm)+1;
    else
        eHeight = height;
    end
    
    
    partIm = wholeIm(minYWholeIm:maxYWholeIm,minXWholeIm:maxXWholeIm,:) ;
    avgChannels =  mean(mean(partIm,1)); % mean of R, G and B
    
    im = zeros(height, width,3);
    im(1:height, 1:width,:) = repmat(avgChannels,height,width);
    im(sHeight:eHeight,sWidth:eWidth,:) = partIm;
        
   % imshow(uint8(im));
   % pause(1);
    im;
    
    weightMaskIm =  getWeightMask(im) ;
    
	[imHeight,imWidth,imDim] = size(im);

    
    %im2double takes the intensity
 	im = im2double(im); % convert to interval [0,1]

    
   % pause(0.01);
	%% assigning the pixels to the histogram cells
    step = 255/n;
	%step = 1/n;
 	imCells = ceil(im/step); % each pixel gets a number denoting cell (cell is 3D thing)
  	imCells(imCells==0) = 1; % cell_no can be computed as 0, so we assing them to the first cell
	% imshow(imCells/n);

	%% Computing the frequencies
	frequencies = zeros(n,n,n);  % initialization of vector, which will be used for saving the frequencies
    
 	for col = 1:imWidth
 		for row = 1:imHeight
 			pixelValue = imCells(row,col,:);
 			frequencies(pixelValue(1),pixelValue(2),pixelValue(3)) = ...
 				... %weightMaskIm(row,col) * %
                frequencies(pixelValue(1),pixelValue(2),pixelValue(3)) + 1;
 		end
    end	

     sumFrequencies = sum(sum(sum(frequencies)));
     frequencies = frequencies ./ sumFrequencies;
     histogram = frequencies;
end
