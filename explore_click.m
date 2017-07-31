function explore_click()
    global center width magnifier_frac
    coords=get(gca,'CurrentPoint');    
    center=convert_pixel_to_complex_coords(coords);
    width=magnifier_frac*width;
    show_frame(generate_frame())
end