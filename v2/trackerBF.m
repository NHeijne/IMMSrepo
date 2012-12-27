function [distance, tElapsed] =  trackerBF(x_, y_, width_, height_, cmodel_) 

  
  directory =  '../../MoreFrames_part_1/';
  files = dir(directory);
  nrFiles = size(files,1)-2; % Discard '.' and '..'
  
  im = imread([directory '/' files(3).name]);
  [imHeight,imWidth,imDim] = size(im)
  imshow(im);
  
  xmin= 0; 
  ymin= 0; 
  width= 0; 
  height= 0;
  cmodel= 1;
  
  if (nargin == 0)
      disp('Draw square and double-click');
      [xmin, ymin, width, height] = getTargetPos(im);
  else
      xmin = x_;
      ymin = y_;
      width = width_;
      height = height_;
  end
  
   if nargin == 5
      cmodel = cmodel_;
   end
   if cmodel == 2
       im = RGB_rgb(im); 
       im = uint8(im.*255);
   end
  
  x = xmin + round(width /2);
  y = ymin + round(height / 2);
  objectHeight = height;
  objectWidth = width;
  trackedObject = im(ymin:ymin+height,xmin:xmin+width,:);
  

  [imCellsTarget,targetHist] = weightedHist3D(x, y, width, height, im);
  
  
  searchWindowHeight = round(objectHeight/2); % pixels
  searchWindowWidth = round(objectWidth/2);
  
  
  
  im = imPlusDot(im,x,y);
  imshow(im);
  
  
  interval=1;

  %% Find most similar new window position to the tracked object from previous   
  bestPosI = min(x);
  bestPosJ = min(y);
  
  tic;
  tElapsed = zeros(length(nrFiles)-3);
  distance = zeros(length(nrFiles)-3);
  
  for n = 4:nrFiles
      
    tStart = tic;
       
    im = imread([directory '/' files(n).name]);	
    if cmodel == 2
       im = RGB_rgb(im);
       im = uint8(im.*255);
    end
    maxHistDistance = realmax;
	
    
    for i = max(1, (bestPosI - searchWindowWidth)) : interval : min(imWidth, bestPosI + searchWindowWidth) % xmin
		for j = max (1, bestPosJ - searchWindowHeight) : interval : min(imHeight, bestPosJ + searchWindowHeight) % ymin
			
             x = i + round(width /2);
             y = j + round(height / 2);
            [imCellsTarget,trackedHist] = weightedHist3D(x, y, width, height, im);
                        
            dist = bat_distance(targetHist, trackedHist);
            distance(n-3) = dist;
            
 			if (dist <= maxHistDistance) 
 				maxHistDistance = dist;
                bestPosI = i;
				bestPosJ = j;                
			end
		end
    end
    
    tElapsed(n-3) = toc(tStart);
    	
    n
	bestPosJ
	bestPosI
	
    
    % showen
    maxHeight = min(imHeight, bestPosJ+objectHeight);
    maxWidth = min(imWidth, bestPosI+objectWidth);
    
    im(bestPosJ:maxHeight, bestPosI,:) = 0;
	im(bestPosJ,bestPosI:maxWidth,:) = 0;
	im(maxHeight,bestPosI:maxWidth,:) = 0;
	im(bestPosJ:maxHeight,maxWidth,:) = 0;
    
	x = bestPosI + round(width /2);
    y = bestPosJ + round(height / 2);      
	im = imPlusDot(im,x,y);
 	imshow(im);
 	pause(0.001);
    
  end
  
   distance = distance';
   tElapsed = tElapsed';

end