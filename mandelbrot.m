% Mandelbrot set explorer
set(0,'DefaultFigureWindowStyle','normal');
set(0,'DefaultFigureMenu','none');
clear variables

global center width resolution

% overall parameters:
resolution=[800 600]; % in pixels
center=-0.74933+0.088102i;               % physical location of frame center
depth_levels=30; % adaptive number of depth levels
max_depth=200; % max # of iterations
log_colour=1; % logarithmic colour map
initial_width=10;                % initial frame width on complex plane
mode=2; %1: explore, 2: zoom

if mode==1
    % explore parameters:
    magnifier_frac=.1;   % window fraction of frame occupied by magnifying rectangle    

    width=initial_width;
    
    figure 
    colormap([0 0 0; colormap(hot(depth_levels-1))])
    set(gca,'LooseInset',get(gca,'TightInset'))    
    show_frame(magnifier_frac,depth_levels,max_depth,log_colour)  
    
elseif mode==2
    
    % zoom parameters:
    zoom_frac=.9; 
    n_zooms=10;
    
    frames=zeros([resolution(2) resolution(1) 1 n_zooms]);
    wb_h=waitbar(0,'Creating movie...');
    for zoom_iter=1:n_zooms        
        width=zoom_frac^(zoom_iter-1)*initial_width;    % zoom the frame-width
        waitbar(zoom_iter/n_zooms)    
        frame=generate_frame(depth_levels,max_depth,log_colour);
        frames(:,:,1,zoom_iter)=frame;     
    end
    movie_name='movie'; 
    movie=VideoWriter(movie_name,'Uncompressed AVI');
    open(movie);
    img=immovie(frames,[0 0 0; colormap(hot(depth_levels-1))]);
    writeVideo(movie,img);
    close(movie)
    close(wb_h)
end