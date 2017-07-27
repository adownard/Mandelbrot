% Mandelbrot set explorer
clear variables
tic

% input parameters:
resolution=[1920 1080]; % in pixels
center=-1.7400623825+0.0281753397i;               % physical location of frame center
max_depth=100;          % max # of iterations
width=10;                % initial frame width in physical units
n_zooms=500; 
zoom_frac=.99;
%imageStack=zeros(resolution(2),resolution(1));
imageStack=zeros([resolution(2) resolution(1) 1 n_zooms]);


% 
% %writerObj = VideoWriter('grid-cell-animation-zero-T','MPEG-4');
% movie.FrameRate=30;
% open(movie);
 
for zoom_iter=1:n_zooms
    zoom_iter
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
    D=zeros(size(C));   % depth array
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
        %fprintf('Depth: %d, surviving points: %d\n',[iter,numel(I)])
    end
    imageStack(:,:,1,zoom_iter)=D; 
    % plot Mandelbrot set:
    %set(gcf, 'visible', 'off');
%     imagesc(D); axis image; axis off; colormap hot;
%     frame = getframe(gcf);
%     close(gcf);
%     writeVideo(movie,frame);
%     drawnow
         
    width=zoom_frac*width;                % zoom width
end

movieName='movie'; 
movie=VideoWriter(movieName,'Motion JPEG AVI');
open(movie); 
imageStack=imageStack+1; 
img=immovie(imageStack,colormap(hot(max_depth+1)));
writeVideo(movie,img);
close(movie);
toc