function show_frame(magnifier_frac,depth_levels,max_depth,log_colour)
    global resolution rect
    frame=generate_frame(depth_levels,max_depth,log_colour);       
    imagesc(frame);
    axis image; axis off;
    axis([0 resolution(1) 0 resolution(2)])
    magnifier_width=resolution(1)*magnifier_frac;
    magnifier_height=magnifier_width*resolution(2)/resolution(1);
    rect=imrect(gca, [0,0,0,0]);
    show_mag_and_coords(magnifier_width,magnifier_height)
    set(gcf, 'WindowButtonMotionFcn', @(obj,event) show_mag_and_coords(magnifier_width,magnifier_height));
    set(gcf, 'WindowButtonDownFcn', @(obj,event) explore_click(magnifier_frac,depth_levels,max_depth,log_colour));
    colorbar