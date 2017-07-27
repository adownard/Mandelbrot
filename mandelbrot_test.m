a=rand(800,600);
imagesc(a); colormap hot
set(gcf, 'WindowButtonMotionFcn', @(obj,event) show_zoom_rectangle(windowsize));
set(gcf, 'WindowButtonDownFcn', @(obj,event) click_position);