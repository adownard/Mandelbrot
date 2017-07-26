% Mandelbrot set explorer
clear variables
tic

% input parameters:
resolution=[1920 1080]; % in pixels
center=0;               % physical location of frame center
width=4;                % frame width in physical units
max_depth=100;          % max # of iterations

% get frame boundaries:
height=width*resolution(2)/resolution(1);
left=real(center)-width/2;
right=real(center)+width/2;
top=imag(center)+height/2;
bottom=imag(center)-height/2;

% generate complex grid coordinates:
[X,Y]=meshgrid(left:width/(resolution(1)-1):right,top:-height/(resolution(2)-1):bottom); 
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
    fprintf('Depth: %d, surviving points: %d\n',[iter,numel(I)])
end

% plot Mandelbrot set:
figure; imagesc(D); axis image; axis off; colormap hot

toc