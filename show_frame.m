function show_frame(frame)
    global cmap mode rect
    
    imagesc(frame);
    colormap([0 0 0; colormap(hot(numel(unique(frame(:)))-1))]);
    axis off;
    
    if strcmp(mode,'explore')
        rect=imrect(gca, [0,0,0,0]);
        show_mag_and_coords()
        set(gcf,'WindowButtonMotionFcn',@(obj,event) show_mag_and_coords());
        set(gcf,'WindowButtonDownFcn',@(obj,event) explore_click());
    end