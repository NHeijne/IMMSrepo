function trackerMS() 

  
  directory = '../../MoreFrames_part_1/';
  %directory = '../../TestFrames1/' ;
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
  
  smallestIncrement = 0.2;
  
  tic;
  tElapsed = zeros(length(nrFiles)-3);
  distance = zeros(length(nrFiles)-3);
  for n = 4:nrFiles
    im = imread([directory '/' files(n).name]);	
    
    tStart = tic;
    
    [xNew,yNew] = getNewPos(x,y,width,height,im,histogramTarget);
    
    xUpdated =  (xNew)+x;
    yUpdated =  (yNew)+y;
    
    x=round(xUpdated);
    y=round(yUpdated);
    
    counter = 1;
    limit = 5;
    
    while norm([xUpdated,yUpdated] - [x,y]) >= smallestIncrement && counter < limit
    
    [xNew,yNew] = getNewPos(x,y,width,height,im,histogramTarget);
    
    if counter < limit -1
        xUpdated =  (xNew)+x;
        yUpdated =  (yNew)+y;
    
        x=round(xUpdated);
        y=round(yUpdated);
    else
        x = round(x + (xNew /2));
        y = round(y + (yNew /2));
    end
    %norm([xUpdated,yUpdated] - [x,y])
    
%     if (norm([xUpdated,yUpdated] - [x,y]) >= smallestIncrement)
%         x=round(xUpdated)
%         y=round(yUpdated)
%     else
%         disp('NO UPDATE');
    counter = counter +1;
    end
%     disp('NO UPDATE');
    
    im = imPlusDot(im,x,y);
    imshow(im);
    tElapsed(n-3) = toc(tStart);
    pause(0.001);
    [imCellsC,histogramCandidate] = weightedHist3D(x, y, width, height, im);
    distance(n-3) = bat_distance(histogramCandidate, histogramTarget);
  end
    distance'
    averageDistance = sum(distance')/length(distance)
    tElapsed'
    averageTime = sum(tElapsed')/length(tElapsed)
end