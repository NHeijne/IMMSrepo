function [xmin, ymin, width, height] = getTargetPos(frame)
    imshow(frame);
    h = imrect;
    position = wait(h);
    position = floor(position);
    %fprintf('position = %d, %d, %d, %d\n',position(1),position(2),position(3),position(4))
    xmin = position(1); ymin = position(2); width = position(3); height = position(4);
    %close all;
end