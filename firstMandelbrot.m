%%%%%%%%%%% Mandelbrot Set %%%%%%%%%%%%
clear all 
% side note: 1080x1920

%%%%%%% generate grid %%%%%%%%

dx = .01;                   % set grid boundaries and increments
dy = .01; 
x0 = -2.5; 
xf = 2;
ylen = 1080*(xf-x0)/1920;
y0 = -ylen*0.5; 
yf = ylen*0.5; 
nx = floor((xf - x0)/dx);
ny = floor((yf - y0)/dy);    
cVec = [nx ny];            % allocate cVec for complex number values

for iy=1:ny
    for ix=1:nx
        cVec(ix,iy) = complex((x0+ix*dx),-(y0+iy*dy)); 
    end
end

c = transpose(cVec);       % arrange values in grid/axis positions
z0 = zeros(ny,nx);                    % initial z matrix is complex value matrix
storeIters = zeros(ny,nx);   
%%%%%%% apply formula to matrices %%%%%%%%%

nz = 10;                   % number of iterations
for iz=1:nz
    zn = z0.^2 + c;                   % apply iteration of mandelbrot sequence
    manVals = abs(zn) < 2;            % boolean matrix containing true values if the magnitude of zn value is less than 2
    iter = abs(zn) > 2;               % if true, the point has diverged
    storeIters = iter + storeIters;   % stores number of iterations each point goes through; 0 is included in mandelbrot 
    z0 = zn;                          % reset z0 to new value 
end
figure
surf(storeIters,'EdgeColor','None')
view(2)