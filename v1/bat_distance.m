function D = bat_distance (hist1, hist2)

    hist1 = reshape(hist1, 1, []); % make vector of the matrix
    hist2 = reshape(hist2, 1, []);
    
%     zeros1 = hist1 == 0;
%     hist1(zeros1) = realmin;
%     zeros2 = hist2 == 0;
%     hist2(zeros2) = realmin;
    
    BC = sum(sqrt(hist1 .* hist2));
    D = sqrt(1 - BC);


end