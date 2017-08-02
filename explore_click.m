function explore_click()
    global center width magnifier_frac resolution depth_levels max_depth log_colour computation_mode
    coords=get(gca,'CurrentPoint');    
    center=convert_pixel_to_complex_coords(coords);
    width=magnifier_frac*width;
    show_frame(generate_frame(width,center,resolution,depth_levels,max_depth,log_colour,computation_mode))
end