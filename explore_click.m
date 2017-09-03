function explore_click()
    global D center width magrect_frac resolution depth_levels log_colour computation_mode
    pixel_coords=get(gca,'CurrentPoint');
    pixel_coords=pixel_coords(1,[1 2]);
    if strcmp(computation_mode,'gpu')
        top_left=round(pixel_coords-magrect_frac*resolution/2);
        bottom_right=round(pixel_coords+magrect_frac*resolution/2);
        D_sub=D(top_left(2):bottom_right(2),top_left(1):bottom_right(1));
        if log_colour
            min_depth=min(exp(D_sub(:))-1)
        else
            min_depth=min(D_sub(:))
        end
    end
    center=convert_pixel_to_complex_coords(pixel_coords);    
    if strcmp(get(gcf,'SelectionType'),'normal')
        width=magrect_frac*width;
    elseif strcmp(get(gcf,'SelectionType'),'alt')
        width=width/magrect_frac;
    end
    D=generate_frame(width,center,resolution,depth_levels,log_colour,computation_mode,min_depth);
    %D=D*depth_levels/max(D(:))+1;
    show_frame(D);
end