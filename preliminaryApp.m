% global show_x_center show_y_center current_center pick_center enter_x enter_y go_button;

%%% Turn off default figure menu properties %%%
% Mandelbrot set explorer
% set(0,'DefaultFigureWindowStyle','normal');
% set(0,'DefaultFigureMenu','none');
% clear variables




function myfunc
global center location width resolution depth_levels max_depth cmap log_colour computation_mode magrect_frac magrect_size mode show_x_center show_y_center x_center y_center

% overall parameters:
resolution=[1100 600]; % in pixels
center=-0.840018751752590 + 0.224304941677271i;               % physical location of frame center
location=center;
depth_levels=200; % adaptive number of depth levels
max_depth=50; % max # of iterations
log_colour=1; % logarithmic colour map
cmap=colormap([0 0 0; colormap(hot(depth_levels-1))]); % colour map
initial_width=5;                % initial frame width on complex plane
mode='explore'; % 'explore' or 'movie'
computation_mode='cpu'; % 'cpu' or 'gpu'
magrect_frac=.1;   % frame fraction occupied by magnifying rectangle


fig = figure('Visible','off','Color','k',...
             'Position',[0 0 resolution(1) resolution(2)],'Color','k',...
             'MenuBar','none','NumberTitle','off');
set(gca,'position',[0 0 1 1]);


% Create radio buttons in the button group.
bg = uibuttongroup(fig,...
                  'Title','','BackgroundColor','black',...
                  'ForegroundColor','none','FontWeight','bold',...
                  'Position', [0 0 .15 .15],...
                  'SelectionChangedFcn',@bg_selection);
explore_mode = uicontrol(bg,...
               'Style','radiobutton','BackgroundColor','black',...
               'String','Explore','ForegroundColor','white',...
               'Position',[5 10 70 15],'FontWeight','bold');
              
movie_mode = uicontrol(bg,...
               'Style','radiobutton','BackgroundColor','black',...
               'String','Movie','ForegroundColor','white',...
               'Position',[80 10 70 15],'FontWeight','bold');
              
color_mode =uicontrol(fig,... 
                        'Style','popupmenu',...
                        'Position',[480 10 70 15],...
                        'String',{'Bright','Smooth'},...
                        'Callback',@set_color_mode);              
              
show_x_center = uicontrol(fig,...
                           'Visible','on','Style','text',...
                           'Position',[288 10 70 15]);
                        
show_y_center = uicontrol(fig,...
                           'Visible','on','Style','text',...
                           'Position',[400 10 70 15]);
                       
% enter_x = uicontrol(fig,...
%                     'Visible','off','Style','edit',...
%                     'Position',[288 10 70 15],...
%                     'Callback',@enter_x_Callback); 
%                 
% enter_y = uicontrol(fig,...
%                     'Visible','off','Style','edit',...
%                     'Position',[400 10 70 15],'String','string',...
%                     'Callback',@enter_y_Callback); 
                
current_center_text = uicontrol(fig,...
                            'Visible','on','Style','text','BackgroundColor','black',...
                            'Position',[280 35 70 15],'FontWeight','bold',...
                            'ForegroundColor','white','String','Position:');
                        
plus_i_text = uicontrol(fig,...
                    'Visible','on','Style','text','BackgroundColor','black',...
                    'Position',[367 10 30 15],'FontWeight','bold',...                
                    'ForegroundColor','white','String','+  i');  
                
set_center_text = uicontrol(fig,...
                         'Visible','off','Style','text','BackgroundColor','black',...
                         'Position',[280 35 80 15],'FontWeight','bold',...
                         'ForegroundColor','white','String','Set Center:'); 
                 
zoom_level_text = uicontrol(fig,...
                        'Style','text','BackgroundColor','black',...
                        'Position',[170 10 20 15],'FontWeight','bold',...
                        'ForegroundColor','white','String','10^ '); 
                     
zoom_level = uicontrol(fig,...
                        'Style','edit','Position',[195 10 30 15],...
                        'BackgroundColor','black',...
                        'Visible','off','Callback',@set_zoom_level);
                    
movie_time = uicontrol(fig,...
                        'Style','edit','Position',[235 10 30 15],...
                        'BackgroundColor','black',...
                        'Visible','off','Callback',@set_movie_time); 

resolution_input = uicontrol(fig,... 
                        'Style','popupmenu',...
                        'Position',[560 10 70 15],...
                        'String',{'1080x1920','720x1280','480x858','360x480','240x352'},...
                        'Callback',@set_resolution);
                    
resolution_text = uicontrol(fig,...
                            'Style','text','BackgroundColor','black',...
                            'Position',[540 30 80 15],...
                            'String','Set Resolution:',...
                            'ForegroundColor','white','FontWeight','bold');   
                        
cmapList = {'Jet', 'HSV', 'Hot', 'Cool', 'Spring', 'Summer', 'Autumn', ...
                 'Winter', 'Gray', 'Bone', 'Copper', 'Pink', 'Lines'}';                    
             
color_map = uicontrol(fig,...
                  'Style','popup','String',cmapList,...
                  'Position',[640 10 120 15],...
                  'Callback',@set_color_map);
              
color_map_text = uicontrol(fig,...
                           'Style','text','BackgroundColor','black',...
                           'Position',[620 30 80 15],...
                           'String','Set Colormap:',...
                           'ForegroundColor','white','FontWeight','bold');                     
                    
color_levels = uicontrol(fig,...
                         'Style','edit',...
                         'Position',[770 10 70 15],...
                         'Callback',@enter_color_levels); 
                     
color_levels_text = uicontrol(fig,...
                               'Style','text','BackgroundColor','black',...
                               'Position',[760 30 80 15],...
                               'String','Set Color Levels:',...
                               'ForegroundColor','white','FontWeight','bold'); 
                     
max_depth_input = uicontrol(fig,...
                        'Style','edit',...
                        'Position',[850 10 70 15],...
                        'Callback',@enter_max_depth); 
                    
max_depth_text = uicontrol(fig,...
                               'Style','text','BackgroundColor','black',...
                               'Position',[840 30 80 15],...
                               'String','Set Max Depth:',...
                               'ForegroundColor','white','FontWeight','bold');  
                           
gpu_mode = uicontrol(fig,...
                            'Style','checkbox','Position',[980 10 50 15],...
                            'String','GPU','BackgroundColor','Black',...
                            'ForegroundColor','white','FontWeight','bold',...
                            'Visible','on');
                        
go_button = uicontrol(fig,...
                      'Visible','off','Style','pushbutton',...
                      'Position',[930 10 40 30],'String','GO!',...
                      'Callback',@go_button_Callback);   
                  

  
% Initialize the UI.
% Change units to normalized so components resize automatically.
fig.Units = 'normalized';
bg.Units = 'normalized';
% color_mode.Units = 'normalized'; 
% plus_i_text.Units='normalized'; 
% movie_mode.Units = 'normalized';
% explore_mode.Units = 'normalized';
% show_x_center.Units = 'normalized';
% show_y_center.Units = 'normalized';
% current_center_text.Units = 'normalized';
% set_center_text.Units = 'normalized';
% enter_x.Units = 'normalized';
% enter_y.Units = 'normalized';
% go_button.Units = 'normalized';
% resolution_input.Units = 'normalized';
% color_map.Units = 'normalized'; 
% color_levels.Units = 'normalized'; 
% color_levels_text.Units = 'normalized'; 
% max_depth_input.Units = 'normalized'; 
% max_depth_text.Units = 'normalized'; 
% resolution_text.Units = 'normalized'; 
% color_map_text.Units = 'normalized'; 
% zoom_level.Units = 'normalized'; 
% zoom_level_text.Units = 'normalized'; 
% movie_time.Units = 'normalized'; 
% gpu_mode.Units = 'normalized'; 

% Assign the a name to appear in the window title.
fig.Name = 'Preliminary Mandelbrot App';


% Move the window to the center of the screen.
movegui(fig,'center')

% Make the window visible.
fig.Visible = 'on';

%%%%%% Program the Functionality of Features %%%%%%%

% Radio Button Functionality 

% hObject    handle to the selected object in uibuttongroup1 
% eventdata  structure with the following fields
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

    if strcmp(mode,'explore')
         magrect_size=magrect_frac*resolution;
         width=initial_width;
         show_frame(generate_frame(width,center,resolution,depth_levels,max_depth,log_colour,computation_mode))
    end


    function bg_selection(hObject, eventdata, handles)
      % Determine the selected data set.
      % Set current data to the selected data set.
      switch get(eventdata.NewValue,'String')
          case 'Explore' 
             mode='explore'; 
             current_center_text.Visible='on'; 
             set(uicontrol(show_x_center),'Style','text'); 
             set(uicontrol(show_y_center),'Style','text');
             set_center_text.Visible='off'; 
             go_button.Visible='off'; 
             show_x_center.String = real(location);
             %%%%%% mandelbrot.m code %%%%%%%
             magrect_size=magrect_frac*resolution;
             width=initial_width;
             show_frame(generate_frame(width,center,resolution,depth_levels,max_depth,log_colour,computation_mode))
          case 'Movie'
             mode='movie'; 
             set_center_text.Visible='on';
             set(uicontrol(show_x_center),'Style','edit'); 
             set(uicontrol(show_y_center),'Style','edit');
             set(uicontrol(show_x_center),'Callback',@enter_x_Callback); 
             set(uicontrol(show_y_center),'Callback',@enter_y_Callback);
             go_button.Visible='on'; 
             zoom_level.Visible='on'; 
             movie_time.Visible='on'; 
             current_center_text.Visible='off'; 
             %%%%%%% mandelbrot.m code %%%%%%
             show_frame(generate_frame(width,center,resolution,depth_levels,max_depth,log_colour,computation_mode)) 
      end
    end    


    function go_button_Callback(hObject, eventdata, handles)
         center = complex(x_center,y_center); 
         % zoom parameters:
         zoom_frac=10^(-15/1800); 
         n_zooms=50;

         frames_written=0;    
         v=VideoWriter('movie','MPEG-4');
         v.FrameRate=30;
         open(v);
         tic    
         parfor zoom_iter=1:n_zooms
             %zoom_iter
             frames(zoom_iter)=im2frame(mat2im(generate_frame(zoom_frac^(zoom_iter-1)*initial_width,center,resolution,depth_levels,max_depth,log_colour,computation_mode),cmap));
             frames_written=frames_written+1
         end
         toc;
         writeVideo(v,frames)
         close(v);   
    end

    function enter_x_Callback(hObject, eventdata, handles)
        x_center=str2double(get(hObject,'String'));
    end

    function enter_y_Callback(hObject, eventdata, handles)
        y_center = str2double(get(hObject,'String'));
    end
    
    function set_color_mode(hObject, eventdata, handles)
        get_color_mode = get(hObject,'String');
        if strcmp(get_color_mode,'Bright')
            log_colour=1; 
        elseif strcmp(get_color_mode,'Smooth')
            log_colour=0; 
        end
        display(get_color_mode);
    end
    
%     function @set_zoom_level
% 
%     end

%     function @set_movie_time
%         
%     end
% 
    function set_resolution(hObject, eventdata, handles)   %%%%%% fix default case for resolution
        get_resolution = get(hObject,'Value');
        switch(get_resolution)
            case 1
                resolution= [1080 1920]; 
            case 2 
                resolution=[720 1280]; 
            case 3
                resolution=[480 858]; 
            case 4
                resolution=[360 480]; 
            case 5 
                resolution=[240 352]; 
        end
    end
% 
%     function set_color_map
%         
%     end
% 
%     function enter_color_levels
%         
%     end
% 
%     function enter_max_depth
%         
%     end


        
             
end