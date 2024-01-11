function varargout = edit(varargin)
% EDIT MATLAB code for edit.fig
%      EDIT, by itself, creates a new EDIT or raises the existing
%      singleton*.
%
%      H = EDIT returns the handle to a new EDIT or the handle to
%      the existing singleton*.
%
%      EDIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDIT.M with the given input arguments.
%
%      EDIT('Property','Value',...) creates a new EDIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before edit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to edit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help edit

% Last Modified by GUIDE v2.5 23-Dec-2023 21:16:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @edit_OpeningFcn, ...
                   'gui_OutputFcn',  @edit_OutputFcn, ...
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

function hideAllPanels(handles)
    % Iterate through all panel handles and hide them
     % Get all panel handles
    panelHandles = findobj(handles.figure1, 'Type', 'uipanel');
    amorphose = findobj('Type', 'uipanel', 'Title', 'Amorphose');
    set(amorphose, 'Position', [207 -0.058823529411764705 52.714285714285694 51.470588235294116]);

    % Find the panel with the title 'tools'
    toolsPanel = findobj(panelHandles, 'Title', 'tools');

    % Hide all panels except the 'tools' panel
    for i = 1:numel(panelHandles)
        if panelHandles(i) ~= toolsPanel
            set(panelHandles(i), 'Visible', 'off');
        end
    end

% --- Executes just before edit is made visible.
function edit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to edit (see VARARGIN)


% Choose default command line output for edit
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

hideAllPanels(handles);
% UIWAIT makes edit wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = edit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
[filename,filepath]=uigetfile({'*.jpg';'*.png';'*.*'},'Find image to be modified');
fullname=[filepath filename];
ImageFile=imread(fullname);
disp(filename)
disp(filepath)
axes(handles.axes1);
imshow(ImageFile, 'Parent', handles.axes1); % Display image using imshow
axis(handles.axes1, 'image'); % Set equal aspect ratio for the axes
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
showPanelByName(handles,"Arithmetic");

% Function definition for hideAllPanels

function showPanelByName(handles, panelName)
hideAllPanels(handles); % Assuming hideAllPanels function exists

% Find all panel handles
panelHandles = findobj(handles.figure1, 'Type', 'uipanel');

% Find the panel by its title
panel = findobj(panelHandles, 'Title', panelName);

% Set the visibility of the found panel to 'on'
set(panel, 'Visible', 'on');
amorphose = findobj('Type', 'uipanel', 'Title', panelName);
   set(amorphose, 'Position', [207 -0.058823529411764705 52.714285714285694 51.470588235294116]);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
 % Get the image from the axes
    img = getimage(handles.axes1);

    % Perform the rotation (e.g., rotate by 45 degrees)
    rotated_img = imrotate(img, -90, 'nearest', 'loose');
    %rotated_img = imrotate(img, 45, 'nearest', 'crop');  % Rotate by 45 degrees using nearest neighbor interpolation and crop the output

    % Display the rotated image
    axes(handles.axes1);
    imshow(rotated_img);  % Show the rotated image
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% Get the image from axes1
    originalImage = getimage(handles.axes1);

    % Convert the image to grayscale
    grayImage = rgb2gray(originalImage);

    % Display the grayscale image on axes1
    axes(handles.axes1);
    imshow(grayImage);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
img = getimage(handles.axes1);
showPanelByName(handles,"Graphes");
TF = fft2(img);
fft=fftshift(TF);

axes(handles.axes2);
imshow(TF);

axes(handles.axes6);
imshow(fft);

histogram(handles.axes7,img);

axes(handles.axes8);
b=log(abs(TF));
imagesc(b);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
showPanelByName(handles,"Amorphose");



% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
img = getimage(handles.axes1);
showPanelByName(handles,"Graphes");
TF = fft2(img);
fft=fftshift(TF);

axes(handles.axes2);
imshow(TF);

axes(handles.axes6);
imshow(fft);

histogram(handles.axes7,img);

axes(handles.axes8);
b=log(abs(TF));
imagesc(b);
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
img = getimage(handles.axes1);
img=histeq(img);
axes(handles.axes1);
imshow(uint8(img));
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
img = getimage(handles.axes1);
img=img(:,:,1);
axes(handles.axes1);
imshow(img);
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
img = getimage(handles.axes1);
img=img(:,:,2);
axes(handles.axes1);
imshow(img);
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
img = getimage(handles.axes1);
img=img(:,:,3);
axes(handles.axes1);
imshow(img);
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
img = getimage(handles.axes1);
img=rgb2ind(img,64);
axes(handles.axes1);
imshow(img);
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
img = getimage(handles.axes1);
img=rgb2ntsc(img);
axes(handles.axes1);
imshow(img);
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
img = getimage(handles.axes1);
showPanelByName(handles,"Graphes");
TF = fft2(img);
fft=fftshift(TF);

axes(handles.axes2);
imshow(TF);

axes(handles.axes6);
imshow(fft);

histogram(handles.axes7,img);

axes(handles.axes8);
b=log(abs(TF));
imagesc(b);


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
showPanelByName(handles,"Masquer zone");
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
img = getimage(handles.axes1);
img=255-img;
axes(handles.axes1);
imshow(img);


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
h = fspecial('average',[3 3]);
img = getimage(handles.axes1);
img=imfilter(img,h);
axes(handles.axes1);
imshow(img);

% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
img = getimage(handles.axes1);
img=ordfilt2(img,1,ones(3,3));
axes(handles.axes1);
imshow(img);

% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
img = getimage(handles.axes1);
img=imnoise(img);
axes(handles.axes1);
imshow(img);
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
img = getimage(handles.axes1);
img=ordfilt2(img,9,ones(3,3));
axes(handles.axes1);
imshow(img);
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% Assuming 'selectfunction' is the handle for your ButtonGroup
selectedButton = get(handles.selectradio, 'SelectedObject'); 
operation = get(selectedButton, 'String'); % Get the string value of the selected radio button
disp(operation);
% Rest of your code remains unchanged
img = getimage(handles.axes1);
value = str2double(get(handles.edit1, 'String')); 

switch operation
    case '+'
        img = img + value;
        axes(handles.axes1);
        imshow(img);
       
    case '-'
        img = img - value;
        axes(handles.axes1);
        imshow(img);
    case '*'
        img = img * value;
        axes(handles.axes1);
        imshow(img);
    case '/'
        if value ~= 0  
            img = img / value;
            axes(handles.axes1);
        imshow(img);
        else
            disp('Error: Division by zero');
        end
    otherwise
        disp('Error: Unrecognized operation');
        
end

% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton1.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)

% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
selectedButton = get(handles.uibuttongroup4, 'SelectedObject'); 
operation = get(selectedButton, 'String'); % Get the string value of the selected radio button
%disp(operation);
% Rest of your code remains unchanged
img = getimage(handles.axes1); 
switch operation
    case 'EXP'
        img_double = im2double(img);

    % Apply exponential transformation to each pixel value
    exponentiated_img = exp(img_double);

    % Scale the transformed image to [0, 1] for display (if needed)
    exponentiated_img = mat2gray(exponentiated_img);

    % Display the transformed image
    axes(handles.axes1);
    imshow(exponentiated_img);  % Show the transformed image
       
    case 'LOG'
        img_double = im2double(img);
        log_transformed_img = log10(img_double + 1);        
        axes(handles.axes1);
        imshow(log_transformed_img);  % Show the transformed image
    case 'SQRT'
        img_double = im2double(img);

    % Apply square root transformation to each pixel value
    sqrt_transformed_img = sqrt(img_double);

    % Display the transformed image
    axes(handles.axes1);
    imshow(sqrt_transformed_img);  % Show the transformed image
    otherwise
        disp('Error: Unrecognized operation');
        
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


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
minVal = str2double(get(handles.minVal, 'String')); 
maxVal = str2double(get(handles.maxVal, 'String'));
img = getimage(handles.axes1);
img=imadjust(img, [minVal; maxVal]);
axes(handles.axes1);
imshow(img); 
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function minVal_Callback(hObject, eventdata, handles)
% hObject    handle to minVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minVal as text
%        str2double(get(hObject,'String')) returns contents of minVal as a double


% --- Executes during object creation, after setting all properties.
function minVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxVal_Callback(hObject, eventdata, handles)
% hObject    handle to maxVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxVal as text
%        str2double(get(hObject,'String')) returns contents of maxVal as a double


% --- Executes during object creation, after setting all properties.
function maxVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
showPanelByName(handles,"Draw edges");
hx = fspecial('sobel');
hy = hx';

imgg = getimage(handles.axes1);
img = rgb2gray(imgg);

gx = conv2(img,hx);
gy = conv2(img,hy);

norme = max(abs(gx),abs(gy));

axes(handles.axes9);
imshow(norme);

imgSB = edge(img,'sobel','both');
axes(handles.axes10);
imshow(imgSB);
imgPB = edge(img,'prewitt','both');
axes(handles.axes11);
imshow(imgPB);
imgRB = edge(img,'roberts','both');
axes(handles.axes12);
imshow(imgRB);


% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
