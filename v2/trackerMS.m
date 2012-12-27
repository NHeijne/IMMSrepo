function trackerMS() 

  
  %directory = '../../MoreFrames_part_1';
  directory = '../../TestFrames1/' ;
  files = dir(directory);
  nrFiles = size(files,1)-2; % Discard '.' and '..'
  
  im = imread([directory '/' files(3).name]);
  
  [imHeight,imWidth,imDim] = size(im)
  disp('Draw square and double-click');
  [xmin, ymin, width, height] = getTargetPos(im)
  x = xmin + round(width /2);
  y = ymin + round(height / 2);
  
  column = x;
  row = y;
  [imCellsTarget,histogramTarget] = weightedHist3D(column, row, width, height, im);
  
  
  
  im = imPlusDot(im,column,row);
  imshow (im);
  
  % output  
  x
  y
  width
  height
  
  smallestIncrement = 0.0001;
  
  for n = 4:nrFiles
    im = imread([directory '/' files(n).name]);	
     
    [xNew,yNew] = getNewPos(column,row,width,height,im,histogramTarget)
    
    
    xUpdated =  (xNew)+x;
    yUpdated =  (yNew)+y;
    
    %norm([xUpdated,yUpdated] - [x,y])
    
    if (norm([xUpdated,yUpdated] - [x,y]) >= smallestIncrement)
        x=round(xUpdated)
        y=round(yUpdated)
    else
        disp('NO UPDATE');
    end
    
    im = imPlusDot(im,x,y);
    imshow(im);
    pause(0.001);

  end

end