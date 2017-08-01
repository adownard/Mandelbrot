function show_frame(frame)
    global depth_levels mode rect
    
    imagesc(frame);
    colormap([0 0 0; colormap(hot(depth_levels-1))])
    %axis image; axis([0 resolution(1) 0 resolution(2)]);
    axis off;
    
    if strcmp(mode,'explore')
        rect=imrect(gca, [0,0,0,0]);
        show_mag_and_coords()
        set(gcf,'WindowButtonMotionFcn',@(obj,event) show_mag_and_coords());
        set(gcf,'WindowButtonDownFcn',@(obj,event) explore_click());
    end