function show_frame(center,width,resolution,magnifier_frac,depth_levels,log_colour)
    frame=generate_frame(center,width,resolution,depth_levels,log_colour);       
    imagesc(frame);
    axis image; axis off;
    axis([0 resolution(1) 0 resolution(2)])
    magnifier_width=resolution(1)*magnifier_frac;
    magnifier_height=magnifier_width*resolution(2)/resolution(1);
    global rect;
    rect=imrect(gca, [0,0,0,0]);
    show_magnifier(magnifier_width,magnifier_height)
    set(gcf, 'WindowButtonMotionFcn', @(obj,event) show_magnifier(magnifier_width,magnifier_height));
    set(gcf, 'WindowButtonDownFcn', @(obj,event) explore_click(magnifier_frac,center,resolution,depth_levels,log_colour));