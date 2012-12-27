function bins = hist2d(im,n,scaleFactor)
%
% Input:
%  im:		    image matrix (3D).
%  n: 			Number of histogram bins within each axis.
%              	If undefined, the default number of bins is 8.
% scaleFactor:	How much to scale the smaller frequences (so that they can be seen in the graph)
%				value should be in [0, 1] !!! (0 = don't scale, 1 is highest scaling)
%				It works like <in [0,1] normalized frequency>^(1-scaleFactor)
%				If undefined, scaleFactor is 0.6.

	%% set default number of bins if that number is not provided
	if (nargin == 2)
		n = 8;		
	else if (nargin == 1)
		n = 8;
		scaleFactor = 0.6;
	end

	
	[imHeight,imWidth,imDim] = size(im);
	im = im2double(im); % convert to interval [0,1]

	%% discard B value
	im(:,:,3) = [];
	
	X = reshape(im, imHeight * imWidth, 2);
	bins = hist3(X,'Nbins',[n,n]) ;
	hist3(X,'Nbins',[n,n]);%'FaceAlpha',.65) ;
	
	set(gcf,'renderer','opengl');
	set(get(gca,'child'),'FaceColor',[0.9,0.9,0.9]);
	
	axis([ 0 1 0 1 0 max(max(bins))]);
	xlabel('R'); 
	ylabel('G');
	rotate3d on 
	view(-52,47)
	axis square
	
	bins = bins ./ max(max(max(bins)));
end
