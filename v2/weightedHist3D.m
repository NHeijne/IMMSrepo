function [imCells,histogram] = weightedHist3D(column,row, width, height, wholeIm, n_,scaleFactor_)
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
    startColumn  = column - widthHalf;
    startRow = row - heightHalf;
    endColumn = column + widthHalf;
    if ((mod(width,2)) == 0 ) 
        endColumn = endColumn - 1;
    end
    endRow = row + heightHalf;
    if ((mod(height,2)) == 0 ) 
        endRow = endRow - 1;
    end
%     startColumn
%     startRow
%     endColumn
%     endRow
%     
    minColumnsWholeIm= max(startColumn,1);
    minRowsWholeIm = max(startRow,1);
    maxRowsWholeIm= min(endRow,wholeImHeight);
    maxColumnsWholeIm = min(endColumn,wholeImWidth);
    
    %IF...
    if (startColumn < minColumnsWholeIm)
        sWidth = width - (maxColumnsWholeIm - minColumnsWholeIm);
    else
        sWidth = 1;
    end
    if (startRow < minRowsWholeIm)
        sHeight = height - (maxRowsWholeIm - minRowsWholeIm);
    else
        sHeight=1;
    end
    if (endColumn > maxColumnsWholeIm)
        eWidth = (maxColumnsWholeIm - minColumnsWholeIm)+1;
    else
        eWidth = width;
    end
    if (endRow > maxRowsWholeIm)
        eHeight = (maxRowsWholeIm - minRowsWholeIm)+1;
    else
        eHeight = height;
    end
%     
%     minRowsWholeIm
%     maxRowsWholeIm
%     minColumnsWholeIm
%     maxColumnsWholeIm
    
    
    
    partIm = wholeIm(minRowsWholeIm:maxRowsWholeIm,minColumnsWholeIm:maxColumnsWholeIm,:) ;
    avgChannels =  mean(mean(partIm,1)); % mean of R, G and B
    
    im = zeros(height, width,3);
    im(1:height, 1:width,:) = repmat(avgChannels,height,width);
    im(sHeight:eHeight,sWidth:eWidth,:) = partIm;
        
    
    
   % imshow(uint8(im));
   % pause(1);
    %im
    
    weightMaskIm =  getWeightMask(im) ;
    
	[imHeight,imWidth,imDim] = size(im);

    %return
    
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
    
 	for c = 1:imWidth
 		for r = 1:imHeight
 			pixelValue = imCells(r,c,:);
 			frequencies(pixelValue(1),pixelValue(2),pixelValue(3)) = ... 				 
                frequencies(pixelValue(1),pixelValue(2),pixelValue(3)) + ...
                weightMaskIm(r,c) * ...
                1;
            %col
            %row
            %weightMaskIm(r,c)
 		end
    end	

   % frequencies
     sumFrequencies = sum(sum(sum(frequencies)));
     frequencies = frequencies ./ sumFrequencies;
     histogram = frequencies;
end
