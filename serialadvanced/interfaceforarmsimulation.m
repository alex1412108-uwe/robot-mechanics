function varargout = interfaceforarmsimulation(varargin)
% INTERFACEFORARMSIMULATION MATLAB code for interfaceforarmsimulation.fig
%      INTERFACEFORARMSIMULATION, by itself, creates a new INTERFACEFORARMSIMULATION or raises the existing
%      singleton*.
%
%      H = INTERFACEFORARMSIMULATION returns the handle to a new INTERFACEFORARMSIMULATION or the handle to
%      the existing singleton*.
%
%      INTERFACEFORARMSIMULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACEFORARMSIMULATION.M with the given input arguments.
%
%      INTERFACEFORARMSIMULATION('Property','Value',...) creates a new INTERFACEFORARMSIMULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interfaceforarmsimulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interfaceforarmsimulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interfaceforarmsimulation

% Last Modified by GUIDE v2.5 12-Dec-2014 12:35:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interfaceforarmsimulation_OpeningFcn, ...
                   'gui_OutputFcn',  @interfaceforarmsimulation_OutputFcn, ...
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

% --- Executes just before interfaceforarmsimulation is made visible.
function interfaceforarmsimulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interfaceforarmsimulation (see VARARGIN)

% Choose default command line output for interfaceforarmsimulation
handles.output = hObject;

handles.metricdata.joint1 = 0;
handles.metricdata.joint2 = 0;
handles.metricdata.joint3 = 0;
handles.metricdata.joint4 = 0;
handles.metricdata.joint5 = 0;
handles.metricdata.toggleliveforwardkinematics = 0;

handles.metricdata.xcoordinate = 0;
handles.metricdata.ycoordinate  = 0;
handles.metricdata.zcoordinate  = 0;

set(handles.joint1, 'String', handles.metricdata.joint1);
set(handles.joint2, 'String', handles.metricdata.joint2);
set(handles.joint3, 'String', handles.metricdata.joint3);
set(handles.joint4, 'String', handles.metricdata.joint4);
set(handles.joint5, 'String', handles.metricdata.joint5);

set(handles.xcoordinate, 'String', handles.metricdata.xcoordinate);
set(handles.ycoordinate, 'String', handles.metricdata.ycoordinate);
set(handles.zcoordinate, 'String', handles.metricdata.zcoordinate);

%set(handles.toggleliveforward, 'String', handles.metricdata.toggleliveforward);

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using interfaceforarmsimulation.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end

% UIWAIT makes interfaceforarmsimulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interfaceforarmsimulation_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in updatebutton.
function updatebutton_Callback(hObject, eventdata, handles)
% hObject    handle to updatebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.armdisplay);
cla;
x=handles.metricdata.joint1
popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(rand(5));
    case 2
        plot(sin(1:0.01:25.99));
    case 3
        bar(1:.5:10);
    case 4
        plot(membrane);
    case 5
        %surf(peaks);
        
theta1=handles.metricdata.joint1       %from -100  to 90 degrees
theta2=handles.metricdata.joint2;     %from 0     to 180 degrees
theta3=handles.metricdata.joint3;    %from 0     to -170 degrees
theta4=handles.metricdata.joint4;    %from -180  to 0 degrees
theta5=handles.metricdata.joint5;       %from 0     to 180 degrees

forwardKinematics( theta1, theta2, theta3, theta4, theta5 )

end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


%*****************joint sliders*********************
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes on slider movement.
function joint1_Callback(hObject, eventdata, handles)
% hObject    handle to joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.metricdata.joint1 = get(hObject,'Value');

if isequal (handles.metricdata.toggleliveforwardkinematics, 1)
    theta1=handles.metricdata.joint1       %from -100  to 90 degrees
    theta2=handles.metricdata.joint2;     %from 0     to 180 degrees
    theta3=handles.metricdata.joint3;    %from 0     to -170 degrees
    theta4=handles.metricdata.joint4;    %from -180  to 0 degrees
    theta5=handles.metricdata.joint5;       %from 0     to 180 degrees

    forwardKinematics( theta1, theta2, theta3, theta4, theta5 )
end

guidata(hObject,handles)
%display(handles.metricdata.joint1);

% --- Executes during object creation, after setting all properties.
function joint1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function joint2_Callback(hObject, eventdata, handles)
% hObject    handle to joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.metricdata.joint2 = get(hObject,'Value');

if isequal (handles.metricdata.toggleliveforwardkinematics, 1)
    theta1=handles.metricdata.joint1       %from -100  to 90 degrees
    theta2=handles.metricdata.joint2;     %from 0     to 180 degrees
    theta3=handles.metricdata.joint3;    %from 0     to -170 degrees
    theta4=handles.metricdata.joint4;    %from -180  to 0 degrees
    theta5=handles.metricdata.joint5;       %from 0     to 180 degrees

    forwardKinematics( theta1, theta2, theta3, theta4, theta5 )
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function joint2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function joint3_Callback(hObject, eventdata, handles)
% hObject    handle to joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.metricdata.joint3 = get(hObject,'Value');

if isequal (handles.metricdata.toggleliveforwardkinematics, 1)
    theta1=handles.metricdata.joint1       %from -100  to 90 degrees
    theta2=handles.metricdata.joint2;     %from 0     to 180 degrees
    theta3=handles.metricdata.joint3;    %from 0     to -170 degrees
    theta4=handles.metricdata.joint4;    %from -180  to 0 degrees
    theta5=handles.metricdata.joint5;       %from 0     to 180 degrees

    forwardKinematics( theta1, theta2, theta3, theta4, theta5 )
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function joint3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function joint4_Callback(hObject, eventdata, handles)
% hObject    handle to joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.metricdata.joint4 = get(hObject,'Value');

if isequal (handles.metricdata.toggleliveforwardkinematics, 1)
    theta1=handles.metricdata.joint1       %from -100  to 90 degrees
    theta2=handles.metricdata.joint2;     %from 0     to 180 degrees
    theta3=handles.metricdata.joint3;    %from 0     to -170 degrees
    theta4=handles.metricdata.joint4;    %from -180  to 0 degrees
    theta5=handles.metricdata.joint5;       %from 0     to 180 degrees

    forwardKinematics( theta1, theta2, theta3, theta4, theta5 )
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function joint4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function joint5_Callback(hObject, eventdata, handles)
% hObject    handle to joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.metricdata.joint5 = get(hObject,'Value');

if isequal (handles.metricdata.toggleliveforwardkinematics, 1)
    theta1=handles.metricdata.joint1       %from -100  to 90 degrees
    theta2=handles.metricdata.joint2;     %from 0     to 180 degrees
    theta3=handles.metricdata.joint3;    %from 0     to -170 degrees
    theta4=handles.metricdata.joint4;    %from -180  to 0 degrees
    theta5=handles.metricdata.joint5;       %from 0     to 180 degrees

    forwardKinematics( theta1, theta2, theta3, theta4, theta5 )
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function joint5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function joint6_Callback(hObject, eventdata, handles)
% hObject    handle to joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function joint6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


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



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in position5button.
function position5button_Callback(hObject, eventdata, handles)
% hObject    handle to position5button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta1=90;       %from -100  to 90 degrees
theta2=90;     %from 0     to 180 degrees
theta3=-90;    %from 0     to -170 degrees
theta4=-180;    %from -180  to 0 degrees
theta5=0;       %from 0     to 180 degrees

forwardKinematics( theta1, theta2, theta3, theta4, theta5 )

% --- Executes on button press in position4button.
function position4button_Callback(hObject, eventdata, handles)
% hObject    handle to position4button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta1=90;       %from -100  to 90 degrees
theta2=90;     %from 0     to 180 degrees
theta3=-115;    %from 0     to -170 degrees
theta4=-148;    %from -180  to 0 degrees
theta5=0;       %from 0     to 180 degrees

forwardKinematics( theta1, theta2, theta3, theta4, theta5 )

% --- Executes on button press in position3button.
function position3button_Callback(hObject, eventdata, handles)
% hObject    handle to position3button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta1=90;       %from -100  to 90 degrees
theta2=90;     %from 0     to 180 degrees
theta3=-90;    %from 0     to -170 degrees
theta4=-180;    %from -180  to 0 degrees
theta5=0;       %from 0     to 180 degrees

forwardKinematics( theta1, theta2, theta3, theta4, theta5 )

% --- Executes on button press in position2button.
function position2button_Callback(hObject, eventdata, handles)
% hObject    handle to position2button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta1=0;       %from -100  to 90 degrees
theta2=90;     %from 0     to 180 degrees
theta3=-90;    %from 0     to -170 degrees
theta4=-180;    %from -180  to 0 degrees
theta5=0;       %from 0     to 180 degrees

forwardKinematics( theta1, theta2, theta3, theta4, theta5 )

% --- Executes on button press in position1button.
function position1button_Callback(hObject, eventdata, handles)
% hObject    handle to position1button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta1=0;       %from -100  to 90 degrees
theta2=90;     %from 0     to 180 degrees
theta3=-115;    %from 0     to -170 degrees
theta4=-148;    %from -180  to 0 degrees
theta5=0;       %from 0     to 180 degrees

forwardKinematics( theta1, theta2, theta3, theta4, theta5 )

% --- Executes on button press in homepositionbutton.
function homepositionbutton_Callback(hObject, eventdata, handles)
% hObject    handle to homepositionbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta1=0;       %from -100  to 90 degrees
theta2=90;     %from 0     to 180 degrees
theta3=-90;    %from 0     to -170 degrees
theta4=-180;    %from -180  to 0 degrees
theta5=0;       %from 0     to 180 degrees

forwardKinematics( theta1, theta2, theta3, theta4, theta5 )

handles.metricdata.joint1 = theta1;
handles.metricdata.joint2 = theta2;
handles.metricdata.joint3 = theta3;
handles.metricdata.joint4 = theta4;
handles.metricdata.joint5 = theta5;

% --- Executes on slider movement.
function xcoordinate_Callback(hObject, eventdata, handles)
% hObject    handle to xcoordinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.metricdata.xcoordinate = get(hObject,'Value');

if isequal (handles.metricdata.toggleliveforwardkinematics, 1)
    theta1=handles.metricdata.xcoordinate;       %from -100  to 90 degrees
    theta2=handles.metricdata.ycoordinate;     %from 0     to 180 degrees
    theta3=handles.metricdata.zcoordinate;    %from 0     to -170 degrees

    inverseKinematics( xcoordinate, ycoordinate, zcoordinate )
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function xcoordinate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xcoordinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function zcoordinate_Callback(hObject, eventdata, handles)
% hObject    handle to zcoordinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.metricdata.zcoordinate = get(hObject,'Value');

if isequal (handles.metricdata.toggleliveforwardkinematics, 1)
    theta1=handles.metricdata.xcoordinate;       %from -100  to 90 degrees
    theta2=handles.metricdata.ycoordinate;     %from 0     to 180 degrees
    theta3=handles.metricdata.zcoordinate;    %from 0     to -170 degrees

    inverseKinematics( xcoordinate, ycoordinate, zcoordinate )
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function zcoordinate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zcoordinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function ycoordinate_Callback(hObject, eventdata, handles)
% hObject    handle to ycoordinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.metricdata.ycoordinate = get(hObject,'Value');

if isequal (handles.metricdata.toggleliveforwardkinematics, 1)
    theta1=handles.metricdata.xcoordinate;       %from -100  to 90 degrees
    theta2=handles.metricdata.ycoordinate;     %from 0     to 180 degrees
    theta3=handles.metricdata.zcoordinate;    %from 0     to -170 degrees

    inverseKinematics( xcoordinate, ycoordinate, zcoordinate )
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function ycoordinate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ycoordinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pitch_Callback(hObject, eventdata, handles)
% hObject    handle to pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function yaw_Callback(hObject, eventdata, handles)
% hObject    handle to yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function yaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function roll_Callback(hObject, eventdata, handles)
% hObject    handle to roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function roll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in toggleliveforward.
function toggleliveforward_Callback(hObject, eventdata, handles)
% hObject    handle to toggleliveforward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of toggleliveforward
handles.metricdata.toggleliveforwardkinematics = get(hObject,'Value');
guidata(hObject,handles)
%display(handles.metricdata.toggleliveforwardkinematics);

% --- Executes on key press with focus on joint1 and none of its controls.
function joint1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to joint1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

function forwardKinematics( theta1, theta2, theta3, theta4, theta5 )

%theta1 from -100  to 90 degrees
%theta2 from 0     to 180 degrees
%theta3 from 0     to -170 degrees
%theta4 from -180  to 0 degrees
%theta5 from 0     to 180 degrees

q1 = theta1*pi/180;
q2 = theta2*pi/180;
q3 = theta3*pi/180;
q4 = theta4*pi/180;
q5 = theta5*pi/180;

%% Link Lengths
d1 = 80;
a3 = 155;
a4 = 153;
d5 = 33;
dE = 65;

%% Plot the robotic arm
x0 = 0;
y0 = 0;
z0 = d1;

x1 = 0 ;
y1 = 0 ;
z1 = d1 ;

x2 =  a3*cos(q1)*cos(q2);
y2 =  a3*cos(q2)*sin(q1);
z2 =  d1 + a3*sin(q2);

x3= cos(q1)*(a4*cos(q2 + q3) + a3*cos(q2));
y3= sin(q1)*(a4*cos(q2 + q3) + a3*cos(q2));
z3= d1 + a4*sin(q2 + q3) + a3*sin(q2);

x4 =  cos(q1)*(a4*cos(q2 + q3) + a3*cos(q2) - d5*sin(q2 + q3 + q4));
y4 = sin(q1)*(a4*cos(q2 + q3) + a3*cos(q2) - d5*sin(q2 + q3 + q4));
z4 =   d1 + a4*sin(q2 + q3) + a3*sin(q2) + d5*cos(q2 + q3 + q4);

xe =  cos(q1)*(a4*cos(q2 + q3) + a3*cos(q2) - (d5+dE)*sin(q2 + q3 + q4))
ye =  sin(q1)*(a4*cos(q2 + q3) + a3*cos(q2) - (d5+dE)*sin(q2 + q3 + q4))
ze =  d1 + a4*sin(q2 + q3) + a3*sin(q2) + (d5+dE)*cos(q2 + q3 + q4)

i=1;
    xx = [ x0(i); x1(i); x2(i); x3(i); x4(i); xe(i) ];
    yy = [ y0(i); y1(i); y2(i); y3(i); y4(i); ye(i) ];
    zz = [ z0(i); z1(i); z2(i); z3(i); z4(i); ze(i) ];
    
    
    plot3(xx,yy,zz,'ko-','Linewidth',4)
    axis([-300 300 -300 300 -300 300])

function inverseKinematics( coordinatex, coordinatey, coordinatez )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
C=180-acos((x4^2+z4^2+a3^2-a4^2)/(2*a3*sqrt(x4^2+z4^2+a3)))-acos((a4^2+a3^2-x4^2-z4^2)/(2*a4*a3));

theta1 = atan(z4/x4);
theta2 = acos((x4^2+z4^2+a3^2-a4^2)/(2*a3*sqrt(x4^2+z4^2+a3)))+atan(z4/x4);
theta3 = acos((a4^2+a3^2-x4^2-z4^2)/(2*a4*a3));
%theta4 = C+atan(x4/z4)+90-F;
theta4 = 0;
theta5 = 0;

%tests ik worked correctly
forwardKinematics( theta1, theta2, theta3, theta4, theta5 )
    
    
% --- Executes on button press in printforward.
function printforward_Callback(hObject, eventdata, handles)
% hObject    handle to printforward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
display(handles.metricdata.joint1);
display(handles.metricdata.joint2);
display(handles.metricdata.joint3);
display(handles.metricdata.joint4);
display(handles.metricdata.joint5);
