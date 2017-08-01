function show_mag_and_coords()
    global rect magnifier_size
    magnifier_width=magnifier_size(1);
    magnifier_height=magnifier_size(2); 
    
    coords=get(gca,'CurrentPoint');
    
    left=coords(1,1)-magnifier_width/2;
    top=coords(1,2)-magnifier_height/2;

    setPosition(rect,[left,top,magnifier_width,magnifier_height]);
    
    title(sprintf('%.15f+%.15fi',real(convert_pixel_to_complex_coords(coords)),imag(convert_pixel_to_complex_coords(coords))))
end