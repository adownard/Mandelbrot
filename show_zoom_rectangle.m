function show_zoom_rectangle(window_size)
  persistent rect line1;      
  C=get(gca,'CurrentPoint');
  topLeftCornerX = round(C(1,1)) - window_size/2;
  topLeftCornerY = round(C(1,2)) - window_size/2;
  width = window_size;
  height = window_size;
  if ~isempty(rect) && rect.isvalid
     delete(rect);
  end
  rect = imrect(gca, [topLeftCornerX, topLeftCornerY, width, height]);
  setColor(rect, 'white');
  
  line1=line([0 C(1,1)],[0,C(1,2)]);
end