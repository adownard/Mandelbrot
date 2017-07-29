% Mandelbrot set explorer
set(0,'DefaultFigureWindowStyle','normal');
set(0,'DefaultFigureMenu','none');
clear variables

% overall parameters:
resolution=[800 600]; % in pixels
center=0;               % physical location of frame center
depth_levels=200;                          % max # of iterations
log_colour=1; % logarithmic colour map
initial_width=10;                % initial frame width on complex plane
mode=1; %1: explore, 2: zoom

if mode==1
    % explore parameters:
    magnifier_frac=.2;   % window fraction of frame occupied by magnifying rectangle
    
    global width;
    width=initial_width;
    
    figure 
    colormap([0 0 0; colormap(hot(depth_levels-1))])
    set(gca,'LooseInset',get(gca,'TightInset'))    
    show_frame(center,width,resolution,magnifier_frac,depth_levels,log_colour)  
    
elseif mode==2
    
    % zoom parameters:
    zoom_frac=.99; 
    n_zooms=10;
    
    frames=zeros([resolution(2) resolution(1) 1 n_zooms]);
    for zoom_iter=1:n_zooms
        width=zoom_frac^(zoom_iter-1)*initial_width;    % zoom the frame-width
        disp(zoom_iter)    
        frame=generate_frame(center,width,resolution,depth_levels,log_colour);
        frames(:,:,1,zoom_iter)=frame;     
    end
    movie_name='movie'; 
    movie=VideoWriter(movie_name,'Uncompressed AVI');
    open(movie);
    img=immovie(frames,[0 0 0; colormap(hot(depth_levels-1))]);
    writeVideo(movie,img);
    close(movie);
end