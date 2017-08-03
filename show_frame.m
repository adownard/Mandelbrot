function show_frame(frame)
    global mode magrect
    
    imagesc(frame);
    colormap([0 0 0; colormap(hot(numel(unique(frame(:)))-1))]);
    axis off;
    
    if strcmp(mode,'explore')
        magrect=imrect(gca, [0,0,0,0]);        
        show_magrect_and_location()
        set(gcf,'WindowButtonMotionFcn',@(obj,event) show_magrect_and_location());
        set(gcf,'WindowButtonDownFcn',@(obj,event) explore_click());        
    end