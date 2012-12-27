function [distance, tElapsed] = trackerMS(x_, y_, width_, height_, cmodel_) 

  
 % directory = '../../AllFrames/';
  directory =  '../../MoreFrames_part_1/';
  files = dir(directory);
  nrFiles = size(files,1)-2; % Discard '.' and '..'
  
  im = imread([directory '/' files(3).name]);

  xmin= 0; 
  ymin= 0; 
  width= 0; 
  height= 0;
  cmodel= 1;
  
  [imHeight,imWidth,imDim] = size(im)
 
  if nargin == 0
       disp('Draw square and double-click');
      [xmin, ymin, width, height] = getTargetPos(im);
  else if nargin > 4
      xmin = x_;
      ymin = y_;
      width = width_;
      height = height_;      
  end
  
  if nargin == 5
      cmodel = cmodel_;
  end
  x = xmin + round(width /2);
  y = ymin + round(height / 2);
  
  if cmodel == 2
       im = RGB_rgb(im); 
       im = uint8(im.*255);
  end

  [imCellsTarget,histogramTarget] = weightedHist3D(x, y, width, height, im);
  
  
  
  im = imPlusDot(im,x,y);
  imshow (im);
  pause(0.5);
  
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
    
    if cmodel == 2
       im = RGB_rgb(im);
       im = uint8(im.*255);
    end
    
    tStart = tic;
    
    [xNew,yNew] = getNewPos(x,y,width,height,im,histogramTarget);
    
    xOld = x;
    yOld = y;
    
    xUpdated =  (xNew)+x;
    yUpdated =  (yNew)+y;
    
    x=round(xUpdated);
    y=round(yUpdated);
    
    counter = 1;
    limit = 10;
    
    while norm([xOld,yOld] - [x,y]) >= smallestIncrement && counter < limit
    
        [xNew,yNew] = getNewPos(x,y,width,height,im,histogramTarget);

        xOld = x;
        yOld = y;

        [temp,histogramCandidate1] = weightedHist3D(x, y, width, height, im);

        x = round(x + (xNew /2));
        y = round(y + (yNew /2));

        [temp,histogramCandidate2] = weightedHist3D(x, y, width, height, im);
        distance(n-3) = bat_distance(histogramCandidate2, histogramTarget);
        
        while bat_distance(histogramCandidate1, histogramTarget) < bat_distance(histogramCandidate2, histogramTarget)
            x = round((x + xOld) /2);
            y = round((y + yOld) /2);

            [temp,histogramCandidate2] = weightedHist3D(x, y, width, height, im);
            distance(n-3) = bat_distance(histogramCandidate2, histogramTarget);
        end

    counter = counter +1;
    end
    
    im = imPlusDot(im,x,y);
    imshow(im);
    tElapsed(n-3) = toc(tStart);
    pause(0.001);
  end
    distance = distance';
    tElapsed = tElapsed';
end