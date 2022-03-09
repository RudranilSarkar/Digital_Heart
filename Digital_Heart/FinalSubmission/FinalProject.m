function varargout = FinalProject(varargin)
global ecg;
% FINALPROJECT MATLAB code for FinalProject.fig
%      FINALPROJECT, by itself, creates a new FINALPROJECT or raises the existing
%      singleton*.
%
%      H = FINALPROJECT returns the handle to a new FINALPROJECT or the handle to
%      the existing singleton*.
%
%      FINALPROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINALPROJECT.M with the given input arguments.
%
%      FINALPROJECT('Property','Value',...) creates a new FINALPROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FinalProject_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FinalProject_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FinalProject

% Last Modified by GUIDE v2.5 28-Jun-2018 20:40:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FinalProject_OpeningFcn, ...
                   'gui_OutputFcn',  @FinalProject_OutputFcn, ...
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


% --- Executes just before FinalProject is made visible.
function FinalProject_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FinalProject (see VARARGIN)

% Choose default command line output for FinalProject
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FinalProject wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FinalProject_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.mat'},'File Selector');
fullpathname = strcat(pathname, filename);
set(handles.edit1, 'String', fullpathname)
all=load (filename);
offset=111;
val=all.a;
nECG1 = (val-0)/200;
t = 0:length(nECG1)-1;
Fs=128;
opol = 6;
[p,s,mu] = polyfit(t,nECG1,opol);
f_y = polyval(p,t,[],mu);
dnECG1 = nECG1 - f_y;
VECG1 = sgolayfilt(dnECG1,7,21);
ECG1=VECG1.*100;
t = 1:length(ECG1);
hold on
axes(handles.axes1)
plot(t,ECG1)

[~,locs_Rwave] = findpeaks(ECG1,'MinPeakHeight',0.05,...
                                    'MinPeakDistance',50);

ECG_inverted = -ECG1;
[~,locs_Swave] = findpeaks(ECG_inverted,'MinPeakHeight',0.1,...
                                        'MinPeakDistance',100);
                                    
[~,min_locs] = findpeaks(-ECG1,'MinPeakDistance',10);
locs_Qwave = min_locs(ECG1(min_locs)>-0.09 & ECG1(min_locs)<-0.03);
[val_Qwave, val_Rwave, val_Swave] = deal(ECG1(locs_Qwave), ECG1(locs_Rwave), ECG1(locs_Swave));

 m_Q = mean(val_Qwave);
 m_R = mean(val_Rwave);
 m_S = mean(val_Swave);
 

 max=0;
 i=1;
 RR=locs_Rwave;
 
 d_RR=0;
 j=1;
 for i=1:1:length(RR)-1
     d_RR(j)=RR(i+1)-RR(i);
     j=j+1;
 end
 
  m_RR=mean(d_RR);
 m_Q;
 set(handles.text8, 'String', m_Q)
 m_R;
 set(handles.text9, 'String', m_R)
 m_S;
 set(handles.text10, 'String', m_S)
 m_RR;
 set(handles.text11, 'String', m_RR)
 pr=60*Fs/m_RR;
 bpm=round(pr);
 set(handles.text12, 'String', bpm)
 
 Feat = ECGalgoMatrix([m_Q,m_R,m_S,m_RR,bpm]);
 if Feat>0.5
     Feat='Abnormal';
     ecg = 1;
 else
     Feat='Normal';
     ecg = 0;
 end
 set(handles.text13, 'String', Feat)
 set(handles.edit12, 'String', ecg)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1, 'String', '')
set(handles.text8, 'String', '')
set(handles.text9, 'String', '')
set(handles.text10, 'String', '')
set(handles.text11, 'String', '')
set(handles.text12, 'String', '')
set(handles.text13, 'String', '')
axes(handles.axes1)
cla reset;

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global age sex cp rbp chol fbs recg thalach angina


age = str2double(get(handles.edit2,'string'));
sex = str2double(get(handles.edit3,'string'));
cp = str2double(get(handles.edit4,'string'));
rbp = str2double(get(handles.edit5,'string'));
chol = str2double(get(handles.edit6,'string'));
fbs = str2double(get(handles.edit7,'string'));
recg = str2double(get(handles.edit12,'string'));
thalach = str2double(get(handles.edit9,'string'));
angina = str2double(get(handles.edit10,'string'));

test1(1,1)=age;
test1(1,2)=sex;
test1(1,3)=cp;
test1(1,4)=rbp;
test1(1,5)=chol;
test1(1,6)=fbs;
test1(1,7)=recg;
test1(1,8)=thalach;
test1(1,9)=angina;

import_var.time = [];
import_var.signals.values = test1;
import_var.signals.dimension = 1;


open_system('ANNsimulink');
mdlWks = get_param('ANNsimulink','ModelWorkspace');
clear(mdlWks);
assignin(mdlWks,'import_v',import_var);

open('ANNsimulink.slx')
sim('ANNsimulink.slx')
a=sim('ANNsimulink.slx','SimulationMode','Normal');
output = a.get('export_v');
result1=output(:,:,1);
if result1(1,1)>0.5
    result=sprintf('%3.0f%% Normal',result1(1,1)*100);
    set(handles.text23, 'String', result,'ForegroundColor','green')
else
    result=sprintf('%3.0f%% Abnormal',(1-result1(1,1))*100);
    set(handles.text23, 'String', result,'ForegroundColor','red')
end
x1='';
x2='';
x3='';
x4='';
x5='';
if rbp>140
    x1='Your Resting Blood Pressure is more than the normal range which is 140.';
    %set(handles.text24, 'String', sugg,'ForegroundColor','green')
end
if chol>250
    x2='Your Total Cholesterol Level is more than the normal range which is 250.';
    %set(handles.text24, 'String', sugg,'ForegroundColor','green')
end
if fbs==1
    x3='Your Fasting Blood Sugar Level is more than the normal range which is 120.';
    %set(handles.text24, 'String', sugg,'ForegroundColor','green')
end
if thalach>120 && age>60
    x4='Your Maximum Heart Rate Achieved is more than the normal range.';
    %set(handles.text24, 'String', sugg,'ForegroundColor','green')
end
if chol>250 && sex>0 || thalach>120 && age>60 || fbs==1 || chol>250 || rbp>140 
    x5='Kindly Collate with your Doctor.';
    %set(handles.text24, 'String', sugg,'ForegroundColor','green')
end
sugg= sprintf([x1,'\n',x2,'\n',x3,'\n',x4,'\n',x5]);
set(handles.text24, 'String', sugg,'ForegroundColor','green')
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit2, 'String', '')
set(handles.edit3, 'String', '')
set(handles.edit4, 'String', '')
set(handles.edit5, 'String', '')
set(handles.edit6, 'String', '')
set(handles.edit7, 'String', '')
set(handles.edit9, 'String', '')
set(handles.edit10, 'String', '')
set(handles.edit12, 'String', '')
set(handles.text23, 'String', '')
set(handles.text24, 'String', '')

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;


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


function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
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



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
