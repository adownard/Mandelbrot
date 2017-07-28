function show_magnifier(magnifier_width,magnifier_height)
    global rect;
        
    coords=get(gca,'CurrentPoint');
    left=coords(1,1)-magnifier_width/2;
    top=coords(1,2)-magnifier_height/2;

    setPosition(rect,[left,top,magnifier_width,magnifier_height]);
    %setColor(rect, 'white');
end