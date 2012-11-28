function frequencies = hist3d(im,n,scaleFactor)
%
% Input:
%  im:		image 
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
    im = RGB_rgb(im);
    %im2double only takes the intensity
% 	im = im2double(im)% convert to interval [0,1]

	%% assigning the pixels to the histogram cells
%    step = 255/n;
	step = 1/n;
 	imCells = ceil(im/step); % each pixel gets a number denoting cell
  	imCells(imCells==0) = 1; % cell_no can be computed as 0, so we assing them to the first cell
	% imshow(imCells/n);

	%% Computing the frequencies
	frequencies = zeros(n,n,n);  % initialization of vector, which will be used for saving the frequencies
%      m1 = zeros(size(im));
%      m2 = zeros(size(im));
%      m3 = zeros(size(im));
%      m1 = im(:,:,1) == 0;
%      m2 = im(:,:,2) == 0;
%      m3 = im(:,:,3) == 0;
%      frequencies(1, 1, 1) = length(find(m1(m2(m3 == 1) == 1) == 1));
%      for n1 = 1:n
%          R = step:step:255;
%          for n2 = 1:n
%              G = step:step:255;
%              for n3 = 1:n
%                  B = step:step:255;
%                  m1 = ((im(:,:,1) > R(n1)-step)+(im(:,:,1) <= R(n1)))== 2;
%                  m2 = ((im(:,:,2) > G(n2)-step)+(im(:,:,2) <= G(n2)))== 2;
%                  m3 = ((im(:,:,3) > B(n3)-step)+(im(:,:,3) <= B(n3)))== 2;
%                  frequencies(n1, n2, n3) = frequencies(n1, n2, n3) + length(find(m1(m2(m3 == 1) == 1) == 1));
%              end
%          end
%      end
    
 	for col = 1:imWidth
 		for row = 1:imHeight
 			pixelValue = imCells(row,col,:);
 			frequencies(pixelValue(1),pixelValue(2),pixelValue(3)) = ...
 				frequencies(pixelValue(1),pixelValue(2),pixelValue(3)) + 1;
 		end
 	end	


	
	
	%% Emphasizing small frequencies by scaleFactor	
% 	maxfreq = max(max(max(frequencies))); %maximum frequency			
% 	scaleFactor = 1 - scaleFactor;	
% 	freq_emph = frequencies / maxfreq;   %first, normalize to [0,1]
% 	freq_emph = freq_emph.^scaleFactor; %second, emphasize
% 	frequencies = freq_emph * maxfreq; %finally, un-normalize


	%% Drawing the histogram
	% figure 
	% maxradius = 1/n;
	% [Rss Gss Bss] = sphere(16); % mesh for unit sphere
	% % resizing the sphere to maximum
	% Rss = Rss * maxradius/2; 
	% Gss = Gss * maxradius/2;
	% Bss = Bss * maxradius/2;


	% loop over all histogram cells and plot the balls
	% for cnt_B = 1:n
		% for cnt_G = 1:n
			% for cnt_R = 1:n
				% RGBfreq = frequencies(cnt_R, cnt_G, cnt_B); %scalar
				% if (RGBfreq > 0) % if a sphere has to appear
					% % begin with the initial sphere
					% Rs = Rss;
					% Gs = Gss;
					% Bs = Bss;
					% % size of the sphere according to the frequency
					% ratio = RGBfreq / maxfreq;
					% Rs = Rs * ratio;
					% Gs = Gs * ratio;
					% Bs = Bs * ratio;
					% % translation the sphere to the right place
					% modR = mod(cnt_R-1,n);
					% modG = mod(cnt_G-1,n);
					% modB = mod(cnt_B-1,n);
					% Rs = Rs + (modR+0.5) * maxradius;
					% Gs = Gs + (modG+0.5) * maxradius;
					% Bs = Bs + (modB+0.5) * maxradius;
					% % drawing
					% h = surf(Rs,Gs,Bs);
					% % coloring the sphere by the color taken from the center of the respective cube
					% colorR =  ((modR+1)/n) * 255;
					% colorG =   ((modG+1)/n) * 255;
					% colorB =  ((modB+1)/n) * 255;
					% set(h,'EdgeColor','none', ...
						% 'FaceColor',[ colorR colorG colorB ]/255, ...
						% 'FaceLighting','phong', ...
						% 'AmbientStrength',0.7, ...
						% 'DiffuseStrength',0.4, ...
						% 'SpecularStrength',0.4, ...
						% 'SpecularExponent',500, ...
						% 'BackFaceLighting','reverselit');
					% hold on
					% hidden off
				% end
			% end
		% end
	% end


	% % visualization parameters
	% set(gcf, 'color', 'none');
	% set(gca, 'color', 'none');
	% axis([ 0 1 0 1 0 1]);
	% xlabel('R');
	% ylabel('G');
	% zlabel('B');
	% %camlight(-52,47);
	% rotate3d on 
	% view(-52,47)
	% axis square
	
	%frequencies = frequencies ./ maxfreq;
end
