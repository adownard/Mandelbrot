function show_mag_and_coords(magnifier_width,magnifier_height)
    global rect
        
    coords=get(gca,'CurrentPoint');
    left=coords(1,1)-magnifier_width/2;
    top=coords(1,2)-magnifier_height/2;

    setPosition(rect,[left,top,magnifier_width,magnifier_height]);
    
    title(sprintf('%.6f+%.6fi',real(convert_pixel_to_complex_coords(coords)),imag(convert_pixel_to_complex_coords(coords))))
end