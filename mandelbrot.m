%%%%%%%%%%% Mandelbrot Set %%%%%%%%%%%%
clear all 

% Input parameters
<<<<<<< HEAD
%resolution=[1920 1080];
resolution=[1920 1080]; 
=======
resolution=[1920 1080];
>>>>>>> 75a80a6505b6659e4a122c6f3c150ea6b891881a
center=0;
width=4;

max_depth=10;                   % max number of iterations

%%%%%%% generate grid %%%%%%%%
left=real(center)-width/2;
right=real(center)+width/2;

height=width*resolution(2)/resolution(1);
top=imag(center)+height/2;
bottom=imag(center)-height/2;

[X,Y]=meshgrid(left:width/(resolution(1)-1):right,top:-height/(resolution(2)-1):bottom); 
C = X + i*Y;

z=zeros(size(C));                    % initial z matrix is complex value matrix
depth=zeros(size(C)); 
%%%%%%% apply formula to matrices %%%%%%%%%

for iter=1:max_depth
    z=z.^2+C;                   % apply iteration of mandelbrot sequence
<<<<<<< HEAD
    escaped = abs(z) > 2;       % if true, the point has diverged
    index=find(escaped==1);
    depth(index) = iter;        % stores number of iterations each point goes through; 0 is included in mandelbrot 
=======
    escaped = abs(z) > 2;               % if true, the point has diverged
    depth(escaped) = iter;   % stores number of iterations each point goes through; 0 is included in mandelbrot 
>>>>>>> 75a80a6505b6659e4a122c6f3c150ea6b891881a
end 
figure
surf(depth,'EdgeColor','None')
view(2)




