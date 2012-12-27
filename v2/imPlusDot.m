function im = imPlusDot(im, x,y)

  colorO = [1,1,1];
  colorI = [255,1,1];
  colorO = reshape(colorO,1,1,3);
  colorI = reshape(colorI,1,1,3);

  dotInterval=3;
  colorMO = repmat(colorO,dotInterval*2+1,dotInterval*2+1);
  colorMI = repmat(colorI,dotInterval*2-1,dotInterval*2-1);
  im(y-dotInterval:y+dotInterval,x-dotInterval:x+dotInterval,:) = colorMO;
  im(y-dotInterval+1:y+dotInterval-1,x-dotInterval+1:x+dotInterval-1,:) = colorMI;
  
end