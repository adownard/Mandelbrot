function show_magrect_and_location()
    global magrect magrect_size location
    magrect_width=magrect_size(1);
    magrect_height=magrect_size(2); 
    
    coords=get(gca,'CurrentPoint');
    
    left=coords(1,1)-magrect_width/2;
    top=coords(1,2)-magrect_height/2;

    setPosition(magrect,[left,top,magrect_width,magrect_height]);    
    location=convert_pixel_to_complex_coords(coords);
end