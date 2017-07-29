function explore_click(magnifier_frac,depth_levels,max_depth,log_colour)
    global center width 
    coords=get(gca,'CurrentPoint');    
    center=convert_pixel_to_complex_coords(coords);
    width=magnifier_frac*width;
    show_frame(magnifier_frac,depth_levels,max_depth,log_colour)
end