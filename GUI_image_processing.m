function varargout = GUI_image_processing(varargin)
% GUI_IMAGE_PROCESSING MATLAB code for GUI_image_processing.fig
%      GUI_IMAGE_PROCESSING, by itself, creates a new GUI_IMAGE_PROCESSING or raises the existing
%      singleton*.
%
%      H = GUI_IMAGE_PROCESSING returns the handle to a new GUI_IMAGE_PROCESSING or the handle to
%      the existing singleton*.
%
%      GUI_IMAGE_PROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_IMAGE_PROCESSING.M with the given input arguments.
%
%      GUI_IMAGE_PROCESSING('Property','Value',...) creates a new GUI_IMAGE_PROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_image_processing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_image_processing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_image_processing

% Last Modified by GUIDE v2.5 15-Jan-2020 10:48:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_image_processing_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_image_processing_OutputFcn, ...
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


% --- Executes just before GUI_image_processing is made visible.
function GUI_image_processing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_image_processing (see VARARGIN)

% Choose default command line output for GUI_image_processing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_image_processing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_image_processing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnProcess.
function btnProcess_Callback(hObject, eventdata, handles)
% hObject    handle to btnProcess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Initialization
name = get(handles.imageName, 'String');%get image name in text field
if get(handles.boolNoise, 'Value')
	name = strcat(name , 'b');
end
axes(handles.canvas);
axis off;

%% Affichage de l'image de base
path = strcat( 'Images/', name,'.jpg');
image = imread(path);%on ouvre l'image selectionne
imshow(image);%on affiche l'image selectionnée
pause(0.5);

%% Traitement
showSteps = get(handles.boolSteps, 'Value');
[validation, nCarsDetected] = ChaineDeTraitement( name , showSteps);

%% Affichage des résultats
file = fopen(strcat('Images/Annotations/',name,'.annotation.txt'),'r');
text = textscan(file,'%s', 'Delimiter', '');
set(handles.listBefore, 'String', text{1,1});
set(handles.listAfter, 'String', nCarsDetected);



function imageName_Callback(hObject, eventdata, handles)
% hObject    handle to imageName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imageName as text
%        str2double(get(hObject,'String')) returns contents of imageName as a double


% --- Executes during object creation, after setting all properties.
function imageName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imageName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnNext.
function btnNext_Callback(hObject, eventdata, handles)
% hObject    handle to btnNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name = get(handles.imageName, 'String');%get image name in text field
if ~isempty(name) && str2double(name)>= 0 && str2double(name)<= 30
    name = num2str(str2double(name)+1,'%03.f');
    %rajoute 1 au nom de l'image en s'assurant qu'il y ait toujours 3
    %caractères, en mettant des zeros devant
else
    if isempty(name)
        name = '001';
    end
end
set(handles.imageName,'String',name);
% --- Executes on button press in boolNoise.
function boolNoise_Callback(hObject, eventdata, handles)
% hObject    handle to boolNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of boolNoise


% --- Executes on selection change in listAfter.
function listAfter_Callback(hObject, eventdata, handles)
% hObject    handle to listAfter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listAfter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listAfter


% --- Executes during object creation, after setting all properties.
function listAfter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listAfter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listBefore.
function listBefore_Callback(hObject, eventdata, handles)
% hObject    handle to listBefore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listBefore contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listBefore


% --- Executes during object creation, after setting all properties.
function listBefore_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listBefore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in boolSteps.
function boolSteps_Callback(hObject, eventdata, handles)
% hObject    handle to boolSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of boolSteps
