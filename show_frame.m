function show_frame(frame)
    global resolution mode rect
    
    imagesc(frame);
    axis([0 resolution(1) 0 resolution(2)]); axis off;
    
    if mode==1
        rect=imrect(gca, [0,0,0,0]);
        show_mag_and_coords()
        set(gcf,'WindowButtonMotionFcn',@(obj,event) show_mag_and_coords());
        set(gcf,'WindowButtonDownFcn',@(obj,event) explore_click());
    end