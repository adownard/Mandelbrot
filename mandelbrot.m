% Mandelbrot set explorer
set(0,'DefaultFigureWindowStyle','normal');
set(0,'DefaultFigureMenu','none');
clear variables

global center location width resolution depth_levels max_depth cmap log_colour mode computation_mode magrect_frac magrect_size

% overall parameters:
resolution=[600 600]; % in pixels
center=0;%-0.840018751752609 + 0.224304941676980i;               % physical location of frame center
location=center;
depth_levels=10; % adaptive number of depth levels
max_depth=200; % max # of iterations
log_colour=1; % logarithmic colour map
initial_width=6;                % initial frame width on complex plane
mode='explore'; % 'explore' or 'movie'
computation_mode='cpu'; % 'cpu' or 'gpu'
magrect_frac=.1;   % frame fraction occupied by magnifying rectangle

figure('Position',[0 0 resolution(1) resolution(2)],'Pointer','crosshair')
set(gca,'position',[0 0 1 1]);
%global location



if strcmp(mode,'explore')
    magrect_size=magrect_frac*resolution;
    width=initial_width;
    show_frame(generate_frame(width,center,resolution,depth_levels,max_depth,log_colour,computation_mode))  
    
elseif strcmp(mode,'movie')
    set(gcf, 'visible', 'off');
    % zoom parameters:
    zoom_frac=10^(-15/1800); 
    n_zooms=50;
    
    frames_written=0;    
    v=VideoWriter('movie','MPEG-4');
    v.FrameRate=30;
    open(v);
    wb_h=waitbar(0,'Creating movie...');
    tic    
    parfor zoom_iter=1:n_zooms
        %zoom_iter
        frames(zoom_iter)=im2frame(mat2im(generate_frame(zoom_frac^(zoom_iter-1)*initial_width,center,resolution,depth_levels,max_depth,log_colour,computation_mode),cmap));
        frames_written=frames_written+1
        %disp(frames_written)
        %waitbar(frames_written/n_zooms)
    end
    toc
    writeVideo(v,frames)
    close(v);    
    close(wb_h)
end