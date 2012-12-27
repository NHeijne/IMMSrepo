function trackerMS() 

  
  directory = '../../MoreFrames_part_1';
  files = dir(directory);
  nrFiles = size(files,1)-2; % Discard '.' and '..'
  
  im = imread([directory '/' files(3).name]);
  
  [imHeight,imWidth,imDim] = size(im)
  disp('Draw square and double-click');
  [xmin, ymin, width, height] = getTargetPos(im)
  x = xmin + round(width /2)
  y = ymin + round(height / 2)
  
  
  [imCellsTarget,histogramTarget] = weightedHist3D(y,x, width, height, im);
  
  im = imPlusDot(im,x,y);
  imshow (im);
  
  % output  
  x
  y
  width
  height
  
  for n = 4:nrFiles
    im = imread([directory '/' files(n).name]);	
     
    [xNew,yNew] = getNewPos(y,x,width,height,im,histogramTarget)
    x =  (xNew)+x;
    y =  (yNew)+y;
    
    x=round(x)
    y=round(y)
    
    im = imPlusDot(im,x,y);
    imshow(im);
    pause(0.001);

  end

end