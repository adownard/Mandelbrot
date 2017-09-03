function D=generate_frame(width,center,resolution,depth_levels,log_colour,computation_mode,min_depth)
    % variable precision
    if log10(width)<-11
        if log10(width)>-33
            mp.Digits(34) % optimized quad precision
        else
            mp.Digits(ceil(abs(log10(width)))+3) % truly variable precision
        end
        center=mp(center);
        width=mp(width);
    end
    % get frame boundaries in complex plane:    
    height=width*resolution(2)/resolution(1);
    left=real(center)-width/2;
    right=real(center)+width/2;
    top=imag(center)+height/2;
    bottom=imag(center)-height/2;
    
    if strcmp(computation_mode,'cpu')
        % generate complex grid within frame:        
        [X,Y]=meshgrid(linspace(left,right,resolution(1)),linspace(top,bottom,resolution(2))); 
        %[X,Y]=meshgrid(linspace(mp(left),mp(right),resolution(1)),linspace(mp(top),mp(bottom),resolution(2))); 
        C=complex(X,Y);

        % initiate arrays:
        D=nan(size(C));    % depth array
        c=C(:)';            % (flattened) location array
        z=zeros(size(c));   % (flattened) value array
        I=1:numel(z);       % (flattened) index array   

        % evolve values:
        depth=0;
        while (isnan(nanmin(D(:)))||(depth<nanmin(D(:))+depth_levels))    
            z=z.^2+c;           % iterate function
            I_esc=abs(z)>2;     % logically index escaped values  
            D(I(I_esc))=depth;   % set depth of escaped values

            % remove escaped elements:
            I(I_esc)=[];
            z(I_esc)=[];
            c(I_esc)=[];

            depth=depth+1;
        end
        
        if log_colour
            % logarithmic colour map        
            D=log(D+1);            
        end        
    elseif strcmp(computation_mode,'gpu')
        x=gpuArray.linspace(left,right,resolution(1));
        y = gpuArray.linspace(top,bottom,resolution(2));
        [X,Y] = meshgrid(x,y);
        
        D=arrayfun(@pctdemo_processMandelbrotElement,X,Y,min_depth+depth_levels,log_colour);
        D=gather(D); % Fetch the data back from the GPU
    end
    D(isnan(D))=nanmin(D(:)); % to make adaptive colour levels work
    