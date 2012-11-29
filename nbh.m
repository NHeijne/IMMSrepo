function nbh_matrix = nbh(image, i, j, N)
% get the 2N + 1 pixels large neighborhoud of the 
% pixel i, j (a square)
% i = vertical position

    [iMax, jMax, dim] = size(image);
    iIndex = i + (-N : N);
    jIndex = j + (-N : N);
    iIndex  = max( min( iIndex, iMax), 1);
    jIndex  = max( min( jIndex, jMax), 1);
    
    nbh_matrix = image(iIndex, jIndex, :);
    
    
end