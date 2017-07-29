function [frame,D]=generate_frame(center,width,resolution,depth_levels,log_colour)
    % get frame boundaries:    
    height=width*resolution(2)/resolution(1);
    left=real(center)-width/2;
    right=real(center)+width/2;
    top=imag(center)+height/2;
    bottom=imag(center)-height/2;

    % generate complex grid within frame:
    [X,Y]=meshgrid(left:(right-left)/(resolution(1)-1):right,top:-(top-bottom)/(resolution(2)-1):bottom); 
    C=X+1i*Y;

    % initiate arrays:
    D=zeros(size(C));    % depth array
    c=C(:)';            % (flattened) location array
    z=zeros(size(c));   % (flattened) value array
    I=1:numel(z);       % (flattened) index array   

    % evolve values:
    depth=0;
    while ~numel(min(D(D>0)))||(depth<min(D(D>0))+depth_levels)    
        z=z.^2+c;           % iterate function
        I_esc=abs(z)>2;     % logically index escaped values  
        D(I(I_esc))=depth;   % set depth of escaped values
        
        % remove escaped elements:
        I(I_esc)=[];
        z(I_esc)=[];
        c(I_esc)=[];
        
        depth=depth+1;
    end
    frame=D;
    if log_colour
        % logarithmic colour map
        frame=log(D);
        frame=frame*depth_levels/max(frame(:))+1;
    end
    