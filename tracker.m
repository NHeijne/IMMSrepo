function tracker1(directory) 

  
  
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
  
  searchWindowHeight = objectHeight; % pixels
  searchWindowWidth = objectWidth;
  
  %% Find most similar new window position to the tracke dobjetc from previous 
  maxHistDistance = realmax;
  bestPosI = -1;
  bestPosJ = -1;
  for n = 4:size(files,1)
    im = imread([directory '/' files(n).name]);	
	
	for i = max(0, (min(x) - searchWindowWidth)) : min(imWidth, max(x) + searchWindowWidth)
		for j = max (0, min(y) - searchWindowHeight) : min(imHeight, max(y) + searchWindowHeight)
			
			possibleObject = im(j:min(j+objectHeight,imHeight), i:min(i+objectWidth,imWidth),:);
			
			dist = 0;%histDist(trackedObject, possibleObject); %% TODO
			
			if (dist <= maxHistDistance) 
				maxHistDistance = dist;
				bestPosI = i;
				bestPosJ = j;
			end
		end
	end
	maxHeight = min(imHeight, bestPosJ+objectHeight);
	maxWidth = min(imWidth, bestPosI+objectWidth);
	trackedObject = im(bestPosJ:maxHeight, bestPosI:maxWidth,:);
	
	bestPosJ
	bestPosI
	
	im(bestPosJ:maxHeight, bestPosI,:) = 0;
	im(bestPosJ,bestPosI:maxWidth,:) = 0;
	im(maxHeight,bestPosI:maxWidth,:) = 0;
	im(bestPosJ:maxHeight,maxWidth,:) = 0;
	imshow(im);
	pause(0.3);
  end

end