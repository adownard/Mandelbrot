function [frame,D]=generate_frame(center,width,resolution,max_depth)
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
    D=ones(size(C));    % depth array
    c=C(:)';            % (flattened) location array
    z=zeros(size(c));   % (flattened) value array
    I=1:numel(z);       % (flattened) index array   

    % evolve values:
    for iter=1:max_depth    
        z=z.^2+c;           % iterate function
        I_esc=abs(z)>2;     % logically index escaped values  
        D(I(I_esc))=iter;   % set depth of escaped values
        
        % remove escaped elements:
        I(I_esc)=[];
        z(I_esc)=[];
        c(I_esc)=[];        
    end
    
    % logarithmic colour map
    frame=log(D);
    frame=frame*max_depth/max(frame(:))+1;