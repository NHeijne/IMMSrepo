function trackerMS() 

  
  directory = '../MoreFrames_part_1/part_1';
  files = dir(directory);
  nrFiles = size(files,1)-2; % Discard '.' and '..'
  
  im = imread([directory '/' files(3).name]);
  
  [imHeight,imWidth,imDim] = size(im)
  disp('Draw square and double-click');
  [xmin, ymin, width, height] = getTargetPos(im)
  x = xmin + round(width /2)
  y = ymin + round(height / 2)
  
  im = imPlusDot(im,x,y);
  imshow (im);
  
  [imCellsTarget,histogramTarget] = weightedHist3D(x, y, width, height, im);
  
  x
  y
  width
  height
  for n = 4:nrFiles
    im = imread([directory '/' files(n).name]);	
     
    [xNew,yNew] = getNewPos(x,y,width,height,im,histogramTarget)
    x =  (xNew)+x
    y =  (yNew)+y
    
    x=round(x)
    y=round(y)
    
    im = imPlusDot(im,x,y);
    imshow(im);
    pause(0.001);
% 	im(bestPosJ:maxHeight, bestPosI,:) = 0;
% 	im(bestPosJ,bestPosI:maxWidth,:) = 0;
% 	im(maxHeight,bestPosI:maxWidth,:) = 0;
% 	im(bestPosJ:maxHeight,maxWidth,:) = 0;
%  	imshow(im);
%  	pause(0.001);
  end

end