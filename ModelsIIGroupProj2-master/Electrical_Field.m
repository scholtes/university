function varargout = Electrical_Field(varargin)
% ELECTRICAL_FIELD MATLAB code for Electrical_Field.fig
%      ELECTRICAL_FIELD, by itself, creates a new ELECTRICAL_FIELD or raises the existing
%      singleton*.
%
%      H = ELECTRICAL_FIELD returns the handle to a new ELECTRICAL_FIELD or the handle to
%      the existing singleton*.
%
%      ELECTRICAL_FIELD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELECTRICAL_FIELD.M with the given input arguments.
%
%      ELECTRICAL_FIELD('Property','Value',...) creates a new ELECTRICAL_FIELD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Electrical_Field_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Electrical_Field_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Electrical_Field

% Last Modified by GUIDE v2.5 08-Apr-2015 08:19:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Electrical_Field_OpeningFcn, ...
                   'gui_OutputFcn',  @Electrical_Field_OutputFcn, ...
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

function updateRelevantFields(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles)
% This function updates all of the value fields when something happens
% (such as a sample being selected from the menu)
set(handles.mass_val, 'String', mass);
set(handles.charge_val, 'String', charge);
set(handles.init_t, 'String', time_init);
set(handles.delta_t, 'String', dt);
set(handles.fin_t, 'String', time_final);
set(handles.init_x_pos, 'String', init_pos(1));
set(handles.init_y_pos, 'String', init_pos(2));
set(handles.init_x_vel, 'String', init_vel(1));
set(handles.init_y_vel, 'String', init_vel(2));
set(handles.field_equ, 'String', field);

function [mass,charge,time_init,dt,time_final,init_pos,init_vel,field] = getRelevantFields(handles)
ipx = str2double(get(handles.init_x_pos, 'String'));
ipy = str2double(get(handles.init_y_pos, 'String'));
ivx = str2double(get(handles.init_x_vel, 'String'));
ivy = str2double(get(handles.init_y_vel, 'String'));

mass = str2double(get(handles.mass_val, 'String'));
charge = str2double(get(handles.charge_val, 'String'));
time_init = str2double(get(handles.init_t, 'String'));
dt = str2double(get(handles.delta_t, 'String'));
time_final = str2double(get(handles.fin_t, 'String'));
init_pos = [ipx ipy];
init_vel = [ivx ivy];
field = get(handles.field_equ, 'String');

% --- Executes just before Electrical_Field is made visible.
function Electrical_Field_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Electrical_Field (see VARARGIN)

% Choose default command line output for Electrical_Field
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.charge_field)
mass = 1e-6;
charge = 1e-7;
time_init = 0;
dt = 0.025;
time_final = 8;
init_pos = [1.3, -0.7];
init_vel = [-0.45, 0.2];
field = '2*(z>0)-1';
doPlotActions(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles);
updateRelevantFields(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles);

% UIWAIT makes Electrical_Field wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Electrical_Field_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in choice_menu.
function choice_menu_Callback(hObject, eventdata, handles)
% hObject    handle to choice_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns choice_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from choice_menu

menu_choice = get(handles.choice_menu, 'Value'); % Get user choice from listbox tagged choice_menu
switch menu_choice
    case 1
        % Infinite charged plate
        mass = 1e-6;
        charge = 1e-7;
        time_init = 0;
        dt = 0.025;
        time_final = 8;
        init_pos = [1.3, -0.7];
        init_vel = [-0.45, 0.2];
        field = '2*(z>0)-1';
    case 2
        % Particle outside charged spherical shell
        mass = 1e-6;
        charge = 1e-7;
        time_init = 0;
        dt = 0.025;
        time_final = 30;
        init_pos = [1.3, -0.7];
        init_vel = [0.185, 0.185];
        field = '-(abs(z)>0.75^2)*abs(1/z^2)*z/abs(z)';
    case 3
        % Particle inside charged spherical shell
        mass = 1e-6;
        charge = 1e-7;
        time_init = 0;
        dt = 0.025;
        time_final = 3;
        init_pos = [0.2, 0.2];
        init_vel = [-0.185, -0.075];
        field = '-(abs(z)>0.75^2)*abs(1/z^2)*z/abs(z)';
    case 4
        % Two similarly charged objects
        mass = 1e-6;
        charge = 1e-7;
        time_init = 0;
        dt = 0.025;
        time_final = 8;
        init_pos = [1.5, 0.5];
        init_vel = [-0.4, 0.2];
        field = '-(abs(z-1)>0.6^2)*abs(1/(z-1)^2)*(z-1)/abs(z-1)-(abs(z+1)>0.6^2)*abs(1/(z+1)^2)*(z+1)/abs(z+1)';
    case 5
        % Two oppositely charged objects
        mass = 1e-6;
        charge = 1e-7;
        time_init = 0;
        dt = 0.025;
        time_final = 12;
        init_pos = [1.8, 0.2];
        init_vel = [-0.125, 0.4];
        field = '-(abs(z-1)>0.6^2)*abs(1/(z-1)^2)*(z-1)/abs(z-1)+(abs(z+1)>0.6^2)*abs(1/(z+1)^2)*(z+1)/abs(z+1)';
end

% Plot everything on charge_field
doPlotActions(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles);
% Update the values in text field
updateRelevantFields(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles);

% --- Executes during object creation, after setting all properties.
function choice_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choice_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function field_equ_Callback(hObject, eventdata, handles)
% hObject    handle to field_equ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of field_equ as text
%        str2double(get(hObject,'String')) returns contents of field_equ as a double

% Get the new values
[mass,charge,time_init,dt,time_final,init_pos,init_vel,field] = getRelevantFields(handles);
% Re-plot the graph
doPlotActions(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles);

% --- Executes during object creation, after setting all properties.
function field_equ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to field_equ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mass_val_Callback(hObject, eventdata, handles)
% hObject    handle to mass_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass_val as text
%        str2double(get(hObject,'String')) returns contents of mass_val as a double

% Get the new values
[mass,charge,time_init,dt,time_final,init_pos,init_vel,field] = getRelevantFields(handles);
% Re-plot the graph
doPlotActions(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles);

% --- Executes during object creation, after setting all properties.
function mass_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function charge_val_Callback(hObject, eventdata, handles)
% hObject    handle to charge_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of charge_val as text
%        str2double(get(hObject,'String')) returns contents of charge_val as a double

% Get the new values
[mass,charge,time_init,dt,time_final,init_pos,init_vel,field] = getRelevantFields(handles);
% Re-plot the graph
doPlotActions(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles);

% --- Executes during object creation, after setting all properties.
function charge_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to charge_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function init_x_pos_Callback(hObject, eventdata, handles)
% hObject    handle to init_x_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of init_x_pos as text
%        str2double(get(hObject,'String')) returns contents of init_x_pos as a double

% Get the new values
[mass,charge,time_init,dt,time_final,init_pos,init_vel,field] = getRelevantFields(handles);
% Re-plot the graph
doPlotActions(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles);

% --- Executes during object creation, after setting all properties.
function init_x_pos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to init_x_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function init_y_pos_Callback(hObject, eventdata, handles)
% hObject    handle to init_y_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of init_y_pos as text
%        str2double(get(hObject,'String')) returns contents of init_y_pos as a double

% Get the new values
[mass,charge,time_init,dt,time_final,init_pos,init_vel,field] = getRelevantFields(handles);
% Re-plot the graph
doPlotActions(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles);

% --- Executes during object creation, after setting all properties.
function init_y_pos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to init_y_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function init_t_Callback(hObject, eventdata, handles)
% hObject    handle to init_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of init_t as text
%        str2double(get(hObject,'String')) returns contents of init_t as a double

% Get the new values
[mass,charge,time_init,dt,time_final,init_pos,init_vel,field] = getRelevantFields(handles);
% Re-plot the graph
doPlotActions(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles);

% --- Executes during object creation, after setting all properties.
function init_t_CreateFcn(hObject, eventdata, handles)
% hObject    handle to init_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function delta_t_Callback(hObject, eventdata, handles)
% hObject    handle to delta_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delta_t as text
%        str2double(get(hObject,'String')) returns contents of delta_t as a double

% Get the new values
[mass,charge,time_init,dt,time_final,init_pos,init_vel,field] = getRelevantFields(handles);
% Re-plot the graph
doPlotActions(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles);

% --- Executes during object creation, after setting all properties.
function delta_t_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delta_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fin_t_Callback(hObject, eventdata, handles)
% hObject    handle to fin_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fin_t as text
%        str2double(get(hObject,'String')) returns contents of fin_t as a double

% Get the new values
[mass,charge,time_init,dt,time_final,init_pos,init_vel,field] = getRelevantFields(handles);
% Re-plot the graph
doPlotActions(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles);

% --- Executes during object creation, after setting all properties.
function fin_t_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fin_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
cla('reset');

axes(handles.position);
cla;
axes(handles.velocity);
cla;
axes(handles.acceleration);
cla;
axes(handles.charge_field);
cla;

set(handles.mass_val,'string',num2str(0));
set(handles.charge_val,'string',num2str(0));
set(handles.init_x_pos,'string',num2str(0));
set(handles.init_y_pos,'string',num2str(0));
set(handles.init_x_vel,'string',num2str(0));
set(handles.init_y_vel,'string',num2str(0));
set(handles.init_t,'string',num2str(0));
set(handles.delta_t,'string',num2str(0));
set(handles.fin_t,'string',num2str(0));
set(handles.field_equ,'string',num2str(0));
% handles    structure with handles and user data (see GUIDATA)



function init_x_vel_Callback(hObject, eventdata, handles)
% hObject    handle to init_x_vel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of init_x_vel as text
%        str2double(get(hObject,'String')) returns contents of init_x_vel as a double

% Get the new values
[mass,charge,time_init,dt,time_final,init_pos,init_vel,field] = getRelevantFields(handles);
% Re-plot the graph
doPlotActions(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles);

% --- Executes during object creation, after setting all properties.
function init_x_vel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to init_x_vel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function init_y_vel_Callback(hObject, eventdata, handles)
% hObject    handle to init_y_vel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of init_y_vel as text
%        str2double(get(hObject,'String')) returns contents of init_y_vel as a double

% Get the new values
[mass,charge,time_init,dt,time_final,init_pos,init_vel,field] = getRelevantFields(handles);
% Re-plot the graph
doPlotActions(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles);

% --- Executes during object creation, after setting all properties.
function init_y_vel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to init_y_vel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
