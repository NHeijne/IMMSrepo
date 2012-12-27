function tracker1(directory) 

  
  % dir = e.g. '../MoreFrames_part_1/part_1'
  files = dir(directory);
  nrFiles = size(files,1)-2; % Discard '.' and '..'
  
  im = imread([directory '/' files(3).name]);
  [imHeight,imWidth,imDim] = size(im)
  imshow(im);
  disp('Give upper left and lower right point of to-be-tracked square');
  [x,y]=ginput(2);
  objectHeight = max(y)-min(y);
  objectWidth = max(x)-min(x);
  
  trackedObject = im(min(y):max(y), min(x):max(x),:);
  %imshow(trackedObject);
  trackedHist = hist3d(trackedObject); 
  sumhist = sum(sum(sum(trackedHist)));
  normtrackedHist = trackedHist ./ sumhist; % frequencies normalized between 0 and 1
  searchWindowHeight = round(objectHeight/2); % pixels
  searchWindowWidth = round(objectWidth/2);
  
  interval=5;
  updateObject = 0;
  %% Find most similar new window position to the tracked object from previous   
  bestPosI = min(x);
  bestPosJ = min(y);
  for n = 4:nrFiles
    im = imread([directory '/' files(n).name]);	
    maxHistDistance = realmax;
	bestObject = zeros(objectHeight, objectWidth);
    
    for i = max(1, (bestPosI - searchWindowWidth)) : interval : min(imWidth, bestPosI + searchWindowWidth)
		for j = max (1, bestPosJ - searchWindowHeight) : interval : min(imHeight, bestPosJ + searchWindowHeight)
			
            maxHeightObject = min(j+objectHeight,imHeight);
            maxWidthObject = min(i+objectWidth,imWidth);
			possibleObject = im(j:maxHeightObject, i:maxWidthObject,:);
            fillEmptyValue = 0;
            % set pixels outside of image to be 'fillEmptyValue'
            possibleObject(maxHeightObject+1:objectHeight, maxWidthObject+1:objectWidth) = fillEmptyValue;
                        
            trackedHist = hist3d(possibleObject);
            sumhist = sum(sum(sum(trackedHist)));
            normtrackedHist2 = trackedHist ./ sumhist;
            
            dist = bat_distance(normtrackedHist, normtrackedHist2);
            			
 			if (dist <= maxHistDistance) 
 				maxHistDistance = dist;
                bestPosI = i;
				bestPosJ = j;
                bestObject = possibleObject;
			end
		end
    end
    	
    n
	bestPosJ
	bestPosI
	
    
	
	maxHeight = min(imHeight, bestPosJ+objectHeight);
    maxWidth = min(imWidth, bestPosI+objectWidth);
    % update target object
    if (updateObject == 1)

%         trackedObject = im(bestPosJ:maxHeight, bestPosI:maxWidth,:);
%         fillEmptyValue = 0;
%         % set pixels outside of image to be 'fillEmptyValue'
%         trackedObject(maxHeight+1:objectHeight, maxWidth+1:objectWidth) = fillEmptyValue;
       
        trackedObject = bestObject;
        trackedHist = hist3d(trackedObject); % frequencies normalized between 0 and 1
        sumhist = sum(sum(sum(trackedHist)));
        normtrackedHist = trackedHist ./ sumhist;
        imshow(bestObject);
        pause(1);
        
    end
    
	im(bestPosJ:maxHeight, bestPosI,:) = 0;
	im(bestPosJ,bestPosI:maxWidth,:) = 0;
	im(maxHeight,bestPosI:maxWidth,:) = 0;
	im(bestPosJ:maxHeight,maxWidth,:) = 0;
 	imshow(im);
 	pause(0.001);
  end

end