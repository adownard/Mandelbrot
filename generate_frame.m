function frame=generate_frame()
    global center width resolution depth_levels max_depth log_colour
    
    % get frame boundaries:    
    height=width*resolution(2)/resolution(1);
    left=real(center)-width/2;
    right=real(center)+width/2;
    top=imag(center)+height/2;
    bottom=imag(center)-height/2;

    % generate complex grid within frame:
%     x = gpuArray.linspace( left, right, gridSize );
%     y = gpuArray.linspace( ylim(1), ylim(2), gridSize );
%     [xGrid,yGrid] = meshgrid( x, y );
%     z0 = complex( xGrid, yGrid );
    [X,Y]=meshgrid(linspace(left,right,resolution(1)),linspace(top,bottom,resolution(2))); 
    C=complex(X,Y);

    % initiate arrays:
    D=nan(size(C));    % depth array
    c=C(:)';            % (flattened) location array
    z=zeros(size(c));   % (flattened) value array
    I=1:numel(z);       % (flattened) index array   

    % evolve values:
    depth=0;
    while (depth<max_depth)&&(isnan(nanmin(D(:)))||(depth<nanmin(D(:))+depth_levels))    
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
        frame=log(D+1);
        frame=frame*depth_levels/max(frame(:))+1;
    end
    