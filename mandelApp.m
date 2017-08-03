global show_x_center show_y_center current_center pick_center enter_x enter_y go_button;
show_x_center=uicontrol(gcf,'Visible','off','Style','text','Position',[228 259 26 47],'String','x');
show_y_center=uicontrol(gcf,'Visible','off','Style','text','Position',[300 333 26 47],'String','y');
current_center=uicontrol(gcf,'Visible','off','Style','text','Position',[228 275 52 70],'String','Current Center');
pick_center=uicontrol(gcf,'Visible','off','Style','text','Position',[228 275 52 70],'String','Choose Center'); 
enter_x=uicontrol(gcf,'Visible','off','Style','edit','Positon',[228 259 26 47],'Callback',@edit3_Callback); 
enter_y=uicontrol(gcf,'Visible','off','Style','edit','Positon',[300 333 26 47],'Callback',@edit4_Callback); 
go_button=uicontrol(gcf,'Visible','off','Style','pushbutton','Position',[380 470 26 47],'Callback',@pushbutton1_Callback);

function varargout = mandelApp(varargin)
% MANDELAPP MATLAB code for mandelApp.fig
%      MANDELAPP, by itself, creates a new MANDELAPP or raises the existing
%      singleton*.
%
%      H = MANDELAPP returns the handle to a new MANDELAPP or the handle to
%      the existing singleton*.
%
%      MANDELAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MANDELAPP.M with the given input arguments.
%
%      MANDELAPP('Property','Value',...) creates a new MANDELAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mandelApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mandelApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mandelApp

% Last Modified by GUIDE v2.5 31-Jul-2017 23:13:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mandelApp_OpeningFcn, ...
                   'gui_OutputFcn',  @mandelApp_OutputFcn, ...
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


% --- Executes just before mandelApp is made visible.
function mandelApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mandelApp (see VARARGIN)
a=0:.1:2*pi;
handles.sin=sin(a);
hold on 
plot(handles.sin)
[x,y]=ginput(1);
scatter(x,y)
hold off
% Choose default command line output for mandelApp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mandelApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mandelApp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
xVal=str2double(get(hObject),'String');

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
yVal=str2double(get(hObject),'String'); 

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------
% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_x_center show_y_center current_center pick_center enter_x enter_y go_button;
switch get(eventdata.NewValue,'Tag')
    case 'radiobutton1'   % explore mode
        disp('radiobutton1')
        current_center.visible='on'; 
        show_x_center.visible='on'; 
        show_y_center.visible='on'; 

    case 'radiobutton2'   % movie mode
        disp('radiobutton2')        
        pick_center.visible='on';
        enter_x.visible='on'; 
        enter_y.visible='on'; 
        go_button.visible='on'; 
end

% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pt=get(hObject,'CurrentPoint'); 
hold on
plot(pt); 





% --- Executes on button press in radiobutton1.
%function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1



% --- Executes on button press in radiobutton2.
%function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2hold off; 
