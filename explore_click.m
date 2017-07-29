function explore_click(magnifier_frac,center,resolution,depth_levels,log_colour)
    global width;    
    coords=get(gca,'CurrentPoint');    
    % convert pixel coords to complex plane coords:
    coords=[coords(1,1)-resolution(1)/2, resolution(2)/2-coords(1,2)]*width/resolution(1);
    new_center=center+coords(1,1)+coords(1,2)*1i;
    width=magnifier_frac*width;
    show_frame(new_center,width,resolution,magnifier_frac,depth_levels,log_colour)
end