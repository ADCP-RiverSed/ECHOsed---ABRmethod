function varargout = InfraSafeGUI2025_V7(varargin)
% INFRASAFEGUI2025_V7 M-file for InfraSafeGUI2025_V7.fig
%      INFRASAFEGUI2025_V7, by itself, creates a new INFRASAFEGUI2025_V7 or raises the existing
%      singleton*.
%
%      H = INFRASAFEGUI2025_V7 returns the handle to a new INFRASAFEGUI2025_V7 or the handle to
%      the existing singleton*.
%
%      INFRASAFEGUI2025_V7('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INFRASAFEGUI2025_V7.M with the given input arguments.
%
%      INFRASAFEGUI2025_V7('Property','Value',...) creates a new INFRASAFEGUI2025_V7 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before InfraSafeGUI2025_V7_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to InfraSafeGUI2025_V7_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help InfraSafeGUI2025_V7

% Last Modified by GUIDE v2.5 17-Feb-2025 09:43:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @InfraSafeGUI2025_V7_OpeningFcn, ...
                   'gui_OutputFcn',  @InfraSafeGUI2025_V7_OutputFcn, ...
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


% --- Executes just before InfraSafeGUI2025_V7 is made visible.
function InfraSafeGUI2025_V7_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to InfraSafeGUI2025_V7 (see VARARGIN)
% clc;

handles.clri=1;
handles.ImportDataRun=0;
guidata(hObject,handles);
% Choose default command line output for InfraSafeGUI2025_V7
handles.output = hObject;

%to impose a certain method by default
set(handles.ProfileAnalysisMethod,'selectedobject',handles.Method02)
set(handles.FitCalibrationMethods,'selectedobject',handles.RatPolyButton)
% initializing the water level, water velocity and flow rate status
% variables. They are set to zero by default. They will be se to 1 after
% each variable is calculated.

handles.WaterLevelStatus=0;
handles.WaterVelocityStatus=0;
handles.FlowRateStatus=0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes InfraSafeGUI2025_V7 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = InfraSafeGUI2025_V7_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function DestinationFolder_Callback(hObject, eventdata, handles)
% hObject    handle to DestinationFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

destinationFolder = get(hObject,'String');

%check if the input is empty and make it default value
if (isempty(destinationFolder))
    set(hObject,'String',0)
end
% Hints: get(hObject,'String') returns contents of DestinationFolder as text
%        str2double(get(hObject,'String')) returns contents of DestinationFolder as a double


% --- Executes during object creation, after setting all properties.
function DestinationFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DestinationFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FileName_Callback(hObject, eventdata, handles)
% hObject    handle to FileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FileName as text
%        str2double(get(hObject,'String')) returns contents of FileName as a double
fileName =get(hObject,'String');

%check if the input is empty and make it default value
if (isempty(fileName))
    set(hObject,'String',0)
end

% --- Executes during object creation, after setting all properties.
function FileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileName (see GCBO)
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



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = get(handles.ftpAdress,'String');
b = get(handles.DestinationFolder,'String');
c = get(handles.FileName,'String');

ngdc = ftp(a);
cd(ngdc)
mget(ngdc,c);
close(ngdc);

%set(handles.FileName,'String',c);


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ftpAdress,'String','0');
set(handles.DestinationFolder,'String','0');
set(handles.FileName,'String','0');

%% % %%%%%%%%%%%%%
%
% Convert Data
%
%%%%%%%%%%%%%%%%
% --- Executes on button press in ConvertData.
function ConvertData_Callback(hObject, eventdata, handles)
% hObject    handle to ConvertData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

nbeams = get(handles.BeamNumber,'String');
inputfolder = get(handles.OrganizedDataFolder,'String');
outputfolder = get(handles.OutputFolder,'String');
starting=str2num(get(handles.StartDate,'String'));
ending=str2num(get(handles.EndingDate,'String'));

SelectedBeam=str2num(nbeams); %beam to be used
%% Beam selection
switch SelectedBeam
    case 1
        ECh1=ECh1;
    case 2
        clear ECh1
        ECh1=ECh2;
    otherwise
        msgbox('Error! Beam should be 1 or 2')
end

adcp=get(handles.ADCPChannel,'String');%L1 is 600 kHz, L2 is 1200 kHz

if char(adcp)=='L1'
    kHz='001001011';
    disp(adcp);
else
    kHz='001001100';
end
    
listing1=dir([inputfolder]); %%%%Folders in the data's folder
%    C:\Users\Massimo\Documents\Lavori\Kokel_Monitoring          '
%mkdir(strcat('C:\Users\User2\Documents\Lavori\Kokel_Monitoring\Risultati_',ADCP))
%%%%%Create folders output if not already existing

start=starting; %20170101;%fixing the data subset start
endng=ending; %20170327;%fixing the data subset end
ndays=ending-starting+1;
MSG='';
progressbar('Convert to Matlab',MSG);  %progressbar('A', 'B')

for m_in=3:length(listing1)
    
    progressbar(m_in/length(listing1),[]);
        
    if str2num(listing1(m_in).name)>=start && str2num(listing1(m_in).name)<=endng%fixing the data subset
  
    clear listing2 nome pop EX EZ EZ1 EA EB EH EP ER WT SS V1 PROY PGD1 PGD2 STD1 STD2
    clear V2 PS B1ST Vb1 Vb2 COR1 COR2 ECH1 ECH2 WP WS WF TP TIME TIM_m ED ES XmitV
    clear VL WT EP ER WS WF B1ST ADCP
    nens=0;NENS=0;
%     listing2=dir(strcat('C:\Users\Rui Aleixo\SharePoint\Massimo Guerrero\Kokel_Monitoring\ADCP_rawdata\Dati_',adcp,'\',num2str(listing1(m_in).name))');
    listing2=dir(strcat(inputfolder,'\',num2str(listing1(m_in).name)));
    nfiles=length(listing2)-2;
    
    for pop=1:nfiles
        nome{pop}=listing2(pop+2).name;
    end
        
    %%%%%Precedent functions
    
    for file=1:nfiles
%         hwaitbar = waitbar(0,['Processing...' ]);
        progressbar([],file/nfiles)
%         [fid,message] = fopen(strcat('C:\Users\Rui Aleixo\SharePoint\Massimo Guerrero\Kokel_Monitoring\ADCP_rawdata\Dati_',adcp,'\',num2str(listing1(m_in).name),'\',nome{file}),'r','n','ISO-8859-1');
        [fid,message] = fopen(strcat(inputfolder,'\',num2str(listing1(m_in).name),'\',nome{file}),'r','n','ISO-8859-1');
        [RDAT,sz_RD] = fread(fid,inf,'char');sz_RD0=0;
        fclose(fid);
        q7=quantizer([7 0]);
        q8_1=quantizer([8 0]);
        q8=quantizer([9 0]);
        q16=quantizer([17 0]);
        q32=quantizer([33 0]);
        I=0;fixx=-1;
%         nome(file
        bpe=0;
        corruptedbyte=0;
        
        while I+bpe<sz_RD
            
            if sum(char([num2hex(q8,RDAT(I+1)) num2hex(q8,RDAT(I+2))])=='07f07f')~=6;I=I+1;%finding Header line
                corruptedbyte=corruptedbyte+1;
            else
                warning off
                LSB=num2bin(q8,RDAT(I+3));
                MSB=num2bin(q8,RDAT(I+4));
                bpe=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)])+2;%bytes x ensembel
                ndt=RDAT(I+6);%number of data type
                hed_dat=6+2*ndt;%lunghezza header data
                
                
                k=I+hed_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='000000')==6;else;disp('Fixed leader not found');I=I+1;continue;end;%test to skip corrupted data
                
                k=min([I+hed_dat+bpe sz_RD-2]);
                
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));                
                if sum(char([LSB MSB])=='000000')==6;k=I+hed_dat;else;disp('End file or incomplete ensemble');I=I+1;continue;end;%test to skip corrupted data

                fix_led=58;%lunghezza fix leader (cambia da strumento a strumento: 52;53;59)             
               
                if nens>1; if RDAT(k+10)~=WN;disp('Fixed leader corrupted_2');I=I+1;continue;end;end 
                WN=RDAT(k+10);%numero di celle
                
                var_led=60;%lunghezza var leader (cambia da strumento a strumento: 65)
                vel_dat=(2+8*WN);%lunghezza vel. data
                cor_dat=(2+4*WN);%lunghezza correlation data
                ech_dat=(2+4*WN);%lunghezza echo data
                pgd_dat=(2+4*WN);%lunghezza %good data
                stf_dat=(2+4*WN);%lunghezza status format data
                sur_dat=95;%lunghezza surface amplitude data
                suc_dat=28;%lunghezza surface command data
                sus_dat=46;%lunghezza surface status data
                end_dat=4;%reserved & check data
                nens=nens+1;%numero di ensembel
                ADCP(nens,:)=num2bin(q8,RDAT(k+5));
                if char(ADCP(nens,:))==char(kHz); else;disp('Fixed leader corrupted_1');I=I+1;continue;end;%test to skip corrupted data
              
                
                WP(nens)=RDAT(k+11);%ping x ensembel
                WS(nens)=RDAT(k+13);%cell length [cm]
                WF(nens)=RDAT(k+15);%blank [cm]
                TP(nens)=RDAT(k+25);%time ping [s/100]
                ex=char(num2bin(q8_1,RDAT(k+26)));EX(nens,:)=ex;%EX command
                ez=char(num2bin(q7,RDAT(k+31)));EZ(nens,:)=ez;%EZ command sensor source
                ez1=char(num2bin(q7,RDAT(k+32)));EZ1(nens,:)=ez1;%Sensor available
                LSB=num2bin(q8,RDAT(k+33));
                MSB=num2bin(q8,RDAT(k+34));
                B1ST(nens)=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]);%BIN 1 distance  [m/10]
                PROY(:,nens)=[1:WS(nens):WN*WS(nens)]/100+B1ST(nens)/100;%Distance in meters along instrument axis y

                k=I+hed_dat+fix_led;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='080000')==6;else;disp('Variable leader not found');I=I+1;continue;end;%test to skip corrupted data
                %tempo di ens. in secondi
                TIME(nens)=sum([0*RDAT(k+5) ...%anno
                    0*RDAT(k+6) ...%mese
                    3600*24*RDAT(k+7) ...%giorno
                    3600*RDAT(k+8) ...%ora
                    60*RDAT(k+9) ...%minuto
                    1*RDAT(k+10) ...%secondo
                    1/100*RDAT(k+11)]');%centesimo
                ore(nens)=RDAT(k+8);minuti(nens)=RDAT(k+9);%ora e minuti
                TIM_m(nens)=datenum([RDAT(k+5)+2000 RDAT(k+6:k+10)']);%data e orario al secondo in formato matlab
                %depth strumento [m/10]
                LSB=num2bin(q8,RDAT(k+17));
                MSB=num2bin(q8,RDAT(k+18));
                ED(nens)=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]);%depth strumento [m/10]
                %pitch [°]
                LSB=num2bin(q8,RDAT(k+21));
                MSB=num2bin(q8,RDAT(k+22));
                if RDAT(k+22)==255
                    EP(nens)=min([bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]).*.01 (RDAT(k+21)-256)*.01]);%pitch [°]
                elseif RDAT(k+22)>=1 & RDAT(k+22)<=2
                    EP(nens)=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]).*.01;
                elseif RDAT(k+22)==0
                    EP(nens)=0.01*RDAT(k+21);
                elseif RDAT(k+22)==254
                    EP(nens)=-0.01*(256+(256-RDAT(k+21)));
                elseif RDAT(k+22)==253
                    EP(nens)=-0.01*(2*256+(256-RDAT(k+21)));
                end
                %roll [°]
                LSB=num2bin(q8,RDAT(k+23));
                MSB=num2bin(q8,RDAT(k+24));
                if RDAT(k+24)==255
                    ER(nens)=min([bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]).*.01 (RDAT(k+23)-256)*.01]);%roll [°]
                elseif RDAT(k+24)>=1 & RDAT(k+24)<=2
                    ER(nens)=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]).*.01;
                elseif RDAT(k+24)==0
                    ER(nens)=0.01*RDAT(k+23);
                elseif RDAT(k+24)==254
                    ER(nens)=-0.01*(256+(256-RDAT(k+23)));
                elseif RDAT(k+24)==253
                    ER(nens)=-0.01*(2*256+(256-RDAT(k+23)));
                end
                ES(nens)=RDAT(k+25);%salinità ppt
                XmitV(nens)=RDAT(k+36);%Battery voltage [V]
                %temperatura acqua [C°]
                LSB=num2bin(q8,RDAT(k+27));
                MSB=num2bin(q8,RDAT(k+28));
                WT(nens)=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]).*.01;%temperatura acqua [C°]
                %speed of sound in m/s
                LSB=num2bin(q8,RDAT(k+15));
                MSB=num2bin(q8,RDAT(k+16));
                SS(nens)=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]);%speed of sound in m/s
                %pressure transducer decaPascal
                LSB=num2bin(q8,RDAT(k+49));
                MSB=num2bin(q8,RDAT(k+50));
                LSB1=num2bin(q8,RDAT(k+51));
                MSB1=num2bin(q8,RDAT(k+52));
                PS(nens)=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)])-bin2num(q16,[MSB1(:,2:9) LSB1(:,2:9)]);%pressure transducer decaPascal
                
                k=I+hed_dat+fix_led+var_led;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                %if sum(char([LSB MSB])=='000001')==6;else;disp('Velocity data not found');continue;end
                LSB=num2bin(q8,RDAT(k+3:2:k+vel_dat));
                MSB=num2bin(q8,RDAT(k+4:2:k+vel_dat));
                for i=1:WN %velocità [mm/s] riferite secondo il comando EX
                    V1(i,nens)=(bin2num(q16,[MSB(1+(i-1)*4,3:9) LSB(1+(i-1)*4,2:9)])-2^15*str2num(MSB(1+(i-1)*4,2)));
                    V2(i,nens)=(bin2num(q16,[MSB(2+(i-1)*4,3:9) LSB(2+(i-1)*4,2:9)])-2^15*str2num(MSB(2+(i-1)*4,2)));
                end
                
                k=I+hed_dat+fix_led+var_led+vel_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='000002')==6;else;disp('Correlation data not found');I=I+1;continue;end;%test to skip corrupted data
                COR1(:,nens)=RDAT(k+3:4:k+cor_dat);%correlazione trasduttori 1->2
                COR2(:,nens)=RDAT(k+4:4:k+cor_dat);
                
                k=I+hed_dat+fix_led+var_led+vel_dat+cor_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='000003')==6;else;disp('Echo data not found');I=I+1;continue;end;%test to skip corrupted data
                ECH1(:,nens)=RDAT(k+3:4:k+ech_dat); %eco trasduttori 1->2 [counts]
                ECH2(:,nens)=RDAT(k+4:4:k+ech_dat);
%                 if median(ECH1(:,nens))<50;ECH1(:,nens)=NaN;ECH2(:,nens)=NaN;V1(:,nens)=NaN;V2(:,nens)=NaN;end
                
                k=I+hed_dat+fix_led+var_led+vel_dat+cor_dat+ech_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='000004')==6;else;disp('Percent good data not found');I=I+1;continue;end;%test to skip corrupted data
                PGD1(:,nens)=RDAT(k+3:4:k+pgd_dat); %percent good trasduttori 1->2 [%]
                PGD2(:,nens)=RDAT(k+4:4:k+pgd_dat);
                
                k=I+hed_dat+fix_led+var_led+vel_dat+cor_dat+ech_dat+pgd_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='000005')==6;else;disp('Status data not found');I=I+1;continue;end;%test to skip corrupted data
                STD1(:,nens)=RDAT(k+3:4:k+stf_dat); %status profile trasduttori 1->2 [%]
                STD2(:,nens)=RDAT(k+4:4:k+stf_dat);
                
                
                k=I+hed_dat+fix_led+var_led+vel_dat+cor_dat+ech_dat+pgd_dat+stf_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='002040')==6;else;disp('Surface data not found');I=I+1;continue;end;%test to skip corrupted data
                VL(nens)=(255*RDAT(k+5)+RDAT(k+4)); %%%Water level mm
                
                
                k=I+hed_dat+fix_led+var_led+vel_dat+cor_dat+ech_dat+pgd_dat+stf_dat+sur_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='001040')==6;else;disp('Surface command not found');I=I+1;continue;end;%test to skip corrupted data
                
                k=I+hed_dat+fix_led+var_led+vel_dat+cor_dat+ech_dat+pgd_dat+stf_dat+sur_dat+suc_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='000040')==6;else;disp('Surface status not found');I=I+1;continue;end;%test to skip corrupted data
                
                k=I+hed_dat+fix_led+var_led+vel_dat+cor_dat+ech_dat+pgd_dat+stf_dat+sur_dat+suc_dat+sus_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='002000')==6;else;disp('Firmware version not found');I=I+1;continue;end;%test to skip corrupted data
                
                FILE(nens)=file;
                
                warning('on')
                
                
                
                I=I+bpe;
                if fix(I/(bpe*10))>fixx
                    fixx=fixx+1;
                    MSG=(['ens n.: ' num2str(nens) ', of: ' num2str((sz_RD+sz_RD0-corruptedbyte)/bpe+NENS) '; file n.: ' num2str(file) ', of: ' num2str(nfiles) ', Day: ' num2str(listing1(m_in).name)  ]);
                    aa=(num2str(nens));
                    bb=(num2str((sz_RD+sz_RD0-corruptedbyte)/bpe+NENS));
                    
                end
            end
        end
        NENS=sz_RD/bpe+NENS;
                
        [II,J]=find(V1==32768);for i=1:length(II);V1(II(i),J(i))=NaN;end
        [II,J]=find(V2==32768);for i=1:length(II);V2(II(i),J(i))=NaN;end
        
        nnens=length(TIME);

        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        %%%NUOVA
        
        Res(1)={TIM_m};
        Res(2)={PROY};
        Res(3)={ECH1};
        Res(4)={ECH2};
        Res(5)={V1};
        Res(6)={V2};
        Res(7)={PGD1};
        Res(8)={PGD2};
        Res(9)={STD1}; %%%Parametri qualità: Status profile from 0 to 1 (1 bad)
        Res(10)={STD2}; %%%Parametri qualità: Status profile
        Res(11)={PS};  %%Pressure transducer output (daN/m2)
        Res(12)={ED};  %%Instrument level
        Res(13)={VL}; %%%Water level
        Res(14)={WT}; %%%Water temperature
        Res(15)={SS}; %%%Sound speed 
        Res(16)={EP}; %%Pitch
        Res(17)={ER}; %%Roll
        Res(18)={WS};
        Res(19)={WF};
        Res(20)={B1ST};
        Res(21)={ADCP};
        Res(22)={XmitV}; %%Battery voltage
        
%                 figure(1)
%                 subplot(211)
%                 plot(Res{2},Res{3})
%                 title('ECHO')
%                 subplot(212)
%                 plot(Res{2},Res{4})
        
        %             close all
        sz_RD0=sz_RD0+sz_RD;
    end
    %close(hwaitbar)
    save(strcat(outputfolder,'\',num2str(listing1(m_in).name),'.mat'),'Res');
    %'C:\Users\Rui Aleixo\SharePoint\Massimo
    %Guerrero\Kokel_Monitoring\Risultati_'
    end
    
end
progressbar(1)
function InputFolderLocation_Callback(hObject, eventdata, handles)
% hObject    handle to InputFolderLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InputFolderLocation as text
%        str2double(get(hObject,'String')) returns contents of InputFolderLocation as a double
InputFolder =get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function InputFolderLocation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputFolderLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function OutputFileLocation_Callback(hObject, eventdata, handles)
% hObject    handle to OrganizedDataFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OrganizedDataFolder as text
%        str2double(get(hObject,'String')) returns contents of OrganizedDataFolder as a double
OutputFolder =get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function OrganizedDataFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OrganizedDataFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function BeamNumber_Callback(hObject, eventdata, handles)
% hObject    handle to BeamNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NumberBeams =get(hObject,'String');
% Hints: get(hObject,'String') returns contents of BeamNumber as text
%        str2double(get(hObject,'String')) returns contents of BeamNumber as a double


% --- Executes during object creation, after setting all properties.
function BeamNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BeamNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ADCPChannel_Callback(hObject, eventdata, handles)
% hObject    handle to ADCPChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ADCPChannel as text
%        str2double(get(hObject,'String')) returns contents of ADCPChannel as a double
ADCPChannel =get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function ADCPChannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ADCPChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function StartDate_Callback(hObject, eventdata, handles)
% hObject    handle to StartDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartDate as text
%        str2double(get(hObject,'String')) returns contents of StartDate as a double
StartDate =get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function StartDate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function EndingDate_Callback(hObject, eventdata, handles)
% hObject    handle to EndingDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EndingDate as text
%        str2double(get(hObject,'String')) returns contents of EndingDate as a double
EndDate =get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function EndingDate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EndingDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ImportData.
function ImportData_Callback(hObject, eventdata, handles)
% hObject    handle to ImportData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

nbeams = get(handles.BeamNumber,'String');

start=get(handles.ImportStartDate,'String');
endng=get(handles.ImportEndDate,'String');
WorkingFolder=get(handles.OutputFolder,'String');
adcp=get(handles.ADCPChannel,'String');
density=str2num(get(handles.Density,'string'));
listing_res=dir([WorkingFolder,adcp]);

b1=pi*70/180;
b2=pi*110/180;
% 
I=0;%day index
% 
Start=datenum(start,'yyyymmdd');
Endng=datenum(endng,'yyyymmdd');
% colore='brkygcmbrkygcmbrkygcmbrkygcmbrkygcmbrkygcmbrkygcmbrkygcmbrkygcmbrkygcmbrkygcm';
%Data reading
[t, wt, proy_, day, ech1, ech2, WN, nens, dpro, Tv, Wt, ECH1, ECH2, Uecho] = fReadParameters(WorkingFolder,adcp,listing_res, start, endng);
t1=t;
proy_=proy_/cos(20*pi/180); %to correct for angle
handles.proy_=proy_;
guidata(hObject,handles);
% 
% Boxcar averaging for time vector
wtaux=find(Wt>50);
Wt(wtaux)=NaN;
box=30;%number of ens to be averaged () 1 measurement each 2 min: 2* 30 = 60 min
TV=(buffer(Tv,box));
WT=(buffer(Wt,box));
UU=(buffer(Uecho,box));
dTV=diff(TV)*86400;%distance between samples in sec
n=size(TV,2); %n=n(2);
%
SKIP=zeros(n,1);
[m1 n1]=find(dTV>box*120); %maximal distance between sample admitted (3600 sec)
TV(:,n1)=NaN;
WT(:,n1)=NaN;
SKIP(n1)=1;

%
TV=nanmean(TV);TV=TV(1:end-1);
WT=nanmedian(WT);WT=WT(1:end-1);
UU=nanmedian(UU);UU=UU(1:end-1);
IndexAux=zeros(size(TV,2),1); % track the indexes changed

%%
%Boxcar averagging for echoes
k=size(ECH1,1); %k=kk(1);
baux=find(SKIP);
for i=1:k
    Ech1_=ECH1(i,:);Ech2_=ECH2(i,:);
    Ech1_=(buffer(Ech1_,box)); Ech2_=(buffer(Ech2_,box));
    ECh1(i,:)=nanmedian(Ech1_);ECh2(i,:)=nanmedian(Ech2_);
    %     ECh1(i,baux)=NaN; ECh2(i,baux)=NaN; %using logical indexing
    
end
ECh1=ECh1(:,1:end-1);
ECh2=ECh2(:,1:end-1);
handles.ECh1=ECh1;
handles.ECh2=ECh2;
handles.TV=TV;
handles.WT=WT;
guidata(hObject,handles);

%% Beam selection
switch SelectedBeam
    case 1
        ECh1=ECh1;
    case 2
        clear ECh1
        ECh1=ECh2;
    otherwise
        msgbox('Error! Beam should be 1 or 2')
end

%% Convert values to dB
ECh1dB=fConvert2dB1(ECh1,UU,0);
handles.ECh1dB=ECh1dB;
guidata(hObject,handles);

%% Determining where the far field conditions are valid
SensorDiam=0.1144; frequency=str2num(get(handles.ADCPFrequency,'string'))*1000; csound=1490;
r0index=fFarField(SensorDiam,frequency,csound,proy_);
r0index=r0index+1; %because fFarField gives the last cell of the near field. 
                   %+1 to consider the 1st cell off the near-field
msgbox(sprintf('R0 index = %2.3g',r0index),'First Cell off the near-field ')
handles.r0index=r0index;
guidata(hObject,handles);
%control of r0index as function of csound
% Csound=1430:10:1550;
% for i=1:size(Csound,2)
%     r00index(i)=fFarField(SensorDiam,frequency,Csound(i),proy_);
% end

RiverWidth=15; %maximum extension
Lmax=find(abs(proy_(:,1)-RiverWidth)==min(abs(proy_(:,1)-RiverWidth)));

handles.Lmax=Lmax;
guidata(hObject,handles);

handles.ImportDataRun=1;
handles.frequency=frequency;
handles.density=density;
guidata(hObject,handles);

%% Echo analysis. method 1 threshold; method 2: first derivative. to assess
% the useful part of each profile.
method=2;
B=fBSAnalyser3(ECh1,r0index,method,Lmax);
% size(B)
handles.B=B;
guidata(hObject,handles);
% ECh1dB=fConvert2dB1(ECh1,UU,0);
% figure,
% for k=1:size(B,2)
%     plot(ECh1dB(1:B(k),k)), hold on;
% end

% [ECh1dBMin, ECh1dBMax, ECh1dBMean] = fSaveMinMax(ECh1dB,r0index);
% % Save min and max values of Echo for comparison with k1 values. 
% ECh1S=zeros(size(ECh1));


%%
WLH=ones(size(WT))*2;
[alfw, AW]=falfaw(WT,WLH);

%%
dk1=zeros(size(B)); dk2=dk1;

% 
% % deriv for k
% for k=1:size(ECh1dB,2)
%     difalfa{k}=(diff(ECh1dB(rx0:end,k)));
% end
% 
% for kk=1:size(ECh1dB,2)
%     mkk=difalfa{kk};
%     Rk(kk)=( proy_(I(kk)+1,1)+proy_(I(kk),1))/2;
%     K23a{kk}=-1./(2*Rk(kk))-mkk*1/(40*log10(exp(1)));
% end
% % 
% % first filter A>0 
% % figure,
% close all
% for kk=1:size(ECh1dB,2)
%     A=K23a{kk};
%     Aaux=A;
%     rss=find(A<0);
%     A(rss)=NaN;  %put negative values to NaN
%     AAR{kk}=A;
%     figure(99), plot(r0index:B(kk),A(2:10),'k-'), ylim([-1 1]),hold on
%     figure(100), plot(r0index:B(kk),Aaux(r0index:B(kk)),'r--'), ylim([-1 1]), hold on
% end
%%

s0=find(B<2);
dk1(s0)=NaN; dk2(s0)=NaN;

s1=find(B>1 & B<=2); s2=find(B==3);

rx0=r0index;  %r0index
difx=(diff(ECh1dB(rx0:rx0+3,:)));
% rk=find(difx(1:4,:)>eps);
mindif=zeros(1,size(ECh1dB,2));
rmin=mindif;
[mindif,I]=max(difx,[],1);
[maxdif,J]=max(difx,[],1);

for i=1:size(mindif,2)
    mk(i)=mindif(i);
    Rk(i)=( proy_(I(i)+1,1)+proy_(I(i),1))/2;
    K23(i)=-1./(2*Rk(i))-mk(i)*1/(40*log10(exp(1)));
    dk2(i)=-alfw(i)+ K23(i);
% % dk2(ik)=-alfw(ik)+K23(i);  %use this one!!!

    EEo(i)=ECh1dB(I(i),i);
    EE1(i)=ECh1dB(I(i)+1,i);
    EEaverage(i)=(EEo(i)+EE1(i))/2;
%     EEaverage(i)=mean(ECh1dB(r0index:BB(ik)));
    dk1(i)=EEaverage(i)+20*log10(Rk(i))+20*log10(exp(1))*2*K23(i)*Rk(i);
    
end
sn=find(dk2<0);
dk2(sn)=NaN;

handles.dk1=dk1;
guidata(hObject,handles);
handles.dk2=dk2;
guidata(hObject,handles);
msgbox('Import data finished')


function ImportStartDate_Callback(hObject, eventdata, handles)
% hObject    handle to ImportStartDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ImportStartDate as text
%        str2double(get(hObject,'String')) returns contents of ImportStartDate as a double


% --- Executes during object creation, after setting all properties.
function ImportStartDate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImportStartDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ImportEndDate_Callback(hObject, eventdata, handles)
% hObject    handle to ImportEndDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ImportEndDate as text
%        str2double(get(hObject,'String')) returns contents of ImportEndDate as a double


% --- Executes during object creation, after setting all properties.
function ImportEndDate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImportEndDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StatThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to StatThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StatThreshold as text
%        str2double(get(hObject,'String')) returns contents of StatThreshold as a double


% --- Executes during object creation, after setting all properties.
function StatThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StatThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function CStatResult_Callback(hObject, eventdata, handles)
% hObject    handle to CStatResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CStatResult as text
%        str2double(get(hObject,'String')) returns contents of CStatResult as a double


% --- Executes during object creation, after setting all properties.
function CStatResult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CStatResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in OrganizeADCPData.
function OrganizeADCPData_Callback(hObject, eventdata, handles)
% hObject    handle to OrganizeADCPData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% clear 
nbeams = get(handles.BeamNumber,'String');
rawdatafolder=get(handles.RawDataFolder,'String');
inputfolder = get(handles.OrganizedDataFolder,'String');
outputfolder = get(handles.OutputFolder,'String');
% starting=str2num(get(handles.StartDate,'String'));
% ending=str2num(get(handles.EndingDate,'String'));
channel=(get(handles.ADCPChannel,'String'));

starting=(get(handles.StartDate,'String'));
ending=(get(handles.EndingDate,'String'));


DAT=dir(rawdatafolder);
nf=size(DAT,1);
% start=starting;
% endin=ending;
% start=str2num(starting(3:end));
% endin=str2num(ending(3:end));
start=datenum(starting,'yyyymmdd');
endin=datenum(ending,'yyyymmdd');
basename=['devol_' channel '-AD'];

for i=start:endin
    progressbar(i/endin);
    folder=[inputfolder '\' datestr(i,'yyyymmdd')];
    mkdir(folder);
    rs=datestr(i,'yymmdd');
    filename=[basename rs];
    movefile([rawdatafolder '\' filename '.*'],folder,'f');
end

% current0=0; count=0;
% progressbar('Organize ADCP Data')
% for i=5:nf-1
%     current=DAT(i).name(12:17)
%     progressbar(i/(nf-1));
% %     current=DAT(i).name(9:14);
%     if datenum(current,'yymmdd')>=start && datenum(current,'yymmdd')<=endin
% %     if str2num(current)>=start && str2num(current)<=endin 
%         if strcmp(DAT(i).name(7:8),'L2') && count==0
%             current0=0;
%             count=1;
% %             disp('here10')
%         end
%         if datenum(current,'yymmdd')~=current0 && strcmp(DAT(i).name(7:8),'L1')
% %             folder=[ inputfolder 'Dati_L1\20' current];
%             folder=[ inputfolder '\20' current];
%             mkdir(folder);
%             disp('here_L1')
%             curent0=(current);
%             
%         elseif datenum(current,'yyyymmdd' )~=current0 && strcmp(DAT(i).name(7:8),'L2')
%             folder=[inputfolder '\20' current];
%             mkdir(folder);
%             curent0=(current);
%         end
%         DAT(i).name
%         movefile([rawdatafolder '\' DAT(i).name],folder,'f'); %movefile(DAT(i).name,folder,'f')
%         
%     end
% end
% progressbar(1);

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function xmin_Callback(hObject, eventdata, handles)
% hObject    handle to xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xmin as text
%        str2double(get(hObject,'String')) returns contents of xmin as a double


% --- Executes during object creation, after setting all properties.
function xmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xmax_Callback(hObject, eventdata, handles)
% hObject    handle to xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xmax as text
%        str2double(get(hObject,'String')) returns contents of xmax as a double


% --- Executes during object creation, after setting all properties.
function xmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in TestValidation.
function TestValidation_Callback(hObject, eventdata, handles)
% hObject    handle to TestValidation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xmax=str2num(get(handles.xmax,'String'));
xmin=str2num(get(handles.xmin,'String'));
if handles.MonoGranular==1
%     msgbox(sprintf('xmax = %2.3g',xmax),'BoxAverageWindow max')
%     msgbox(sprintf('xmin = %2.3g',xmin),'BoxAverageWindow min')
%     RatioMax=1E8;
%     RatioMin=1E1;
%     s=find(handles.ratio0<xmax & handles.ratio0>xmin);
%     handles.ratio0=ratio0;
%     handles.zeta0v=zeta0v;
    Cadcp1=200;
    RatioAll=handles.dk2./10.^((handles.dk1-Cadcp1)/10); 
%     XX=handles.XX;
%     SF=handles.pp;
%     save('v1.mat','SF')
    Np=size(handles.WT,2)
    for kk=1:Np
%         handles.pp{i};
        zetaMonoGranular(kk)=polyval(handles.pp0{kk},log(RatioAll(kk)));  
    end
    Concentration1=handles.dk2./exp(zetaMonoGranular);
    dkk2=handles.dk2;
    pp0=handles.pp0;
    TV=handles.TV;
    save('totil.mat','Concentration1','dkk2','zetaMonoGranular','RatioAll','pp0','TV')
    axes(handles.axes4)
    semilogy(handles.TV,Concentration1,'k+-'), datetick('x','dd/mm/yy'); 
    xlabel('Time (ddmmyy)')
    ylabel('Concentration (g/L)')
%     msgbox(sprintf('xmax = %2.3g %2.3g',ypol1(1),ypol1(2)),'polifit')
end



function ADCPFrequency_Callback(hObject, eventdata, handles)
% hObject    handle to ADCPFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ADCPFrequency as text
%        str2double(get(hObject,'String')) returns contents of ADCPFrequency as a double


% --- Executes during object creation, after setting all properties.
function ADCPFrequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ADCPFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RatioDK.
function RatioDK_Callback(hObject, eventdata, handles)
% hObject    handle to RatioDK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure, plot(handles.dk1,handles.dk2,'k+');

% --- Executes on button press in Homogenity.
function Homogenity_Callback(hObject, eventdata, handles)
% hObject    handle to Homogenity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% deriv for k
ECh1dB=handles.ECh1dB;
proy_=handles.proy_;
Lmax=handles.Lmax;
rx0=handles.r0index;
B=handles.B;
r0index=rx0;
[mindif,I]=max(diff(ECh1dB(rx0:rx0+3,:))    ,[],1);
% [maxdif,J]=max(difx,[],1);7

for k=1:size(ECh1dB,2)
    difalfa{k}=(diff(ECh1dB(rx0:end,k)));
end

for kk=1:size(ECh1dB,2)
    mkk=difalfa{kk};
    Rk(kk)=( proy_(I(kk)+1,1)+proy_(I(kk),1))/2;
    K23a{kk}=-1./(2*Rk(kk))-mkk*1/(40*log10(exp(1)));
end
% 
% first filter A>0 
% figure,
% close all
for kk=1:size(ECh1dB,2)
    A=K23a{kk};
%     Aaux=A;
    rss=find(A<0);
    A(rss)=NaN;  %put negative values to NaN
    AAR{kk}=A;
%     figure(99), plot(proy_(r0index:B(kk)),A(r0index:B(kk)),'k-'), ylim([-1 1]),hold on
%     figure(100), plot(proy_(r0index:B(kk)),Aaux(r0index:B(kk)),'r--'), ylim([-1 1]), hold on
end

%% filter values within +/-50% of the first value
for kk=1:size(ECh1dB,2)
    Ar=AAR{kk};
    r1=fNPercent(Ar,0.5);
    r2{kk}=fConsecutive(r1);
end
%%
figure,
set(gcf,'units','normalized','outerposition',[0 0 1 1])
for i=1:length(AAR)
    QW=AAR{i};
    cs=r2{i};
    nn=size(QW,1);
%     i
%     r0index
    if isfinite(cs)
        plot(proy_(r0index:r0index+nn-1,1),QW,'ko-'), hold on,
        plot(proy_(r0index:r0index+cs-1),QW(1:cs),'r+-'), hold on,
        xlim([proy_(r0index,1) proy_(Lmax,1)])
    end
end

xlabel('r (m)','fontsize',14,'fontname','times')
ylabel('$$\alpha$$','fontsize',14,'fontname','times','interpreter','latex')







% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Diameter_Callback(hObject, eventdata, handles)
% hObject    handle to Diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Diameter as text
%        str2double(get(hObject,'String')) returns contents of Diameter as a double


% --- Executes during object creation, after setting all properties.
function Diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Density_Callback(hObject, eventdata, handles)
% hObject    handle to Density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Density as text
%        str2double(get(hObject,'String')) returns contents of Density as a double


% --- Executes during object creation, after setting all properties.
function Density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in FitButton.
function FitButton_Callback(hObject, eventdata, handles)
% hObject    handle to FitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles.Fit='MonoGranular';
Fit=handles.Fit;

switch Fit
    case 'MonoGranular'
        h = msgbox('Mono-Granular');
        ABRmin=str2num(get(handles.xmin,'String'));
        ABRmax=str2num(get(handles.xmax,'String'));
        % save('TempData.mat','Xv','Xs','Ks','WT1','ABRmin','ABRmax')
        WT1=handles.WT;
        XX=handles.XX;
        ABR=handles.ABR;
        
        pp0=ffitfunction(size(WT1,2),ABRmin,ABRmax,XX,ABR);
%         save('wt1.mat','WT1','pp0');
        logspace(log10(ABRmin),log10(ABRmax));
        x = [1E-3 1E-2 1E-1 1E0 1E1 1E2 1E3 1E4 1E5 1E5 1E6 1E7 1E8 1E9 1E10];
        yval=polyval(pp0{1},log(x));
        a1=find(x<ABRmin);
        a2=find(x>ABRmax);
        yval(a1)=yval(max(a1));
        yval(a2)=yval(min(a2));
        axes(handles.axes3)
        loglog(x,exp(yval),'k-'); % axis('tight')
        
        handles.pp0=pp0;
        guidata(hObject,handles);
        delete(h)
    otherwise
        msgbox('Error')
end

% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4



function CalibrationFolder_Callback(hObject, eventdata, handles)
% hObject    handle to CalibrationFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CalibrationFolder as text
%        str2double(get(hObject,'String')) returns contents of CalibrationFolder as a double
CalibrationFolder =get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function CalibrationFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CalibrationFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ChannelWidth_Callback(hObject, eventdata, handles)
% hObject    handle to ChannelWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ChannelWidth as text
%        str2double(get(hObject,'String')) returns contents of ChannelWidth as a double


% --- Executes during object creation, after setting all properties.
function ChannelWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChannelWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit36_Callback(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit36 as text
%        str2double(get(hObject,'String')) returns contents of edit36 as a double


% --- Executes during object creation, after setting all properties.
function edit36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit37_Callback(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit37 as text
%        str2double(get(hObject,'String')) returns contents of edit37 as a double


% --- Executes during object creation, after setting all properties.
function edit37_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit35_Callback(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit35 as text
%        str2double(get(hObject,'String')) returns contents of edit35 as a double


% --- Executes during object creation, after setting all properties.
function edit35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RunCalibration.
function RunCalibration_Callback(hObject, eventdata, handles)
% hObject    handle to RunCalibration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selectedmode=get(handles.CalibrationButtons,'SelectedObject');
CalibSelected=get(selectedmode,'String');
disp('Running Calibration')


if strcmp(CalibSelected,'1st Calibration')
    Flag02=fCheckValuesCalib(selectedmode,handles);
    if Flag02(1)
        
        selectedmodemethod=get(handles.ProfileAnalysisMethod,'SelectedObject');
        MethodSelected=get(selectedmodemethod,'String');
        if strcmp(MethodSelected,'Method 1')
            method=1;
        elseif strcmp(MethodSelected,'Method 2')
            method=2;
        elseif strcmp(MethodSelected,'Method 3')
            method=3;
        end
        
        selectedmodemethod=get(handles.FitCalibrationMethods,'SelectedObject');
        
        MethodSelected=get(selectedmodemethod,'String');
        
        if strcmp(MethodSelected,'Linear')
            disp('    Linear Calibration')
            [aabbrr, dd22, Ccalib, DataC, DataCDaily,PlotData]=fCalibrationData(method,handles);
            [C1, C2, CC1, CCx, pcoef, xmin, xmax, yfit, S, r2, rmse,CLevel,Errors,epsilon]=fCalibrationlinear10(aabbrr, dd22, Ccalib, DataC, DataCDaily);
        elseif strcmp(MethodSelected,'Rat Poly')
            disp('    Polynomial ratio function')
            [aabbrr, dd22, Ccalib, DataC, DataCDaily,PlotData]=fCalibrationData(method,handles);
            [C1, C2, CC1, CCx,pcoef, xmin, xmax, yfit, S, r2, rmse,CLevel,Errors,epsilon]=fCalibrationRationalPolynomial(aabbrr, dd22, Ccalib, DataC, DataCDaily);
%             disp('here');
        end
        
        
        progressbar(20/100)
      
%         [C1, C2, pcoef, xmin, xmax, yfit, S, r2, rmse]=fCalibration2b(aabbrr, dd22, Ccalib, DataC, DataCDaily);
        if size(PlotData,2)
            save('CalibrationData.mat','PlotData');
            % [TV' ABR' d1' d2' ];
        end
        progressbar(100/100)
        
        %%
        
        h=questdlg('Is the Calibration curve OK','Calibration','Yes','No','Yes');
        %       questdlg(qstring,title,default)
        switch h
            case 'Yes'
                %fSaveData
                header={'Month' 'Day' 'hour' 'minute' 'zeta' 'Abr' 'Attenuation' 'Backscatter'};
                Cd1=C1'; Cd2=C2';

                Str=fClock2Str();
                
                filename1 = [Str '_' 'CalibrationDataHourlyAverages' '.txt'];
                fid = fopen(filename1, 'wt');
                fprintf(fid, '%s \t %s \t %s \t %s %s \t %s \t %s \t %s \n', header{1:end});  % header
                fclose(fid);
                dlmwrite(filename1,C1','delimiter','\t','precision',['%10.',num2str(12),'f'],'-append');
                
                filename2 = [Str '_' 'CalibrationDataDailyAverages'  '.txt'];
                fid = fopen(filename2, 'wt');
                fprintf(fid, '%s \t %s \t %s \t %s %s \t %s \t %s \t %s \n', header{1:end});  % header
                fclose(fid);
                dlmwrite(filename2,C2','delimiter','\t','precision',['%10.',num2str(12),'f'],'-append');
                 
                filename3 = [Str '_' 'C_calculated_C_measured'  '.txt'];
                fid = fopen(filename3, 'wt');
                fprintf(fid, '%s \t %s \n', 'C calculated', 'C measured');  % header
                fclose(fid);
                dlmwrite(filename3,[CC1' CCx'],'delimiter','\t','precision',['%10.',num2str(12),'f'],'-append');
                
%                 Description{'CC1 is Concetration }
                filename4 = [Str '_CalibrationData.mat'];
                save(filename4,'header','Cd1','Cd2','pcoef', 'xmin', 'xmax', 'yfit',...
                                          'S','r2','rmse','CLevel','Errors','epsilon');
%                 disp('    Writing data to excel')
                ExcelName1=[Str '_CalibrationOutput.xlsx'];

                xlswrite(ExcelName1,header,'Hour','A1');
                xlswrite(ExcelName1,C1','Hour','A2');
                xlswrite(ExcelName1,header,'Daily','A1');
                xlswrite(ExcelName1,C2','Daily','A2');
                
                header={'Coefficients','Range min','Range max','p1 CL','p2 CL','p3 CL','q1 CL','SSE','R2','epsilon'};
                ExcelName2=[Str '_CalibrationCurveFit2.xlsx'];
                
                xlswrite(ExcelName2,header);
                
                xlswrite(ExcelName2,header,'Hour','A1');
                xlswrite(ExcelName2,pcoef','Hour','A2');
                xlswrite(ExcelName2,xmin,'Hour','B2');
                xlswrite(ExcelName2,xmax,'Hour','C2');
%                 xlswrite(ExcelName2,xmax,'Hour','C2');
                xlswrite(ExcelName2,CLevel{1},'Hour','D2');
                xlswrite(ExcelName2,CLevel{2},'Hour','E2');
                xlswrite(ExcelName2,CLevel{3},'Hour','F2');
                xlswrite(ExcelName2,CLevel{4},'Hour','G2');
                xlswrite(ExcelName2,Errors.sse,'Hour','H2');
                xlswrite(ExcelName2,Errors.rsquare,'Hour','I2');
                xlswrite(ExcelName2,epsilon,'Hour','J2');
                
                if size(PlotData,2)
                    save('CalibrationData.mat','PlotData','-append');
                    % [TV' ABR' d1' d2' ];
                end
                
                handles.C1=C1; handles.C2=C2; handles.C2=C2;
                handles.yfit=yfit; handles.S=S; handles.r2=r2; handles.rmse=rmse;
                handles.pcoef=pcoef;
                handles.epsilon=epsilon;
                handles.xmin=xmin;
                handles.xmax=xmax;
                guidata(hObject,handles);
%                 disp('here')
                %             fclose all
                %xls_check_if_open('CalibrationCurveFit.xlsx','close')
                xls_check_if_open(ExcelName1,'close')
                xls_check_if_open(ExcelName2,'close')
                system('taskkill /F /IM EXCEL.EXE');
                %             delete( setdiff( findall(0, 'type', 'figure'), InfraSafeGUI2025_V7 ) );
            case 'No'
                msgbox('Re-insert the calibration curve')
                %             delete( setdiff( findall(0, 'type', 'figure'), InfraSafeGUI2025_V7 ) );
            otherwise
        end
    else
        msgbox('Check your input data')
    end
elseif strcmp(CalibSelected,'Calibration file')
    disp('    Importing calibration file');
    Flag02=fCheckValuesCalib(selectedmode,handles);
    if Flag02(1)
        %     disp('Here')
        calibfolder = get(handles.CalibrationFolder,'String');
        filename=get(handles.CalibXLS,'String');
        [num,txt,raw] = xlsread([calibfolder '\' filename],'Hour');
        pcoef=num(:,1);
        xmin=num(1,2);
        xmax=num(1,3);
%         p1CL=num(:,4);
%         p2CL=num(:,5);
%         p3CL=num(:,6);
%         q1CL=num(:,7);
        p1CL=num(1,1);
        p2CL=num(2,1);
        p3CL=num(3,1);
        q1CL=num(4,1);
        if size(num,2)>8
            SSE=num(1,8);
            R2=num(1,9);
            epsilon=num(1,10);
            handles.epsilon=epsilon;
        else
            SSE=0;
            R2=0;
            epsilon=0;
            handles.epsilon=epsilon;
        end
              
        xtest=logspace(floor(log10(xmin)),ceil(log10(xmax)));
        ytest=polyval(pcoef,log(xtest));
        progressbar(20/100)
        %load('ratio06.mat')
%         figure('Name','Calibration')
%         set(gcf,'units','normalized','outerposition',[0 0 1 1])     
%         loglog((xtest),exp(ytest),'r*-'), hold on
%         set(gcf,'units','normalized','outerposition',[0 0 1 1])
%         set(gca,'linewidth',2,'fontsize',18)
%         ylabel('\zeta_{s} (m^2/kg)','fontname','times','fontsize',28);
%         xlabel('ABR','fontname','times','fontsize',28);
%         title('zeta vs Abr','fontsize',26)
        
        handles.pcoef=pcoef;
        handles.xmin=xmin;
        handles.xmax=xmax;
        guidata(hObject,handles);
        system('taskkill /F /IM EXCEL.EXE');
        msgbox('Calibration curve imported')
        
        %h=questdlg('Is the Calibration curve OK','Calibration','Yes','No','Yes');
        %       questdlg(qstring,title,default)
        progressbar(100/100)
%         switch h
%             case 'Yes'
%                 delete( setdiff( findall(0, 'type', 'figure'), InfraSafeGUI2025_V7 ) );
%             case 'No'
%                 msgbox('Re-insert the calibration curve')
%                 delete( setdiff( findall(0, 'type', 'figure'), InfraSafeGUI2025_V7 ) );
%             otherwise
%         end
    else
        msgbox('Check the input data')
    end
elseif strcmp(CalibSelected,'Monogranular')
    
    a=1200;
    if a==1200
        
    else
        progressbar(20/100)
        header={'Coefficients','Range min' 'Range max'};
        load('ratio06.mat')
        ymonofit=polyfit(log(ratio0(12:28)),log(zeta0v(12:28)),1);
        ymono=polyval(ymonofit,log(ratio0(12:28)));
        figure('Name','Calibration')
        set(gcf,'units','normalized','outerposition',[0 0 1 1])
        loglog(ratio,zetav,'k.','MarkerSize',6), hold on,
        loglog(ratio0(12:28),exp(ymono),'k-','linewidth',2)
        scatter((ratio0(1:end-8)),(zeta0v(1:end-8)),100,(gg(1:end-8)*10^6),'o','filled');
        caxis([1 200]), colorbar;
        h = colorbar;
        title(h, 'd ($$\mu$$m)','interpreter','latex','fontsize',30)
        ylabel('\zeta_{s} (m^2/kg)','fontname','times','fontsize',28);
        xlabel('ABR','fontname','times','fontsize',28);
        set(gca, 'linewidth',2,'fontsize',16)
        handles.pcoef=ymonofit;
        handles.xmin=min(ratio(12:28));
        handles.xmax=max(ratio(12:28));
        guidata(hObject,handles);
        xlswrite('CalibrationCurveMonoGranular.xlsx',header,'Hour','A1');
        xlswrite('CalibrationCurveMonoGranular.xlsx',ymonofit','Hour','A2');
        xlswrite('CalibrationCurveMonoGranular.xlsx',min(ratio(12:28)),'Hour','B2');
        xlswrite('CalibrationCurveMonoGranular.xlsx',max(ratio(12:28)),'Hour','C2');
    end
    
    
    progressbar(100/100)
    %     xlswrite('CalibrationOutput.xlsx',C1','Hour','A2');
    %     xlswrite('CalibrationOutput.xlsx',header,'Daily','A1');
    %     xlswrite('CalibrationOutput.xlsx',C2','Daily','A2');
    
    %  msgbox('Calibration curve imported')
end

% close the message box

%     inputfolder = get(handles.OrganizedDataFolder,'String');
%     outputfolder = get(handles.OutputFolder,'String');
%     starting=str2num(get(handles.StartDate,'String'));
%     ending=str2num(get(handles.EndingDate,'String'));
%

% end
msgbox('Calibration: Over')


% --- Executes on button press in KnownC.
function KnownC_Callback(hObject, eventdata, handles)
% hObject    handle to KnownC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of KnownC



function ProcessStartDate_Callback(hObject, eventdata, handles)
% hObject    handle to ProcessStartDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ProcessStartDate as text
%        str2double(get(hObject,'String')) returns contents of ProcessStartDate as a double


% --- Executes during object creation, after setting all properties.
function ProcessStartDate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ProcessStartDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ProcessEndDate_Callback(hObject, eventdata, handles)
% hObject    handle to ProcessEndDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ProcessEndDate as text
%        str2double(get(hObject,'String')) returns contents of ProcessEndDate as a double


% --- Executes during object creation, after setting all properties.
function ProcessEndDate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ProcessEndDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BoxAverageWindow_Callback(hObject, eventdata, handles)
% hObject    handle to BoxAverageWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BoxAverageWindow as text
%        str2double(get(hObject,'String')) returns contents of BoxAverageWindow as a double

% rui 20190129
% --- Executes during object creation, after setting all properties.
function BoxAverageWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BoxAverageWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ProcessData.
function ProcessData_Callback(hObject, eventdata, handles)
% hObject    handle to ProcessData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% close figures but gui
delete( setdiff( findall(0, 'type', 'figure'), InfraSafeGUI2025_V7) );
hfig=InfraSafeGUI2025_V7;
jFrame = get(hfig, 'JavaFrame');
jFrame.setMaximized(1);
clc
% clear all;
% 3 setembro                   FitCalibrationMethods
selectedmodemethod=get(handles.ProfileAnalysisMethod,'SelectedObject');
MethodSelected=get(selectedmodemethod,'String');

% selectedmodemethod=get(handles.FitCalibrationMethods,'SelectedObject');
% MethodSelected=get(selectedmodemethod,'String');
if strcmp(MethodSelected,'Method 1')
    method=1;
elseif strcmp(MethodSelected,'Method 2')
    method=2;
elseif strcmp(MethodSelected,'Method 3')
    method=3;
end

Flag01=fCheckValuesProcess(handles);

if Flag01(1)
    
%     [TV, abr,dk1,dk2,Quality]=fProcessing31(method,handles);
%     [TV, abr,dk1,dk2,Quality]=fProcessing31(method,handles);
    [TV,abr,dk1,dk2,DK95,abrplus,dk1plus,dk2plus,...
                         abrminus,dk1minus,dk2minus,Quality,Qualityplus,Qualityminus]=fProcessing31Anew(method,handles);
    %this was for debug save('Nilstest.mat','dk1','dk2','TV');
    a=handles.pcoef; b=[handles.xmin handles.xmax];
    epsilon=handles.epsilon;
    % exst=exist(a);
    if  ~(a(1) || a(2))
        msgbox('Please define calibration')
    else
%         C=fConcentration(a,b,abr,dk2);  DK95={ABR95p, ABR95m, dk1p_95,dk2p_95,dk1m_95,dk2m_95};
        C=fConcentration2(a,b,abr,dk2);
        
        Ccp=C*10^(2*epsilon); Ccm=C/10^(2*epsilon);
        DK95;
        C95plus=fConcentration2(a,b,abr,DK95{4});
        C95minus=fConcentration2(a,b,abr,DK95{6});
        
        Cplus=fConcentration2(a,b,abr,dk2plus);  %abrplus
        Cminus=fConcentration2(a,b,abr,dk2minus); %abrminus
        filename='_Data_Output_';
        Str=fClock2Str();
        Filename=[Str filename '.mat'];
        save(Filename,'a','b','TV','Cminus','C','Cplus','C95plus','C95minus',...
            'Quality','Qualityplus','Qualityminus','DK95','abr','dk2','dk1','Ccm','Ccp')       
        handles.TV=TV;           
        handles.dk1=dk1;
        handles.dk2=dk2;
        handles.abr=abr;
        handles.C=C;
        handles.Quality=Quality;
        guidata(hObject,handles);
        ar=handles.clri;
        
        a1=datenum('01/01/15');
        a2=find(TV<a1);
        if ~isempty(a2)
            TV(a2)=NaN;
            C(a2)=NaN;
        end
        clri=handles.clri+1;
        handles.clri=clri;
        guidata(hObject,handles);
        axes(handles.axes4)
        colorir={'k','r','b','m','c','y','g'};
        semilogy(TV(1:end),C,[colorir{(mod(ar,7))+1} '+-']), datetick('x','dd/mm/yy');
        hold on
        semilogy(TV(1:end),C95plus,['k--']), datetick('x','dd/mm/yy');
        hold on
        semilogy(TV(1:end),C95minus,['k--']), datetick('x','dd/mm/yy');
        xlabel('Time (ddmmyy)'), ylabel('C (g/L)')
        semilogy(TV(1:end),Ccm,'b--'), datetick('x','dd/mm/yy');
        semilogy(TV(1:end),Ccp,'b--'), datetick('x','dd/mm/yy');
        semilogy(TV(1:end),Cplus,'m--'), datetick('x','dd/mm/yy');
        semilogy(TV(1:end),Cminus,'m--'), datetick('x','dd/mm/yy');
        xlabel('Time (ddmmyy)'), ylabel('C (g/L)')
        %xlim([min(TV) max(TV)])
        hold( handles.axes4, 'on' )
        %     clri=clri+1;
%         [TV(1:end)]
        msgbox('Processing is Over')
        %     ylabel('Concentration (g/L)')
    end
else
    msgbox('Check input parameters')
end
% save('Timez.mat','TV');
function SmoothFactor_Callback(hObject, eventdata, handles)
% hObject    handle to SmoothFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SmoothFactor as text
%        str2double(get(hObject,'String')) returns contents of SmoothFactor as a double


% --- Executes during object creation, after setting all properties.
function SmoothFactor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SmoothFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DerivativeThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to DerivativeThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DerivativeThreshold as text
%        str2double(get(hObject,'String')) returns contents of DerivativeThreshold as a double


% --- Executes during object creation, after setting all properties.
function DerivativeThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DerivativeThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit49_Callback(hObject, eventdata, handles)
% hObject    handle to ChannelWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ChannelWidth as text
%        str2double(get(hObject,'String')) returns contents of ChannelWidth as a double


% --- Executes during object creation, after setting all properties.
function edit49_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChannelWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StopAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to StopAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StopAnalysis as text
%        str2double(get(hObject,'String')) returns contents of StopAnalysis as a double


% --- Executes during object creation, after setting all properties.
function StopAnalysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StopAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NoiseLevel_Callback(hObject, eventdata, handles)
% hObject    handle to NoiseLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoiseLevel as text
%        str2double(get(hObject,'String')) returns contents of NoiseLevel as a double


% --- Executes during object creation, after setting all properties.
function NoiseLevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoiseLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StartDateMonitor_Callback(hObject, eventdata, handles)
% hObject    handle to StartDateMonitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartDateMonitor as text
%        str2double(get(hObject,'String')) returns contents of StartDateMonitor as a double


% --- Executes during object creation, after setting all properties.
function StartDateMonitor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartDateMonitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EndDateMonitor_Callback(hObject, eventdata, handles)
% hObject    handle to EndDateMonitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EndDateMonitor as text
%        str2double(get(hObject,'String')) returns contents of EndDateMonitor as a double


% --- Executes during object creation, after setting all properties.
function EndDateMonitor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EndDateMonitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BoxAverageMonitor_Callback(hObject, eventdata, handles)
% hObject    handle to BoxAverageMonitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BoxAverageMonitor as text
%        str2double(get(hObject,'String')) returns contents of BoxAverageMonitor as a double


% --- Executes during object creation, after setting all properties.
function BoxAverageMonitor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BoxAverageMonitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StartProfile_Callback(hObject, eventdata, handles)
% hObject    handle to StartProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartProfile as text
%        str2double(get(hObject,'String')) returns contents of StartProfile as a double


% --- Executes during object creation, after setting all properties.
function StartProfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StepProfile_Callback(hObject, eventdata, handles)
% hObject    handle to StepProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StepProfile as text
%        str2double(get(hObject,'String')) returns contents of StepProfile as a double


% --- Executes during object creation, after setting all properties.
function StepProfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StepProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EndProfile_Callback(hObject, eventdata, handles)
% hObject    handle to EndProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EndProfile as text
%        str2double(get(hObject,'String')) returns contents of EndProfile as a double


% --- Executes during object creation, after setting all properties.
function EndProfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EndProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MonitorRun.
function MonitorRun_Callback(hObject, eventdata, handles)
% hObject    handle to MonitorRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% adcp=handles.ADCPChannel.String;
% frequency=str2double(handles.ADCPFrequency.String);
% StartDate=handles.StartDateMonitor.String;
% EndDate=handles.EndDateMonitor.String;
% box=str2double(handles.BoxAverageWindow.String);
WorkFolder=handles.OutputFolder.String;
% dThresh=str2num(handles.DerivativeThreshold.String);
% RiverWidth=str2double(handles.ChannelWidth.String);
% listing_res=dir([WorkingFolder]);

Flag=fCheckValuesMonitor(handles);

if Flag(1)
    if iscell(WorkFolder)
        WorkingFolder=WorkFolder{1}; %'C:\Users\Rui Aleixo\SharePoint\Massimo Guerrero\Kokel_Monitoring\Risultati_';
    else
        WorkingFolder=WorkFolder;
    end
%     [ECh1dB, Proy, WT, TV]=fReadDataMonitorCalib(handles); %StartDate,EndDate,WorkingFolder,adcp,frequency,listing_res,box
    [ECh1dB, Proy, WT, TV]=fReadDataMonitor(handles); %StartDate,EndDate,WorkingFolder,adcp,frequency,listing_res,box
%     fReadDataMonitor2
    %% clean profiles
    NoiseLevel=str2double(handles.NoiseLevel.String);
    %         Lmax=str2num(handles.ChannelWidth.String);
    Lused=str2double(handles.StopAnalysis.String);
    
    ECh1dBa=fCleanProfilesStandard(ECh1dB,Proy,NoiseLevel,Lused);
    
    istart=str2double(handles.StartProfile.String);
    istep=str2double(handles.StepProfile.String);
    iend=str2double(handles.EndProfile.String);
    
    if iend==-1
        iend=size(ECh1dBa,2);
    end
    figure, plot(Proy(:,istart:istep:iend), ECh1dBa(:,istart:istep:iend),'o-')
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    xlabel('x (m)','FontSize',16);  ylabel('Echo (dB)','FontSize',16);
    title(['Echo profiles from: ' handles.StartDateMonitor.String ' to ' handles.EndDateMonitor.String])
    set(gca,'linewidth',2,'fontname','times','fontsize',16)
    figure(1)
%     print('-dpng','-r300',['EchoProfiles_30_' handles.StartDateMonitor.String '_' handles.EndDateMonitor.String '.png'])
 
    save('ForNils.mat','Proy','ECh1dBa','ECh1dB','TV')
    %HydroSenSoft
    % save('HSS01.mat','Proy','ECh1dBa','istart','iend','istep')
    
%     figure, plot(Proy(:,istart:istep:iend), gradient(ECh1dBa(:,istart:istep:iend)),'o-')
%     set(gcf,'units','normalized','outerposition',[0 0 1 1])
%     xlabel('BoxAverageWindow (m)','FontSize',16);  ylabel('Echo (dB)','FontSize',16);
%     title('(d Echo) profiles')
%     set(gca,'linewidth',2,'fontname','times','fontsize',16)
  
else
    msgbox('Check input parameters')
end

% --- Executes on button press in ClosePlots.
function ClosePlots_Callback(hObject, eventdata, handles)
% hObject    handle to ClosePlots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%close all open Figures
%rui here
delete( setdiff( findall(0, 'type', 'figure'), InfraSafeGUI2025_V7 ) );
hfig=InfraSafeGUI2025_V7;
jFrame = get(hfig, 'JavaFrame');
jFrame.setMaximized(1);


function dThresh1_Callback(hObject, eventdata, handles)
% hObject    handle to dThresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dThresh1 as text
%        str2double(get(hObject,'String')) returns contents of dThresh1 as a double


% --- Executes during object creation, after setting all properties.
function dThresh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dThresh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MonitorRun2.
function MonitorRun2_Callback(hObject, eventdata, handles)
% hObject    handle to MonitorRun2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% adcp=handles.ADCPChannel.String;
% frequency=str2num(handles.ADCPFrequency.String);
% StartDate=handles.StartDateMonitor.String;
% EndDate=handles.EndDateMonitor.String;
% box=str2num(handles.BoxAverageWindow.String);
% WorkFolder=handles.OutputFolder.String;
% %dThresh=str2num(handles.DerivativeThreshold.String);
% RiverWidth=str2num(handles.ChannelWidth.String);
Flag03=fCheckValuesMonitorCalib(handles);
WorkFolder=get(handles.OutputFolder,'String');
if Flag03
if iscell(WorkFolder)
    WorkingFolder=WorkFolder{1}; %'C:\Users\Rui Aleixo\SharePoint\Massimo Guerrero\Kokel_Monitoring\Risultati_';
else
    WorkingFolder=WorkFolder;
end
listing_res=dir([WorkingFolder]); 
% 
% WorkingFolder=WorkFolder; %'C:\Users\Rui Aleixo\SharePoint\Massimo Guerrero\Kokel_Monitoring\Risultati_';
% listing_res=dir([WorkingFolder{1}]); 

    [ECh1dB, Proy, WT, TV]=fReadDataMonitor2(handles);
    
    %% clean profiles
    NoiseLevel=str2num(handles.NoiseLevel.String);
    %         Lmax=str2num(handles.ChannelWidth.String);
    Lused=str2num(handles.StopAnalysis.String);
    
    ECh1dBa=fCleanProfilesStandard(ECh1dB,Proy,NoiseLevel,Lused);
    
    istart=str2num(handles.StartProfile.String);
    istep=str2num(handles.StepProfile.String);
    iend=str2num(handles.EndProfile.String);
    
    if iend==-1
        iend=size(ECh1dBa,2);
    end
    figure, plot(Proy(:,istart:istep:iend), ECh1dBa(:,istart:istep:iend),'o-')
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    xlabel('x (m)','FontSize',16);  ylabel('Echo (dB)','FontSize',16);
    % rui=10;
else
    msgbox('Check input data')
end


% --- Executes on button press in ClosePlots2.
function ClosePlots2_Callback(hObject, eventdata, handles)
% hObject    handle to ClosePlots2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete( setdiff( findall(0, 'type', 'figure'), InfraSafeGUI2025_V7 ) );
hfig=InfraSafeGUI2025_V7;
jFrame = get(hfig, 'JavaFrame');
jFrame.setMaximized(1);
%clc

function Method02Lim2_Callback(hObject, eventdata, handles)
% hObject    handle to Method02Lim2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Method02Lim2 as text
%        str2double(get(hObject,'String')) returns contents of Method02Lim2 as a double


% --- Executes during object creation, after setting all properties.
function Method02Lim2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Method02Lim2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Method03Crop1_Callback(hObject, eventdata, handles)
% hObject    handle to Method03Crop1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Method03Crop1 as text
%        str2double(get(hObject,'String')) returns contents of Method03Crop1 as a double


% --- Executes during object creation, after setting all properties.
function Method03Crop1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Method03Crop1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Method03Crop2_Callback(hObject, eventdata, handles)
% hObject    handle to Method03Crop2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Method03Crop2 as text
%        str2double(get(hObject,'String')) returns contents of Method03Crop2 as a double


% --- Executes during object creation, after setting all properties.
function Method03Crop2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Method03Crop2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Method02Lim1_Callback(hObject, eventdata, handles)
% hObject    handle to Method02Lim1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Method02Lim1 as text
%        str2double(get(hObject,'String')) returns contents of Method02Lim1 as a double


% --- Executes during object creation, after setting all properties.
function Method02Lim1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Method02Lim1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function echosed_Callback(hObject, eventdata, handles)
% hObject    handle to echosed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function AboutMenu_Callback(hObject, eventdata, handles)
% hObject    handle to AboutMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'About'; ' ';'Developed by:      ';' ';'Massimo Guerrero & Rui Aleixo';'';...
        'University of Bologna - 2018-2019'},'About')
% \n  \n \n University of Bologna'
% --- Executes on button press in ExportData.
function ExportData_Callback(hObject, eventdata, handles)
% hObject    handle to ExportData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
progressbar('Exporting Data')
% tic
TC=handles.TV; %for Massimo
C=handles.C;
dk1=handles.dk1;
dk2=handles.dk2;
ABR=handles.abr;
Quality=handles.Quality;
progressbar(20/100)
AA=Quality{1}; BB=Quality{2};
RR2=Quality{3}; SSSE=Quality{4};
RRMSE=Quality{5}; RR21=Quality{6};
RRMSE1=Quality{7-1}; %Rui
Quality={AA, BB, RR2, SSSE, RRMSE,RR21,RRMSE1};
progressbar(40/100)

clk=clock;

car=''; car1='';
if clk(4)==0
    car='0';
end
if clk(2)<10
    car1='0';
end
progressbar(70/100)
%appendname=[num2str(clk(1)) '_' car1 num2str(clk(2)) '_' num2str(clk(3)) car num2str(clk(4)) num2str(clk(5)) ];
Str=fClock2Str();
outfilename1=[Str '_Data_Matlab' '.mat'];
save(outfilename1,'TC','C','dk1','dk2','ABR','AA','BB','RR2','SSSE','RRMSE',...
                 'RR21','RRMSE1');

pause(3)
progressbar(85/100)
outfilename2=[Str '_Data' '.csv'];

TC=m2xdate(TC');
[nx,ny]=size(TC);
if nx<ny
    TC=TC';
end
[nx,ny]=size(ABR);
if nx<ny
    ABR=ABR';
end
[nx,ny]=size(dk1);
if nx<ny
    dk1=dk1';
end
[nx,ny]=size(dk2);
if nx<ny
    dk2=dk2';
end
[nx,ny]=size(C);
if nx<ny
    C=C';
end
OutDate=[TC C ABR dk1 dk2];
dlmwrite(outfilename2,OutDate)
% xlswrite(outfilename,m2xdate(TV)); 
% xlswrite(outfilename,C,'B2');     
pause(2)
% pause(2)
progressbar(100/100)
msgbox('Data Exported')

% --- Executes during object creation, after setting all properties.
function ExportData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExportData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function RawDataFolder_Callback(hObject, eventdata, handles)
% hObject    handle to RawDataFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RawDataFolder as text
%        str2double(get(hObject,'String')) returns contents of RawDataFolder as a double


% --- Executes during object creation, after setting all properties.
function RawDataFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RawDataFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OrganizedDataFolder_Callback(hObject, eventdata, handles)
% hObject    handle to OrganizedDataFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OrganizedDataFolder as text
%        str2double(get(hObject,'String')) returns contents of OrganizedDataFolder as a double



function OutputFolder_Callback(hObject, eventdata, handles)
% hObject    handle to OutputFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OutputFolder as text
%        str2double(get(hObject,'String')) returns contents of OutputFolder as a double


% --- Executes during object creation, after setting all properties.
function OutputFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OutputFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ResetPlot.
function ResetPlot_Callback(hObject, eventdata, handles)
% hObject    handle to ResetPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.axes4,'reset')
handles.clri=1;
guidata(hObject,handles);



function FirstCalibXLS_Callback(hObject, eventdata, handles)
% hObject    handle to FirstCalibXLS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FirstCalibXLS as text
%        str2double(get(hObject,'String')) returns contents of FirstCalibXLS as a double


% --- Executes during object creation, after setting all properties.
function FirstCalibXLS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FirstCalibXLS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CalibXLS_Callback(hObject, eventdata, handles)
% hObject    handle to CalibXLS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CalibXLS as text
%        str2double(get(hObject,'String')) returns contents of CalibXLS as a double


% --- Executes during object creation, after setting all properties.
function CalibXLS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CalibXLS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CInstrument_Callback(hObject, eventdata, handles)
% hObject    handle to CInstrument (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CInstrument as text
%        str2double(get(hObject,'String')) returns contents of CInstrument as a double


% --- Executes during object creation, after setting all properties.
function CInstrument_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CInstrument (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function RunCalibration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RunCalibration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function BoxAverageWindowCalib_Callback(hObject, eventdata, handles)
% hObject    handle to BoxAverageWindowCalib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BoxAverageWindowCalib as text
%        str2double(get(hObject,'String')) returns contents of BoxAverageWindowCalib as a double


% --- Executes during object creation, after setting all properties.
function BoxAverageWindowCalib_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BoxAverageWindowCalib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% % --- Executes during object creation, after setting all properties.
% function CalibrationMethods_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to FitCalibrationMethods (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function FitCalibrationMethods_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FitCalibrationMethods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function ProfileAnalysisMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ProfileAnalysisMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function CalibrationButtons_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FitCalibrationMethods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% function CalibrationMethods_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to FitCalibrationMethods (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called


% % --- Executes on button press in Method02.
function Method02_Callback(hObject, eventdata, handles)
% hObject    handle to Method02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Method02

% --- Executes on button press in Method03.
function Method03_Callback(hObject, eventdata, handles)
% hObject    handle to Method02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Method02


% --------------------------------------------------------------------
function OpenFileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to OpenFileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% RALEIXO 20190129
filetoopen = uigetfile('*.echo');
fid = fopen(filetoopen);
tline = fgetl(fid);
% data = textscan(fid,'%s%s%s');
% txt = textscan(fid,'delimiter','\n'); 
% mm=1;
i=1;
while ischar(tline)
    disp(tline);
    tline = fgetl(fid);
    tmz{i}=tline;
%     a1b=textscan(fid,'%s');
i=i+1;
end

% set(handles.OutputFolder,'String',tmz{6});
% set(handles.CalibrationFolder,'String',tmz{8});
% set(handles.FirstCalibXLS,'String',tmz{10});
% set(handles.CalibXLS,'String',tmz{12});
% set(handles.CInstrument,'String',tmz{14});
% % set(handles.BoxAverageWindow,'String',tmz{20});
% set(handles.Method03Crop1,'String',tmz{16});
% set(handles.Method03Crop2,'String',tmz{18});
% set(handles.ProcessStartDate,'String',tmz{24});
% set(handles.ProcessEndDate,'String',tmz{26});
% set(handles.SmoothFactor,'String',tmz{22});
% set(handles.BoxAverageWindow,'String',tmz{20});

set(handles.OutputFolder,'String',tmz{6});
set(handles.CalibrationFolder,'String',tmz{8});
set(handles.FirstCalibXLS,'String',tmz{10});
set(handles.CalibXLS,'String',tmz{12});
set(handles.CInstrument,'String',tmz{14});
% set(handles.BoxAverageWindow,'String',tmz{20});
set(handles.Method03Crop1,'String',tmz{16});
set(handles.Method03Crop2,'String',tmz{18});
set(handles.ProcessStartDate,'String',tmz{28});
set(handles.ProcessEndDate,'String',tmz{30});
set(handles.SmoothFactor,'String',tmz{26});
set(handles.BoxAverageWindow,'String',tmz{24});

% Regarding the water level computation variables
handles.dhp=str2double(tmz{33});
handles.dh=str2double(tmz{35});
handles.WLFiguresToPlot=str2double(tmz{37});
% Regarding the water velocity computation variables
handles.echmin=str2double(tmz{40});
handles.dechmax=str2double(tmz{42});
handles.MinimumVelocityThreshold=str2double(tmz{44});
handles.WVFiguresToPlot=str2double(tmz{46});

handles.CrossSectionFolderDestination=tmz{49};
handles.CrossSectionFileName=deblank(tmz{51});
% handles.CrossSectionFolderFile=[tmz{49} '\' tmz{51} ];
set(handles.FlowSectionLocation,'String',[tmz{49} '\' tmz{51} ]);
guidata(hObject,handles);
% set(handles.CrossSectionFolderDestination,'String',tmz{40});
% set(handles.CrossSectionFileName,'String',tmz{42});
fclose(fid);
msgbox(['File ' filetoopen  ' read'])


% --------------------------------------------------------------------
function MenuClose_Callback(hObject, eventdata, handles)
% hObject    handle to MenuClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all force



function edit70_Callback(hObject, eventdata, handles)
% hObject    handle to edit70 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit70 as text
%        str2double(get(hObject,'String')) returns contents of edit70 as a double


% --- Executes during object creation, after setting all properties.
function edit70_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit70 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function InputData_Callback(hObject, eventdata, handles)
% hObject    handle to InputData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ForData_Callback(hObject, eventdata, handles)
% hObject    handle to ForData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OrganizerData_Callback(hObject, eventdata, handles)
% hObject    handle to OrganizerData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run FileOrganizer;


% --- Executes on button press in WaterLevel.
function WaterLevel_Callback(hObject, eventdata, handles)
% hObject    handle to WaterLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles;

WorkFolder=get(handles.OutputFolder,'String');
adcp=get(handles.ADCPChannel,'String');
frequency=str2num(get(handles.ADCPFrequency,'String'))*1000;
% listing_res=dir([WorkingFolder,adcp]);
progressbar('Processing...')
if iscell(WorkFolder)
    WorkingFolder=WorkFolder{1}; %'C:\Users\Rui Aleixo\SharePoint\Massimo Guerrero\Kokel_Monitoring\Risultati_';
else
    WorkingFolder=WorkFolder;
end
% listing_res=dir([WorkingFolder]); 

% WF=WorkingFolder{1}
listing_res=dir(WorkingFolder);

mbox=str2double(get(handles.BoxAverageWindow,'String'));
box=mbox(1);
start=handles.ProcessStartDate.String;
endng=handles.ProcessEndDate.String;

dhp=handles.dhp; %0; % Off-set needs to get the variables from the data input file
dh=handles.dh;   %dh=0;
[Tv,Wv,pv, wv, Vv, WTc, day, pday, wday, Iw,Rs,Id] = fReadParametersTempLevel2(WorkingFolder,listing_res,dhp, dh, start, endng);

WV=pv;

%Boxcar averagging for time vector
% box=30;%number of ens to be averaged
TV=(buffer(Tv,box));WV=(buffer(WV,box));%choosing the water level assessment
dTV=diff(TV)*86400;
n=size(TV);n=n(2);
for i=1:n
    I=find(dTV(:,i)>box*120);
    if isempty(I)
    else
        TV(:,i)=NaN;
        WV(:,i)=NaN;
        SKIP(i)=1;
    end
end
TV=nanmean(TV);TV=TV(1:end-1);
WV=nanmean(WV);WV=WV(1:end-1);

%preparing for interpolation
I=find(isnan(TV)==0);
In=find(isnan(TV)==1);nt=round((max(TV)-min(TV))/(120*box/86400));
TVd=interp1(I,TV(I),[1:nt],'linear','extrap');
%interpolation along time
I=find(isnan(WV)==0);
In=find(isnan(WV)==1);
WVint=interp1(TV(I),WV(I),TVd,'linear');

% close(100); close(200); close(300);

plotter=handles.WLFiguresToPlot;

% figure(100)
% subplot(211)
% plot(day,pday,day,wday)
% datetick('x','dd/mm/yy');ylabel('meters')
% title('daily depth in m');legend('Preasure transducer','Vertical beam')
% hold on,
% subplot(212)
% plot(Tv,WTc,'.')
% datetick('x','dd/mm/yy');ylabel('C°')
% title('Instrument temperature in C°');
% set(gcf,'units','normalized','outerposition',[0 0 1 1])
a1=find(Wv>15); a2=find(pv>15);
pv(a2)=NaN; Wv(a1)=NaN;
a3=find(Wv<-0.5); a4=find(pv<-0.5);
pv(a3)=NaN; Wv(a4)=NaN;
 figure('Name','Water Level'),
%     subplot(211)
    plot(Tv,pv,'k.'), hold on, plot(Tv,wv,'r.'), plot(Tv,Wv,'b.'), ...
        plot(TV,WV,'c+',TVd,WVint,'mo')
    % plot(Tv,[pv;wv;Wv]','.',TV,WV,'+',TVd,WVint,'o')
    datetick('x','dd/mm/yy');ylabel('meters')
    title('Instrument depth in m');
    legend('Pressure transducer','Vertical beam','Fitted','+Box car averaged','+Interpolated')
%     subplot(212)
%     plot(day,[100*Iw;100*Rs;Id]','o-')
%     datetick('x','dd/mm/yy');
%     title('Quality check, daily');legend('%good vertical beam','R-squared in %','Day for fitting')
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
progressbar('Processing...',0.5)
% if plotter==0
%     % ;Vv voltage
%     figure('Name','Water Level'),
% %     subplot(211)
%     plot(Tv,pv,'k.'), hold on, plot(Tv,wv,'r.'), plot(Tv,Wv,'b.'), ...
%         plot(TV,WV,'c+',TVd,WVint,'mo')
%     % plot(Tv,[pv;wv;Wv]','.',TV,WV,'+',TVd,WVint,'o')
%     datetick('x','dd/mm/yy');ylabel('meters')
%     title('Instrument depth in m');
%     legend('Pressure transducer','Vertical beam','Fitted','+Box car averaged','+Interpolated')
% %     subplot(212)
% %     plot(day,[100*Iw;100*Rs;Id]','o-')
% %     datetick('x','dd/mm/yy');
% %     title('Quality check, daily');legend('%good vertical beam','R-squared in %','Day for fitting')
%     set(gcf,'units','normalized','outerposition',[0 0 1 1])
%     
%     
%     % plot(pday,wday,'o',[0 10],[0 10],'-')
%     % title('presure vs. vertical beam check, daily');xlabel('pressure');ylabel('vertical beam')
%     
%     
%     figure(300)
%     
%     subplot(211), plot(Tv,pv,'k.'), hold on, plot(Tv,wv,'r.'), plot(Tv,Vv,'m.'); hold on
%     legend('Pressure transducer','Vertical beam','voltage (V)')
%     datetick('x','dd/mm/yy');
%     title('Level variables and Voltage control');xlabel('date');ylabel('Level/Tension (V)')
%     
%     subplot(234), plot(pday,wday,'o',[0 10],[0 10],'-'), axis square
%     title('presure vs. vertical beam check, daily');xlabel('pressure');ylabel('vertical beam')
%     
%     [rs00,ss00]=hist(pv,50);
%     [rs01,ss01]=hist(pv,50);
%     subplot(235), bar(ss00,100*rs00./sum(sum(rs00))), hold on, bar(10+ss01,100*rs01./sum(sum(rs01))); %axis square
%     title('presure vs. vertical beam check, daily');xlabel('pressure');ylabel('vertical beam')
%     
%     [rs1,ss1]=hist(Vv,50);
%     subplot(236), bar(ss1,rs1), axis square
%     title('presure vs. vertical beam check, daily');xlabel('pressure');ylabel('vertical beam')
%     set(gcf,'units','normalized','outerposition',[0 0 1 1])
% end
% disp('here')
% plot(Tv,WTc,'.')
% datetick('x','dd/mm/yy');ylabel('C°')
% title('Instrument temperature in C°');

TH=TV;
WaterLevelStatus=1;
handles.Tv=Tv;   %fit
handles.TH=TH;    %box car 
handles.TVd=TVd;  %interpolated 
handles.Wv=Wv;  %fitted
handles.WV=WV;  %box car average
handles.WVint=WVint;  %interpolated
handles.day=day; 
handles.pday=pday; 
handles.wday=wday; 
handles.dh=dh; 
% handles.LevelStatus=1;
handles.WaterLevelStatus=WaterLevelStatus;
guidata(hObject,handles); 

progressbar(1)
msgbox('Water level computed.')
% save HADCP_Analisys_Depth_1_L1 TH WV day pday wday dh
% %else;save HADCP_Analisys_Depth_1_L2 TH WV day pday wday dh;end


% --- Executes on button press in WaterVelocity.  %Rui Aleixo April-May
% 2019
function WaterVelocity_Callback(hObject, eventdata, handles)
% hObject    handle to WaterVelocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles;

selectedmode=get(handles.WLMethodButtons,'SelectedObject');

WorkFolder=get(handles.OutputFolder,'String');
adcp=get(handles.ADCPChannel,'String');
frequency=str2num(get(handles.ADCPFrequency,'String'))*1000;
% listing_res=dir([WorkingFolder,adcp]);
progressbar('Processing Velocity...')
if iscell(WorkFolder)
    WorkingFolder=WorkFolder{1}; %'C:\Users\Rui Aleixo\SharePoint\Massimo Guerrero\Kokel_Monitoring\Risultati_';
else
    WorkingFolder=WorkFolder;
end
% adcp='L1';%L1 is 600 kHz, L2 is 1200 kHz
% adcp=handles.ADCPChannel.String;
%listing_res=dir(['C:\Users\Rui Aleixo\SharePoint\Massimo Guerrero\Kokel_Monitoring\Risultati_L1 - Cópia\']); %%%%Folders in the data's folder
listing_res=dir(WorkingFolder);
% start='20171107';%fixing the data subset start
% endng='20171115';%fixing the data subset end

start=handles.ProcessStartDate.String;
endng=handles.ProcessEndDate.String;

%Beam angles in the x-y instrument coordinates (x from transducer 2 to 1; y from instrument to farfield)
b1=pi*70/180;b2=pi*110/180;

%Ambiguity velocity
if adcp=='L1'
    WV=4.60;
elseif adcp=='L2'
    WV=2.90;
end

I=0;%day index

Start=datenum(start,'yyyymmdd');
Endng=datenum(endng,'yyyymmdd');
colore='brkygcmbrkygcmbrkygcmbrkygcmbrkygcmbrkygcmbrkygcmbrkygcmbrkygcmbrkygcmbrkygcm';

for m_in=3:length(listing_res)
    if str2num(listing_res(m_in).name(1:8))>=str2num(start) & str2num(listing_res(m_in).name(1:8))<=str2num(endng);%fixing the data subset
            
%     A=load(strcat('C:\Users\Rui Aleixo\SharePoint\Massimo Guerrero\Kokel_Monitoring\Risultati_L1 - Cópia\','\',num2str(listing_res(m_in).name)));  
   A=load(strcat(handles.OutputFolder.String,'\',num2str(listing_res(m_in).name)));  
    t_=(A.Res{1});
    proy_=((A.Res{2}));  %% Distance from ADCP head in m
    ech1_=(A.Res{3});  %%%Echo beam1
    ech2_=(A.Res{4});  %%%Echo beam2
    v1_=-(A.Res{5})./1000;  %%%x direction velocity in m/s
    v2_=-(A.Res{6})./1000;  %%%y direction velocity in m/s
      
    
    i=find(t_>=Start & t_<=Endng);
    if isempty(i)==0
        I=I+1;t{I}=t_(i);v1{I}=v1_(:,i);v2{I}=v2_(:,i);proy{I}=proy_(:,i);day(I)=datenum(listing_res(m_in).name(1:8),'yyyymmdd');
        ech1{I}=ech1_(:,i);ech2{I}=ech2_(:,i);
        WN=size(proy{I});nens=WN(2);WN=WN(1);
        %Beam versors
        versoreb1(:,1)=zeros(WN,1)+cos(b1);versoreb1(:,2)=zeros(WN,1)+sin(b1);
        versoreb2(:,1)=zeros(WN,1)+cos(b2);versoreb2(:,2)=zeros(WN,1)+sin(b2);
        %Water velocity in beam coordinates (+ for ejecting velocities from transducers)
        for i=1:nens
            vb1{I}(:,i)=sum(([v1{I}(:,i) v2{I}(:,i)].*versoreb1)')';
            vb2{I}(:,i)=sum(([v1{I}(:,i) v2{I}(:,i)].*versoreb2)')';
            %WV limit trashold
            J=find(abs(vb1{I}(:,i))>WV | abs(vb2{I}(:,i))>WV);% | v1{I}(:,i)>5 v2{I}(:,i)>5;
            if isempty(J)==0
                vb1{I}(J,i)=NaN;v1{I}(J,i)=NaN;
                vb2{I}(J,i)=NaN;v2{I}(J,i)=NaN;
                clear J
            end
        end
        %Polar coordinates
        ro{I}=(v1{I}.^2+v2{I}.^2).^.5;
        ph{I}=atan2(v2{I},v1{I});             
        %figure(1),polar(ph{I},ro{I},[colore(I) 'o']);hold on
    end
    
    end
end

%Results from daily variables to entire period vectors 
Tv=[];v1v=[];v2v=[];vb1v=[];vb2v=[];rov=[];phv=[];ECH1=[];ECH2=[];
for i=1:I
    Tv=[Tv t{i}];
    v1v=[v1v v1{i}];
    v2v=[v2v v2{i}];    
    vb1v=[vb1v vb1{i}];
    vb2v=[vb2v vb2{i}];    
    rov=[rov ro{i}];
    phv=[phv ph{i}];
    ECH1=[ECH1 ech1{i}];ECH2=[ECH2 ech2{i}];
end

%Minimum echo treshold (noise floor level)
ECH=ECH1+ECH2;echmin=100;
[I J]=find((ECH)>=echmin);for i=1:length(I),ECHx(I(i),J(i))=1;end;
[I J]=find((ECH)<echmin);for i=1:length(I),ECHx(I(i),J(i))=NaN;end;
%Maximum echo derivative treshold (bank return)
dechmax=10;
ECHx1=ECHx;ECHx2=ECHx;
for j=1:length(Tv)
    [I1]=find(diff(ECH1(:,j))>dechmax);[I2]=find(diff(ECH2(:,j))>dechmax);
    if isempty(I1);Ix1(j)=NaN;else;Ix1(j)=min(I1);ECHx1(Ix1(j)+1:end,j)=NaN;end;
    if isempty(I2);Ix2(j)=NaN;else;Ix2(j)=min(I2);ECHx2(Ix2(j)+1:end,j)=NaN;end;
end
%Limiting to the closest position of bank return in beam1-2
IX1=nanmedian(Ix1);IX2=nanmedian(Ix2);
Ix=min([IX1 IX2]);
for j=1:length(Tv)
    ECHx(Ix+1:end,j)=NaN;
end
%Minimum velocity magnitude trashold
vmin=.1;
[I J]=find((rov)<vmin);for i=1:length(I),ECHx(I(i),J(i))=NaN;end;

%Tresholding
Vb1v=vb1v(1:IX1,:).*ECHx1(1:IX1,:);
Vb2v=vb2v(1:IX2,:).*ECHx2(1:IX2,:);
V1v=v1v(1:Ix,:).*ECHx(1:Ix,:);
V2v=v2v(1:Ix,:).*ECHx(1:Ix,:);
ROv=rov(1:Ix,:).*ECHx(1:Ix,:);


%Boxcar averagging for time vector
% box=30;%number of ens to be averaged ()
box=str2num(handles.BoxAverageWindow.String);
TV=(buffer(Tv,box));
dTV=diff(TV)*86400;%distance between samples in sec
n=size(TV);n=n(2);
for i=1:n;
    I=find(dTV(:,i)>box*120);%maximal distance between sample admitted (3600 sec)
    if isempty(I)
        SKIP(i)=0;
    else
        TV(:,i)=NaN;
        SKIP(i)=1;
    end
end
TV=nanmean(TV);TV=TV(1:end-1);
%Boxcar averagging for velocity matrixes
for i=1:Ix
    V1v_=V1v(i,:);V2v_=V2v(i,:);ROv_=ROv(i,:);
    V1v_=(buffer(V1v_,box));V2v_=(buffer(V2v_,box));ROv_=(buffer(ROv_,box));
    V1V(i,:)=nanmedian(V1v_);V2V(i,:)=nanmedian(V2v_);ROV(i,:)=nanmedian(ROv_);
    V1V(i,find(SKIP==1))=NaN;V2V(i,find(SKIP==1))=NaN;ROV(i,find(SKIP==1))=NaN;
end
for i=1:IX1
    Vb1v_=Vb1v(i,:);Vb1v_=(buffer(Vb1v_,box));
    Vb1V(i,:)=nanmedian(Vb1v_);Vb1V(i,find(SKIP==1))=NaN;
end
for i=1:IX2
    Vb2v_=Vb2v(i,:);Vb2v_=(buffer(Vb2v_,box));
    Vb2V(i,:)=nanmedian(Vb2v_);Vb2V(i,find(SKIP==1))=NaN;
end
Vb1V=Vb1V(:,1:end-1);Vb2V=Vb2V(:,1:end-1);
V1V=V1V(:,1:end-1);V2V=V2V(:,1:end-1);ROV=ROV(:,1:end-1);

figure('Name','Mean Velocities'), hold on;
subplot(211)
plot(Tv,nanmean(v1v),'.r',Tv,nanmean(v2v),'+r',Tv,nanmean(rov),'og',...
    Tv,nanmean(vb1v),'.b',Tv,nanmean(vb2v),'+b')
datetick('x','dd/mm/yy');ylabel('m/s'),legend('Vx','Vy','Magnitude','Vb1','Vb2')
title('Averaged velocities');

subplot(212)
plot(Tv,nanmean(rad2deg(phv)),'.')
datetick('x','dd/mm/yy');ylabel('°')
title('Averaged direction');
set(gcf,'units','normalized','outerposition',[0 0 1 1])


kk=size(ECH1);kk=kk(2);
k=[1:10:kk];

% figure(3)
if 0
figure('Name','Velocity Profiles and Gradients'), hold on;
subplot(2,2,1);plot(proy_(:,1),ECH1(:,k))
subplot(2,2,2);plot(proy_(:,1),ECH2(:,k))
subplot(2,2,3);plot(proy_(2:end,1),diff(ECH1(:,k)))
subplot(2,2,4);plot(proy_(2:end,1),diff(ECH2(:,k)))
set(gcf,'units','normalized','outerposition',[0 0 1 1])

figure(4)
subplot(2,2,1);plot(proy_(:,1),v1v.*ECHx,'.-');
subplot(2,2,2);plot(proy_(1:Ix,1),V1V,'.-');
subplot(2,2,4);plot(Tv,Ix1,'o',Tv,Ix2,'.r')
datetick('x','dd/mm/yy');

figure(5);hold on
subplot(2,1,1)
plot(Tv,vb1v(1:3:Ix,:)'.*ECHx(1:3:Ix,:)','.');
datetick('x','dd/mm/yy');ylabel('m/s')
subplot(2,1,2)
plot(Tv,vb2v(1:3:Ix,:)'.*ECHx(1:3:Ix,:)','.');
datetick('x','dd/mm/yy');ylabel('m/s')

figure(6)
plot(Tv,rov(1:3:Ix,:)'.*ECHx(1:3:Ix,:)','.',TV,ROV,'+');
datetick('x','dd/mm/yy');ylabel('m/s')
end

figure('Name','Contours'), hold on;
% figure(7);hold on
subplot(3,2,1), contourf([1:length(TV)],proy_(1:Ix,1),ROV)
ylabel('m')

% figure(8);hold on
subplot(3,2,2), 
contourf([1:length(TV)],proy_(1:Ix,1),V1V)
ylabel('m')

% figure(9);hold on
subplot(3,2,3), 
contourf([1:length(TV)],proy_(1:Ix,1),V2V)
ylabel('m')

% figure(10);hold on
subplot(3,2,4), 
contourf([1:length(TV)],proy_(1:IX1,1),Vb1V)
ylabel('m')

subplot(3,2,5), 
% figure(11);hold on
contourf([1:length(TV)],proy_(1:IX2,1),Vb2V)
ylabel('m')
set(gcf,'units','normalized','outerposition',[0 0 1 1])

TV1=TV;
PRO=proy_(1:Ix,1);
handles.TVv=TV;
handles.V1V=V1V;
handles.PRO=PRO;
guidata(hObject,handles);
% guidata(PRO,handles);
% guidata(TV1,handles);


msgbox('Velocity computed.')
%%%% xlswrite('C:\Users\User2\Documents\Lavori\Kokel_Monitoring\ADCP_Depth_data.xlsx',[Tv;pv;wv;Wv]','data')


% --- Executes on button press in FlowRate.
function FlowRate_Callback(hObject, eventdata, handles)
% hObject    handle to FlowRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles;
%load HADCP_Analisys_Depth_1_L1
PRO=handles.PRO;
TV=handles.TVv;
V1V=handles.V1V;
V2V=V1V;
% load HADCP_Analisys_Velocity_1_L2
% load HADCP_Analisys_Depth_1_L1;
% TH1=TH;WV1=WV;
Levelselectedmode=get(handles.WLMethodButtons,'SelectedObject');
LevelSelected=get(Levelselectedmode,'String');
% disp('Running Calibration')

if strcmp(LevelSelected,'Fitted')
    TH1=handles.Tv;
    WV1=handles.Wv;
    disp('Fitted')
elseif strcmp(LevelSelected,'Box car AVG')
    TH1=(handles.TH);
    WV1=(handles.WV);
    disp('Box car AVG')
elseif strcmp(LevelSelected,'Interpolated')
    TH1=(handles.TVd);
    WV1=(handles.WVint);
    disp('Interpolated')
end

% handles.Tv=Tv;   %fit
% handles.TH=TH;    %box car
% handles.TVd=TVd;  %interpolated
% handles.Wv=Wv;  %fitted
% handles.WV=WV;  %box car average
% handles.WVint=WVint;  %interpolated



% load HADCP_Analisys_Depth_1_L2;
TH2=TH1;WV2=WV1;
%load Pressure_Sensor_Depth
% load cross_section
filelocation=handles.CrossSectionFolderDestination;
filenameCS=handles.CrossSectionFileName;
[num,txt,raw] = xlsread([filelocation '\' filenameCS]);
XY=num;
clear txt raw;
%Put together the positions of measured (i.e. PRO) and missing velocity values in the cross-section (XY)
PRO1=[[min(XY(:,1))+.5:.5:PRO(1)-.5]';PRO;[PRO(end)+.5:.5:max(XY(:,1))]']; 
%%%%%%%%%%cells dimensions!!! bring it from cell calculation

%ADCP axis level

% ADCPL=.8;
ADCPL=str2double(handles.ADCPLevel.String);

% watch out!!! can be erased
%merging water level readings from L1 and L2: keep L1 when avaliable otherwise L2
I=0;
for i=1:length(TH2)
    [tm j]=min(abs(TH1-TH2(i)));
    if tm<3600/86400
        I=I+1;
%        WL(I)=nanmean([WV1(j) WV2(i)]);
        WL(I)=WV1(j);DWL(I)=WV1(j)-WV2(i);
    else
        I=I+1;WL(I)=WV2(i);DWL(I)=nan;
    end
end
TH=TH2;
%Water level
WL=WL+ADCPL;

% figure(100)
% plot(XY(:,1),XY(:,2),'-o');title('Cross-section');xlabel('Distance (m)');ylabel('Elevation (m)')

%Water velocity level
y=ADCPL-interp1(XY(:,1),XY(:,2),PRO);
Y=nanmean(y);
%Log profile: u/u*=2.5*ln(y/y0)+8.5;
y0=10^-1;c=2.5.*log(Y./y0)+8.5;

%%%%% attention to 0.5!!!!!
I=0;
for i=1:length(TV)
    [tm, j]=min(abs(TH-TV(i)));
    if tm<3600/86400
        I=I+1;TVH(I)=TV(i);WLH(I)=WL(j);V1VH(:,I)=V1V(:,i);J=find(V1VH(:,I)<0);V1VH(J,I)=NaN;
        depth(:,I)=WL(j)-interp1(XY(:,1),XY(:,2),PRO);%water depthes along the HADCP-measured section
        depth1(:,I)=WL(j)-interp1(XY(:,1),XY(:,2),PRO1);%water depthes along the entire section
        J=find(depth1(:,I)<0);depth1(J,I)=0;
        nv=find(isnan(V1V(:,i))==0);%positions with good values
        nV(I)=length(nv)/length(PRO);%total positions with good values in % of HADCP-measured section width
        DEPTHV(I)=mean(depth(nv,I));%mean water depth at positions with good values
        CROSSV(I)=nansum(.5*depth(nv,I));%forL2 cross-section area for positions with good values
        CROSS(I)=nansum(.5*depth(:,I));%forL2 cross-section area for HADCP-measured section
        CROSS1(I)=nansum(.5*depth1(:,I));%forL2 cross-section area for the entire section
        %cross(:,I)=1.0*depth(:,I);cross1(:,I)=1.0*depth1(:,I);%for L1
    end
end

%attention! nbins, 
%Searching for beam limited by low water levels
J=find(WLH<(ADCPL+(25*.5+1)*sin(deg2rad(1.5/2))));
%this is valid for 1200 kHz having beam width of 1.5°, 25 bins of 0.5 m, 1 m blancking distance

DEPTH=nanmean(depth);%mean water depth of HADCP-measured section
DEPTH1=nanmean(depth1);%mean water depth of entire section
U1=nanmean(V1VH);

ustar=U1./c;
U=ustar.*(2.5.*log((0.368*DEPTHV)/y0)+8.5);
C=U./ustar;
ks=9.81^.5*C.*(DEPTHV).^(-1/6);

nS=.8*(CROSSV./CROSS1).^.78;%this is <1 becouse of the HADCP measures only a part of the entire cross-section 
%%%here you have the calibration coefficients
nU=U1./U;%this can be >1 or <1 depending on the HADCP measures at a high (>1 for low water depth) or low (<1 for high water depth) level of the wetted area
nD=(DEPTHV./DEPTH1).^(2/3);%this is >1 becouse of the HADCP measure the deepest portion of the entire cross-section

Q=U1.*CROSSV;
Q1=Q./nU;
Q2=Q./nD;
Q3=Q./nS;
Q4=Q./nD./nS./nU;

%%% WARNING!!!! 25 bins 
%Searching for beam limited by low water levels and with at least 15% good bins
I=find(nV>=0.15 & WLH>=(ADCPL+(25*.5+1)*deg2rad(1.5/2)));

% figure(1)
% subplot(2,1,1);plot(TVH,U1,'.',TVH(I),U1(I),'+',TVH(J),U1(J),'o');title('Water Velocity')
% datetick('x','dd/mm/yy');ylabel('m/s')
% subplot(2,1,2);plot(TVH,WLH,'.',TVH(I),WLH(I),'+',TVH(J),WLH(J),'o');title('Water level')
% datetick('x','dd/mm/yy');ylabel('m')

figure(2)
subplot(2,2,1);plotyy(TVH,nV,TVH,WLH);title('Bins with values')
subplot(2,2,2);plotyy(TVH,nS,TVH,WLH);title('Cross-section in the ensonified region')
subplot(2,2,3);plotyy(TVH,nD,TVH,WLH);title('Depth with values over actual depth')
subplot(2,2,4);plotyy(TVH,nU,TVH,WLH);title('Measured over mean velocity')
set(gcf,'units','normalized','outerposition',[0 0 1 1])

figure(3);hold on;
subplot(2,2,1);plot(U1,WLH,'.');title('U-H relation');xlabel('m/s');ylabel('m')
subplot(2,2,2);plot(CROSS1,WLH,'.',CROSS,WLH,'-',CROSS1-CROSS,WLH,'+');title('A-H relation');xlabel('m^2');ylabel('m');legend('Total section','Measured from HADCP','Difference')
subplot(2,2,3);plot(nS,WLH,'o',nD,WLH,'.');title('nS-H & nD-H relation');legend('nS','nD');xlabel('-');ylabel('m')
subplot(2,2,4);plot(nU,WLH,'.');title('nU-H relation');xlabel('-');ylabel('m')
set(gcf,'units','normalized','outerposition',[0 0 1 1])

% figure(4);hold on;
% subplot(1,2,1)
% plot(Q,WLH,'+k',Q1,WLH,'.r',Q2,WLH,'.g',Q3,WLH,'.y',Q4(I),WLH(I),'.b',...
%     [14 17.7 8.2 29.1 15.3 20.6 230 120 65 19 17],[0.79 0.70 0.47 1.25 1 1.1 2.8 2.15 1.7 1.09 1.04],'ok');
% xlabel('Flow discharge (m^3/s)');ylabel('Water level (m)');
% legend('Q_r_a_w','Q_r_a_w/n_u','Q_r_a_w/n_h','Q_r_a_w/n_x_s','Q_r_a_w/n_x_sn_hn_u','ADCP')
% subplot(1,2,2)
% plot(nD.*nS,WLH,'.b')
% xlabel('n_x_sn_h');ylabel('m');

figure(4);hold on;
subplot(1,2,1)
plot(Q,WLH,'+k',Q1,WLH,'.r',Q2,WLH,'.g',Q3,WLH,'.y',Q4(I),WLH(I),'.b');
xlabel('Flow discharge (m^3/s)');ylabel('Water level (m)');
legend('Q_r_a_w','Q_r_a_w/n_u','Q_r_a_w/n_h','Q_r_a_w/n_x_s','Q_r_a_w/n_x_sn_hn_u','ADCP')
subplot(1,2,2)
plot(nD.*nS,WLH,'.b')
xlabel('n_x_sn_h');ylabel('m');
set(gcf,'units','normalized','outerposition',[0 0 1 1])

TQ=TVH(I);QQ=Q4(I);WLQ=WLH(I);

mymodel='a*x^b';
ii=find(isnan(QQ)==00 & isnan(WLQ)==0); 
QH=fit(QQ(ii)',WLQ(ii)',mymodel);
HQ=fit(WLQ(ii)',QQ(ii)',mymodel);
% figure(4);subplot(1,2,1);hold on;plot(QQ(ii),QH(QQ(ii)),'k.',HQ(WLQ(ii)),WLQ(ii),'ko');

figure('Name','Hydraulic Variables')
subplot(3,1,1);plot(TVH,U1,'.',TVH(I),U1(I),'+',TVH(J),U1(J),'o');title('Water Velocity')
datetick('x','dd/mm/yy');ylabel('m/s')
subplot(3,1,2);plot(TVH,WLH,'.',TVH(I),WLH(I),'+',TVH(J),WLH(J),'o');title('Water level')
datetick('x','dd/mm/yy');ylabel('m')
subplot(3,1,3);plot(TQ,QQ,'.');title('Flow ')
datetick('x','dd/mm/yy');ylabel('m^3/s')
set(gcf,'units','normalized','outerposition',[0 0 1 1])

% TQ=TVH(I);QQ=Q4(I);WLQ=WLH(I); 
% Q=U1.*CROSSV;
% Q1=Q./nU;
% Q2=Q./nD;
% Q3=Q./nS;
% Q4=Q./nD./nS./nU;

TV1=TV;
% PRO=proy_(1:Ix,1);
handles.TQ=TQ;
handles.QQ=QQ;
handles.WLQ=WLQ;

guidata(hObject,handles);

% save HADCP_Analysis_Q TQ QQ WLQ ADCPL QH HQ
% 
% xlswrite('C:\Users\Massimo\OneDrive - Alma Mater Studiorum Università di Bologna\Kokel_Monitoring\QH relation\ADCP_Analysis_Q_01.2016_05.2018_L2.xlsx',...
%    [TVH(I)' WLH(I)' Q4(I)'],'Q-HWL1&2')





% WaterVelocityStatus=handles.WaterVelocityStatus;
% WaterLevelStatus=handles.WaterLevelStatus;
% % WaterLevelStatus=1;
% if WaterVelocityStatus==1 && WaterLevelStatus==1
%     
%     TH=handles.TH;
%     WV=handles.WV;
%     day=handles.day;
%     pday=handles.pday;
%     wday=handles.wday;
%     dh=handles.dh;
%     % handles.LevelStatus=1;
%     
%     % load HADCP_Analisys_Velocity_1_L1
%     TV=handles.TVv;
%     V1V=handles.V1V;
%     PRO=handles.PRO;
%     V1Vext=handles.V1Vext;
%     V1Vext_=handles.V1Vext_;
%     PROext=handles.PROext;
%     
%     filelocation=handles.CrossSectionFolderDestination;
%     filenameCS=handles.CrossSectionFileName;
%     
% %     load cross_section
%     
%     [num,txt,raw] = xlsread([filelocation '\' filenameCS]);
%     XY=num;
%     clear txt raw;
%     %Eneabling the one beam solution where thers' only one beam
%     PRO=PROext;
%     V1V=V1Vext_;
%     
%     ADCPX=35;%ADCP position along the cross-section
%     Range=PRO(end);%maximum range
%     PRO=PRO+ADCPX;
%     dPRO=1;%velocity profile spacing (cell width)
%     
%     %Position of measure and missing velocity values
%     PRO1=[[min(XY(:,1))+dPRO:dPRO:PRO(1)-.5]';PRO;[PRO(end)+dPRO:dPRO:max(XY(:,1))]'];
%     
%     ADCPL=2.8;%ADCP axis level
%     WL=WV;%Water level
%     
%     figure(3000);axes('dataaspectratio',[1 1 1]);hold on
%     plot(XY(:,1),XY(:,2),'-o',...
%         PRO,repmat(ADCPL,1,length(PRO)),'r+',...
%         PRO1,repmat(max(WL),1,length(PRO1)),'ob');
%     title('Cross-section');xlabel('Distance (m)');ylabel('Elevation (m)')
%     
%     %Water velocity level
%     y=ADCPL-interp1(XY(:,1),XY(:,2),PRO);
%     Y=nanmean(y);
%     %Log profile: u/u*=2.5*ln(y/y0)+8.5;
%     y0=10^-2;c=2.5.*log(Y./y0)+8.5;
%     
%     I=0;
%     for i=1:length(TV)
%         [tm, j]=min(abs(TH-TV(i)));
%         if tm<3600/86400
%             I=I+1;TVH(I)=TV(i);WLH(I)=WL(j);V1VH(:,I)=V1V(:,i);J=find(V1VH(:,I)<0);V1VH(J,I)=NaN;
%             depth(:,I)=WL(j)-interp1(XY(:,1),XY(:,2),PRO);%water depthes along the HADCP-measured section
%             depth1(:,I)=WL(j)-interp1(XY(:,1),XY(:,2),PRO1);%water depthes along the entire section
%             J=find(depth1(:,I)<0);depth1(J,I)=NaN;
%             nv=find(isnan(V1V(:,i))==0);%positions with good values
%             nV(I)=length(nv)/length(PRO);%total positions with good values in % of HADCP-measured section width
%             DEPTHV(I)=mean(depth(nv,I));%mean water depth at positions with good values
%             CROSSV(I)=nansum(dPRO*depth(nv,I));%cross-section area for positions with good values
%             CROSS(I)=nansum(dPRO*depth(:,I));%cross-section area for HADCP-measured section
%             CROSS1(I)=nansum(dPRO*depth1(:,I));%cross-section area for the entire section
%             if isempty(nv)==1;CROSSV(I)=NaN;end
%         end
%     end
%     
%     DEPTH=nanmean(depth);%mean water depth of HADCP-measured section
%     DEPTH1=nanmean(depth1);%mean water depth of entire section
%     U1=nanmean(V1VH);
%     
%     ustar=U1./c;
%     U=ustar.*(2.5.*log((0.368*DEPTHV)/y0)+8.5);
%     C=U./ustar;
%     ks=9.81^.5*C.*(DEPTHV).^(-1/6);
%     
%     KX=1;%%%this is just a calibration coefficient
%     nXS=CROSSV./CROSS1;%this is <1 becouse of the HADCP measures only a part of the entire cross-section
%     nU=U1./U;%this can be >1 or <1 depending on the HADCP measures at a high (>1 for low water depth) or low (<1 for high water depth) level of the wetted area
%     nH=KX*DEPTHV./DEPTH1;%this is >1 becouse of the HADCP measure the deepest portion of the entire cross-section
%     
%     Q=U1.*CROSSV;
%     Q1=Q./nU;
%     Q2=Q./nH;
%     Q3=Q./nXS;
%     Q4=Q./nH./nXS./nU;
%     
%     %Searching for beam limited by low water levels
%     J=find(WLH<(ADCPL+Range*sin(deg2rad(1.5/2))));%this is valid for 600 and 1200 kHz having beam width of 1.5°
%     I=find(nV>=0 & WLH>=(ADCPL+Range*sin(deg2rad(1.5/2))));
%     
%     figure(3001)
%     subplot(2,2,1);plot(TVH,U1,'.-',TVH(J),U1(J),'o')
%     datetick('x','dd/mm/yy');ylabel('m/s');title('Water velocity')
%     subplot(2,2,3);plot(TVH,WLH,'.-',TVH(J),WLH(J),'o')
%     datetick('x','dd/mm/yy');ylabel('m');title('Water level')
%     subplot(2,2,2);plotyy(TVH,U1,TVH,WLH)
%     title('Water velocity - Water level')
%     subplot(2,2,4);plot(TVH,Q4,'.-')
%     datetick('x','dd/mm/yy');ylabel('m^3/s');title('Water discharge')
%     
%     
%     figure(3002)
%     subplot(2,2,1);plotyy(TVH,nV,TVH,WLH);title('Bins with values')
%     subplot(2,2,2);plotyy(TVH,nXS,TVH,WLH);title('Cross-section in the ensonified region')
%     subplot(2,2,3);plotyy(TVH,nH,TVH,WLH);title('Depth with values over actual depth')
%     subplot(2,2,4);plotyy(TVH,nU,TVH,WLH);title('Measured over mean velocity')
%     
%     figure(3003);hold on;
%     subplot(2,2,1);plot(U1,WLH,'.');title('U-H relation');xlabel('m/s');ylabel('m')
%     subplot(2,2,2);plot(CROSS1,WLH,'.',CROSS,WLH,'-',CROSS1-CROSS,WLH,'+');title('A-H relation');xlabel('m^2');ylabel('m');legend('Total section','Measured from HADCP','Difference')
%     subplot(2,2,3);plot(nXS,WLH,'o',nH,WLH,'.');title('n_x_s-H & n_h-H relation');legend('n_X_S','n_h');xlabel('-');ylabel('m')
%     subplot(2,2,4);plot(nU,WLH,'.');title('n_u-H relation');xlabel('-');ylabel('m')
%     
%     figure(4);hold on;
%     subplot(2,1,1)
%     plot(Q,WLH,'+k',Q1,WLH,'.r',Q2,WLH,'.g',Q3,WLH,'.y',Q4,WLH,'.-b',...
%         [14.6 9.1],[1.95 1.38],'sqb');
%     text(14.6,1.95,'10/5/2016'), text(9.1,1.38,'17/11/2017')
%     xlabel('Flow discharge (m^3/s)');ylabel('Water level (m)');
%     legend('Q_r_a_w','Q_r_a_w/n_u','Q_r_a_w/n_h','Q_r_a_w/n_x_s','Q_r_a_w/n_x_sn_hn_u')%,'ADCP')
%     subplot(2,1,2)
%     plot(nH.*nXS.*nU,WLH,'.b')
%     xlabel('n_x_sn_hn_u');ylabel('m');
%     
%     TQ=TVH(I);QQ=Q4(I);WLQ=WLH(I);
%     
%     handles.TQ=TVH;
%     handles.Q1=Q1; handles.Q2=Q2; handles.Q3=Q3; handles.Q4=Q4;
%     handles.Q=Q;
%     handles.QQ=QQ;
%     handles.WLQ=WLQ;
%     handles.U1=U1;
%     handles.WLH=WLH;
%     handles.CROSS1=CROSS1; handles.CROSS=CROSS;
%     handles.nH=nH;
%     handles.nXS=nXS;
%     handles.nU=nU;
%     handles.TVH=TVH;
% elseif WaterLevelStatus==1 && WaterVelocityStatus==0
%     msgbox('You need to calculate Water Velocity.');
% elseif WaterLevelStatus==0 && WaterVelocityStatus==0
%     msgbox('You need to calculate Water Velocity and Water Velocity.');
% end
%     
%     
% 
% 
% handles.PRO=PRO;
% handles.V1Vext=V1Vext;
% handles.V1Vext_=V1Vext_;
% handles.PROext=PROext;
% handles.VelStatus=1;
guidata(hObject,handles);

% --- Executes on button press in RatingCurves.
function RatingCurves_Callback(hObject, eventdata, handles)
% hObject    handle to RatingCurves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% load Data_Output_20190123145857; 
TC=handles.TV;
Csediment=handles.C;
dk1=handles.dk1;
dk2=handles.dk2;
% load HADCP_Analisys_Velocity_1_L1
% load('HADCP_Analisys_Depth_1_L1')

load cross_section

PRO=handles.PRO;
% PROext=handles.PROext;
TV=handles.TVv; 

% V1V=handles.V1V; 
% V1Vext=handles.V1Vext; V1Vext_=handles.V1Vext_; 

TH=handles.TH; 
WV=handles.WV;  
day=handles.day; pday=handles.pday; 
wday=handles.wday; dh=handles.dh; 
%U1=handles.U1;
% WLH=handles.WLH;
WLH=handles.WV;
Q=handles.Q;
Q1=handles.Q1;
Q2=handles.Q2;
Q3=handles.Q3;
Q4=handles.Q4;
CROSS1=handles.CROSS1; CROSS=handles.CROSS;
nH=handles.nH;
nXS=handles.nXS;
nU=handles.nU;
TVH=handles.TVH;
%Eneabling the one beam solution where thers' only one beam 
PRO=PROext;
%V1V=V1V;%two beams solution (exclude all the cell with one beam only)
%V1V=V1Vext;%eneabling the one beam solution where thers' only one beam
% V1V=V1Vext_;%eneabling the one beam solution and extrapolation to the opposite bank

% ADCPX=35;%ADCP position along the cross-section
ADCPX=str2double(handles.ADCPLevel.String);
Range=PRO(end);%maximum range 
PRO=PRO+ADCPX;
dPRO=1;%velocity profile spacing (cell width)

%Position of measure and missing velocity values
PRO1=[[min(XY(:,1))+dPRO:dPRO:PRO(1)-.5]';PRO;[PRO(end)+dPRO:dPRO:max(XY(:,1))]'];

ADCPL=2.8;%ADCP axis level
WL=WV;%Water level


deltaT=3600;%maximum lag admitted (in sec.) between different datasets (i.e, WL, V and C)
I=0;
for i=1:length(TV)
%    [tm j]=min(abs(TH-TV(i)));if isnan(tm)==1;tm=deltaT;end
    [tc jj]=min(abs(TC-TV(i)));if isnan(tc)==1;tc=deltaT;end
    if tc<deltaT/86400  %tm<deltaT/86400 & 
        I=I+1;
        %TVH(I)=TV(i);WLH(I)=WL(j);V1VH(:,I)=V1V(:,i);J=find(V1VH(:,I)<0);V1VH(J,I)=NaN;
        CH(I)=Csediment(jj);dk1H(I)=dk1(jj);dk2H(I)=dk2(jj);
        %depth(:,I)=WL(j)-interp1(XY(:,1),XY(:,2),PRO);%water depthes along the HADCP-measured section
        %depth1(:,I)=WL(j)-interp1(XY(:,1),XY(:,2),PRO1);%water depthes along the entire section
        %J=find(depth1(:,I)<0); depth1(J,I)=NaN;
        %nv=find(isnan(V1V(:,i))==0);%positions with good values
        %nV(I)=length(nv)/length(PRO);%total positions with good values in % of HADCP-measured section width
        %DEPTHV(I)=mean(depth(nv,I));%mean water depth at positions with good values
        %CROSSV(I)=nansum(dPRO*depth(nv,I));%cross-section area for positions with good values
        %CROSS(I)=nansum(dPRO*depth(:,I));%cross-section area for HADCP-measured section
        %CROSS1(I)=nansum(dPRO*depth1(:,I));%cross-section area for the entire section
        %if isempty(nv)==1;CROSSV(I)=NaN;end
    end
end

% DEPTH=nanmean(depth);%mean water depth of HADCP-measured section
% DEPTH1=nanmean(depth1);%mean water depth of entire section
% U1=nanmean(V1VH);
% 
% ustar=U1./c;
% U=ustar.*(2.5.*log((0.368*DEPTHV)/y0)+8.5);
% C=U./ustar;
% ks=9.81^.5*C.*(DEPTHV).^(-1/6);
% 
% KX=1;%%%this is just a calibration coefficient
% nXS=CROSSV./CROSS1;%this is <1 becouse of the HADCP measures only a part of the entire cross-section 
% nU=U1./U;%this can be >1 or <1 depending on the HADCP measures at a high (>1 for low water depth) or low (<1 for high water depth) level of the wetted area
% nH=KX*DEPTHV./DEPTH1;%this is >1 becouse of the HADCP measure the deepest portion of the entire cross-section
% 
% Q=U1.*CROSSV;
% Q1=Q./nU;
% Q2=Q./nH;
% Q3=Q./nXS;
% Q4=Q./nH./nXS./nU;

% %Searching for beam limited by low water levels
% J=find(WLH<(ADCPL+Range*sin(deg2rad(1.5/2))));%this is valid for 600 and 1200 kHz having beam width of 1.5°
% I=find(nV>=0 & WLH>=(ADCPL+Range*sin(deg2rad(1.5/2))));
% 
% figure(1)
% subplot(3,2,1);plot(TVH,U1,'.-',TVH(J),U1(J),'o')
% datetick('x','dd/mm/yy');ylabel('m/s');title('Water velocity');legend('ADCP well submerged','surface reflection affected')
% subplot(3,2,2);plot(TVH,WLH,'.-',TVH(J),WLH(J),'o')
% datetick('x','dd/mm/yy');ylabel('m');title('Water level')
% subplot(3,2,3);plotyy(TVH,U1,TVH,WLH);title('Water velocity - Water level')
% subplot(3,2,4);plotyy(TVH,Q4,TVH,WLH);title('Water discharge - Water level')
% subplot(3,2,5);semilogy(TVH,CH,'.-')
% datetick('x','dd/mm/yy');ylabel('g/l');title('Concentration')
% subplot(3,2,6);plotyy(TVH,CH,TVH,WLH);title('Concentration - Water level')
% 
% 
% figure(2)
% subplot(2,2,1);plotyy(TVH,nV,TVH,WLH);title('Bins with values')
% subplot(2,2,2);plotyy(TVH,nXS,TVH,WLH);title('Cross-section in the ensonified region')
% subplot(2,2,3);plotyy(TVH,nH,TVH,WLH);title('Depth with values over actual depth')
% subplot(2,2,4);plotyy(TVH,nU,TVH,WLH);title('Measured over mean velocity')

% figure(3);hold on;
% subplot(2,2,1);plot(U1,WLH,'.');title('U-H relation');xlabel('m/s');ylabel('m')
% subplot(2,2,2);plot(CROSS1,WLH,'.',CROSS,WLH,'-',CROSS1-CROSS,WLH,'+');title('A-H relation');xlabel('m^2');ylabel('m');legend('Total section','Measured from HADCP','Difference')
% subplot(2,2,3);plot(nXS,WLH,'o',nH,WLH,'.');title('n_x_s-H & n_h-H relation');legend('n_X_S','n_h');xlabel('-');ylabel('m')
% subplot(2,2,4);plot(nU,WLH,'.');title('n_u-H relation');xlabel('-');ylabel('m')

% figure(4000)
% subplot(1,2,1);hold on
% plot(Q,WLH,'+k',Q1,WLH,'.r',Q2,WLH,'.g',Q3,WLH,'.y',Q4,WLH,'.-b',Q4(I),WLH(I),'ob',...
%     [14.6 9.1],[1.95 1.38],'sqb');
% text(14.6,1.95,'10/5/2016'), text(9.1,1.38,'17/11/2017')
% xlabel('Flow discharge (m^3/s)');ylabel('Water level (m)');
% legend('Q_r_a_w','Q_r_a_w/n_u','Q_r_a_w/n_h','Q_r_a_w/n_x_s','Q_r_a_w/n_x_sn_hn_u')%,'ADCP')
% subplot(1,2,2);hold on
% plot(nH.*nXS.*nU,WLH,'.b')
% xlabel('n_x_sn_hn_u');ylabel('m');

figure(4001)
scatter(Q4(I),WLH(I),100,U1(I));
xlabel('Flow discharge (m^3/s)');ylabel('Water level (m)');

% TQ=TVH(I);QQ=Q4(I);WLQ=WLH(I);CQ=CH(I);dk1Q=dk1H(I);dk2Q=dk2H(I);
TQ=TVH;
QQ=Q4;
WLQ=WLH;CQ=CH;dk1Q=dk1H;dk2Q=dk2H;

figure(4002)
subplot(2,1,1);hold on
plot(CQ,WLQ,'.-k',[.182 .206 .598 .622],[1.5 3.1 7.3 8.3],'sqr');
text(.182,1.5,'17/11/2017'),text(.206,3.1,'27/02/2018'),
text(.598,7.3,'15/12/2017'),text(.622,8.3,'20/03/2018')
xlabel('Concentration (g/l)');ylabel('Water level (m)');
legend('HaDcp','Physical sampling')
subplot(2,1,2);hold on
plot(CQ.*QQ,WLQ,'.-k');
xlabel('Sediment discharge (kg/s)');ylabel('Water level (m)');

% figure(16);hold on;
% scatter(QQ,CQ,50,log10(dk2Q./dk1Q));hold on
% plot([17/2 0.02/0.026 1.63/0.128],[2 0.026 0.128],'sq',[675/2.3 0.16/0.03 59.3/1.01],[2.3 0.03 1.01],'+')
% ylabel('Concentration (g/l)');xlabel('Flow discharge (m^3/s)');

% figure(7);hold on;
% semilogy(WLH,CH,'.-k');hold on
% ylabel('Concentration (g/l)');xlabel('Water level (m)');
% 
% figure(8);hold on;
% plot(diff(WLH),(CH(1:end-1)+CH(2:end))/2,'.-k');hold on
% ylabel('Concentration (g/l)');xlabel('Water level variation (m)');
% 
% figure(9);hold on;
% scatter(dk1Q,dk2Q,100,log10(CQ));
% xlabel('\sigma_s^2');ylabel('\alpha_s');


% --- Executes on button press in CloseFigures.
function CloseFigures_Callback(hObject, eventdata, handles)
% hObject    handle to CloseFigures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles = guidata(hObject);
delete( setdiff( findall(0, 'type', 'figure'), InfraSafeGUI2025_V7 ) );
% delete( setdiff( findall(0, 'type', 'figure'), InfraSafeGUI2025_V7 ) );
% disp('here')
%  handles;
% disp('here2')


% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Method01.
function Method01_Callback(hObject, eventdata, handles)
% hObject    handle to Method01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Method01



function FlowSectionLocation_Callback(hObject, eventdata, handles)
% hObject    handle to FlowSectionLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FlowSectionLocation as text
%        str2double(get(hObject,'String')) returns contents of FlowSectionLocation as a double


% --- Executes during object creation, after setting all properties.
function FlowSectionLocation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FlowSectionLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ADCPX_Callback(hObject, eventdata, handles)
% hObject    handle to ADCPX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ADCPX as text
%        str2double(get(hObject,'String')) returns contents of ADCPX as a double


% --- Executes during object creation, after setting all properties.
function ADCPX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ADCPX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ADCPLevel_Callback(hObject, eventdata, handles)
% hObject    handle to ADCPLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ADCPLevel as text
%        str2double(get(hObject,'String')) returns contents of ADCPLevel as a double


% --- Executes during object creation, after setting all properties.
function ADCPLevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ADCPLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit75_Callback(hObject, eventdata, handles)
% hObject    handle to edit75 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit75 as text
%        str2double(get(hObject,'String')) returns contents of edit75 as a double


% --- Executes during object creation, after setting all properties.
function edit75_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit75 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DisplaySection.
function DisplaySection_Callback(hObject, eventdata, handles)
% hObject    handle to DisplaySection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%filelocation=handles.CrossSectionFolderDestination;
%filenameCS=handles.CrossSectionFileName;
% [num,txt,raw] = xlsread([filelocation '\' filenameCS]);
SectionFilename=get(handles.FlowSectionLocation,'String');
[num,txt,raw] = xlsread([SectionFilename]);
XY=num;

ADCP_Level=str2num(get(handles.ADCPLevel,'String'));
ADCP_X=str2num(get(handles.ADCPX,'String'));
adcplevel=ones(size(XY,1),1)*ADCP_Level;


figure('Name','Section'), hold on;
plot(XY(:,1),XY(:,2),'-o');
plot(ADCP_X,adcplevel(1),'k*','MarkerSize',20)
plot(XY(:,1),adcplevel,'r-')
xlabel('Distance (m)');ylabel('Elevation (m)')
title('Cross-section');
set(gcf,'units','normalized','outerposition',[0 0 1 1])


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
