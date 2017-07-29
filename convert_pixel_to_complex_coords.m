function complex_coords=convert_pixel_to_complex_coords(pixel_coords)
    % convert pixel coords to complex plane coords:
    global center width resolution
    pixel_coords=[pixel_coords(1,1)-resolution(1)/2, resolution(2)/2-pixel_coords(1,2)]*width/resolution(1);
    complex_coords=center+pixel_coords(1,1)+pixel_coords(1,2)*1i;