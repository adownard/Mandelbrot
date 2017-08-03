function depth = pctdemo_processMandelbrotElement(x0,y0,max_depth,log_colour)
%PCTDEMO_PROCESSMANDELBROTELEMENT  Evaluate a Mandelbrot Set element
%   m = pctdemo_processMandelbrotElement(x0,y0,maxIterations) evaluates the
%   number of steps before the complex value (x0,y0) jumps outside a circle
%   of radius two on the complex plane. Each iteration involves mapping
%   z=z^2+z0 where z0=x0+i*y0. The return value is the log of the
%   iteration count at escape or maxIterations if the point did not escape.
%
%   See also: PARALLELDEMO_GPU_MANDELBROT

%   Copyright 2011 The MathWorks, Inc.

%   Modified by Abhranil Das and Alicia Downer, August 2017.

z0=complex(x0,y0);
z=z0;
depth=nan;
iter=0;
while iter<=max_depth    
    z=z*z+z0;
    if abs(z)>2
        depth=iter;
        break
    end
    iter=iter+1;
end
if log_colour
    depth=log(depth+1);
end