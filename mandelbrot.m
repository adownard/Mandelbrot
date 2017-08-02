% Mandelbrot set explorer
set(0,'DefaultFigureWindowStyle','normal');
set(0,'DefaultFigureMenu','none');
clear variables

global center width resolution depth_levels max_depth cmap log_colour mode computation_mode magnifier_frac magnifier_size

% overall parameters:
resolution=[1920 1080]; % in pixels
center=-0.840018751752609 + 0.224304941676980i;               % physical location of frame center
depth_levels=200; % adaptive number of depth levels
max_depth=200; % max # of iterations
log_colour=1; % logarithmic colour map
initial_width=10;                % initial frame width on complex plane
mode='movie'; % 'explore' or 'movie'
computation_mode='cpu'; % 'cpu' or 'gpu'
magnifier_frac=.1;   % frame fraction occupied by magnifying rectangle

figure('Position',[0 0 resolution(1) resolution(2)])
set(gca,'position',[0 0 1 1]);
cmap=colormap([0 0 0; colormap(hot(depth_levels-1))]);

if strcmp(mode,'explore')
    magnifier_size=magnifier_frac*resolution;
    width=initial_width;
    show_frame(generate_frame(width,center,resolution,depth_levels,max_depth,log_colour,computation_mode))  
    
elseif strcmp(mode,'movie')
    set(gcf, 'visible', 'off');
    % zoom parameters:
    zoom_frac=10^(-15/1800); 
    n_zooms=50;
    

    %wb_h=waitbar(0,'Creating movie...');
    v=VideoWriter('movie','MPEG-4');
    v.FrameRate=30;
    open(v);
    tic    
    parfor zoom_iter=1:n_zooms
        zoom_iter
        frames(zoom_iter)=im2frame(mat2im(generate_frame(zoom_frac^(zoom_iter-1)*initial_width,center,resolution,depth_levels,max_depth,log_colour,computation_mode),cmap));     
    end
    writeVideo(v,frames)
    close(v);
    toc
    %close(wb_h)
end