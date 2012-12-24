function frequencies = hist3d(x, y, width, height, wholeIm, n_,scaleFactor_)

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

    %% compute candidate target im
    [wholeImHeight,wholeImWidth,imDim] = size(wholeIm);
    widthHalf = floor(width / 2);
    heightHalf = floor(height / 2);
    startX  = x - widthHalf;
    startY = y - heightHalf;
    endX = x + widthHalf;
    if ((mod(widthHalf,2)) == 0 ) % even
        endX = endX - 1;
    end
    endY = y + heightHalf;
    if ((mod(heightHalf,2)) == 0 ) % even
        endX = endX - 1;
    end
    
    minXWholeIm= max(startY,1);
    minYWholeIm = max(startX,1);
    maxYWholeIm= min(endY,wholeImHeight);
    maxXWholeIm = min(endX,wholeImWidth);
     
    possibleIm = zeros(height, width,3);
    possibleIm(0: = wholeIm(startY:maxHeightIm, startX:maxWidthIm,:);
    avgChannels = mean(mean(possibleIm,1)); % mean of R, G and B
    possibleIm(maxHeightObject+1:objectHeight, maxWidthObject+1:objectWidth) = fillEmptyValue;
    
    
	[imHeight,imWidth,imDim] = size(im);

    %im2double takes the intensity
 	im = im2double(im); % convert to interval [0,1]

	%% assigning the pixels to the histogram cells
%    step = 255/n;
	step = 1/n;
 	imCells = ceil(im/step); % each pixel gets a number denoting cell
  	imCells(imCells==0) = 1 % cell_no can be computed as 0, so we assing them to the first cell
	% imshow(imCells/n);

	%% Computing the frequencies
	frequencies = zeros(n,n,n);  % initialization of vector, which will be used for saving the frequencies
    
 	for col = 1:imWidth
 		for row = 1:imHeight
 			pixelValue = imCells(row,col,:);
 			frequencies(pixelValue(1),pixelValue(2),pixelValue(3)) = ...
 				frequencies(pixelValue(1),pixelValue(2),pixelValue(3)) + 1;
 		end
    end	

    

end
