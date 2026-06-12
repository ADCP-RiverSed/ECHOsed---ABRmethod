function Flag=fCheckValuesCalib(Cmethod,handles)
%this function checks if the data for Process Data is ok, Flag(1)=1 if ok, 0
%otherwise. The Flag(2:end) is a logical vector. Each position is 1 or 0.
%If 1 OK, if 0, some input data has to be rechecked

%check if folder where data is stored existsget(handles.ChannelWidth,'String')
if strcmp(Cmethod.String,'1st Calibration')
    MyFolder1=get(handles.OutputFolder,'String');
    MyFolder2=get(handles.CalibrationFolder,'String');
    MyFile1=get(handles.FirstCalibXLS,'String');
    if exist(MyFolder1,'dir') && exist(MyFolder2,'dir')
%        cd(MyFolder2)
        if exist([MyFolder2 '\' MyFile1],'file')
            flag00=1;
        else
            flag00=0;
            msgbox('No calibration file found')
        end
    else
        msgbox('Invalid Output/Calibration folder')
        flag00=0;
    end
elseif strcmp(Cmethod.String,'Calibration file')
    MyFolder1=get(handles.OutputFolder,'String');
    MyFolder2=get(handles.CalibrationFolder,'String');
    MyFile1=get(handles.CalibXLS,'String');
    if exist(MyFolder1,'dir') && exist(MyFolder2,'dir')
       % cd(MyFolder2)
        if exist([MyFolder2 '\' MyFile1],'file')
            flag00=1;
        else
            flag00=0;
            msgbox('No calibration file found')
        end
    else
        msgbox('Invalid Output/Calibration folder')
        flag00=0;
    end
end

%check data
ChannelWidth=str2double(get(handles.ChannelWidth,'String'));
StopAnalysis=str2double(get(handles.StopAnalysis,'String'));

if ChannelWidth>0 && StopAnalysis>0 && ChannelWidth>StopAnalysis
    flag01=1;
else
    flag01=0;
    msgbox('Check values of channel width and stop analysis') 
end

%check noise level
NLevel=str2double(get(handles.StopAnalysis,'String'));
if NLevel>=10
    flag02=1;
elseif NLevel<5 && NLevel>0
    msgbox('Warning! Noise Level < 10')
    flag02=1;
elseif NLevel <=0
    msgbox('Insert Noise Level > 0')
end

%check dates 
StartDateMonitor=get(handles.ProcessStartDate,'String');
EndDateMonitor=get(handles.ProcessEndDate,'String');

if length(StartDateMonitor)<8 || length(EndDateMonitor)<8
    msgbox('Start Date or End Date in wrong format')
    flag03=0;
elseif length(StartDateMonitor)>8 || length(EndDateMonitor)>8
    msgbox('Start Date or End Date in wrong format')
    flag03=0;
elseif length(StartDateMonitor)==8 && length(EndDateMonitor)==8
    startmonth=str2double(StartDateMonitor);
    endmonth=str2double(EndDateMonitor);
    if (startmonth<1 && startmonth>12) || (endmonth<1 && endmonth>12)
        flag03=0;
        msgbox('Start month and/or end month are/is wrong')
    end
    if datenum(EndDateMonitor,'yyyymmdd')>datenum(StartDateMonitor,'yyyymmdd')
        flag03=1;
    else
        flag03=0;
        msgbox('Start date is higher than end date')
    end
end

% Beam selection
nbeams = get(handles.BeamNumber,'String');
SelectedBeam=str2double(nbeams); %beam to be used
if SelectedBeam==1 || SelectedBeam==2
    flag04=1;
else
   flag04=0; 
   msgbox('Error! Beam should be 1 or 2. Using Beam 1')
end

%check box average window
BoxAverageWindow=str2double(get(handles.BoxAverageWindow,'String'));
if BoxAverageWindow<2
    msgbox('Box average monitor < 2')
    flag05=0;
else
    flag05=1;
end

%check 


Flag=[flag00*flag01*flag02*flag03*flag04*flag05; flag00; flag01; flag02; flag03; flag04; flag05];


