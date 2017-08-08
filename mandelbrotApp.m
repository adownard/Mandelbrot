function varargout = mandelbrotApp(varargin)
% MANDELBROTAPP MATLAB code for mandelbrotApp.fig
%      MANDELBROTAPP, by itself, creates a new MANDELBROTAPP or raises the existing
%      singleton*.
%
%      H = MANDELBROTAPP returns the handle to a new MANDELBROTAPP or the handle to
%      the existing singleton*.
%
%      MANDELBROTAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MANDELBROTAPP.M with the given input arguments.
%
%      MANDELBROTAPP('Property','Value',...) creates a new MANDELBROTAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mandelbrotApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mandelbrotApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mandelbrotApp

% Last Modified by GUIDE v2.5 28-Jul-2017 22:01:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mandelbrotApp_OpeningFcn, ...
                   'gui_OutputFcn',  @mandelbrotApp_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before mandelbrotApp is made visible.
function mandelbrotApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mandelbrotApp (see VARARGIN)

% Choose default command line output for mandelbrotApp
handles.output = hObject;
if handles.mode==2
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
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mandelbrotApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mandelbrotApp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mode=1; 
% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mode=2; 
% Hint: get(hObject,'Value') returns toggle state of radiobutton2



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
