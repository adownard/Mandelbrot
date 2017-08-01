% Mandelbrot set explorer
set(0,'DefaultFigureWindowStyle','normal');
set(0,'DefaultFigureMenu','none');
clear variables

global center width resolution depth_levels max_depth log_colour mode magnifier_frac magnifier_size

% overall parameters:
resolution=[1920 1080]; % in pixels
center=-0.840018751752609 + 0.224304941676980i;               % physical location of frame center
depth_levels=50; % adaptive number of depth levels
max_depth=200; % max # of iterations
log_colour=1; % logarithmic colour map
initial_width=10;                % initial frame width on complex plane
mode=2; %1: explore, 2: zoom
magnifier_frac=.1;   % frame fraction occupied by magnifying rectangle

figure('Position',[0 0 resolution(1) resolution(2)])
set(gca,'position',[0 0 1 1]);
set(gcf, 'visible', 'off');

if mode==1
    magnifier_size=magnifier_frac*resolution;
    width=initial_width;
    show_frame(generate_frame())  
    
elseif mode==2    
    % zoom parameters:
    zoom_frac=10^(-15/1800); 
    n_zooms=30;
    
    frames=zeros([resolution(2) resolution(1) 1 n_zooms]);
    %wb_h=waitbar(0,'Creating movie...');
    writerObj = VideoWriter('movie','MPEG-4');
    writerObj.FrameRate=30;
    open(writerObj);
    tic
    for zoom_iter=1:n_zooms
        zoom_iter
        width=zoom_frac^(zoom_iter-1)*initial_width;    % zoom the frame-width           
        show_frame(generate_frame())
        drawnow
        frame = getframe(gcf);
        %close(gcf);
        writeVideo(writerObj,frame);
        %frames(:,:,1,zoom_iter)=frame;     
    end
    close(writerObj);
    toc
%     movie_name='movie'; 
%     movie=VideoWriter(movie_name,'Uncompressed AVI');
%     open(movie);
%     img=immovie(frames,[0 0 0; colormap(hot(depth_levels-1))]);
%     writeVideo(movie,img);
%     close(movie)
    %close(wb_h)
end