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
  trackedHist = hist3d(trackedObject); % frequencies normalized between 0 and 1
  sumhist = sum(sum(sum(trackedHist)));
  normtrackedHist = trackedHist ./ sumhist;
  searchWindowHeight = round(objectHeight/2); % pixels
  searchWindowWidth = round(objectWidth/2);
  
  %% Find most similar new window position to the tracke dobjetc from previous 
  
  bestPosI = -1;
  bestPosJ = -1;
  for n = 4:size(files,1)
    im = imread([directory '/' files(n).name]);	
    maxHistDistance = realmax;
	
	for i = max(1, (min(x) - searchWindowWidth)) : 5 : min(imWidth, max(x) + searchWindowWidth)
		for j = max (1, min(y) - searchWindowHeight) : 5 : min(imHeight, max(y) + searchWindowHeight)
			
			possibleObject = im(j:min(j+objectHeight,imHeight), i:min(i+objectWidth,imWidth),:);
			
            trackedHist = hist3d(possibleObject);
            sumhist = sum(sum(sum(trackedHist)));
            normtrackedHist2 = trackedHist ./ sumhist;
            
            dist = bat_distance(normtrackedHist, normtrackedHist2);
            			
 			if (dist <= maxHistDistance) 
 				maxHistDistance = dist;
                bestPosI = i;
				bestPosJ = j;
			end
		end
    end
    	
    n
	bestPosJ
	bestPosI
	
    
	maxHeight = min(imHeight, bestPosJ+objectHeight);
	maxWidth = min(imWidth, bestPosI+objectWidth);
	trackedObject = im(bestPosJ:maxHeight, bestPosI:maxWidth,:);
    trackedHist = hist3d(trackedObject); % frequencies normalized between 0 and 1
    sumhist = sum(sum(sum(trackedHist)));
    normtrackedHist = trackedHist ./ sumhist;
    
	im(bestPosJ:maxHeight, bestPosI,:) = 0;
	im(bestPosJ,bestPosI:maxWidth,:) = 0;
	im(maxHeight,bestPosI:maxWidth,:) = 0;
	im(bestPosJ:maxHeight,maxWidth,:) = 0;
	imshow(im);
	pause(0.3);
  end

end