function  [varargout] = fReadParametersMonitor(handles)
% this function reads the input data of the ADCP values and converts the results from daily variables to 
% entire period vectors .
%
% Input variables
% WorkingFolder = input directory ;  adcp: L1 or L2: beam ; listing_res: list where the data is stored
% start: time of start; end: time of ending
%
% output variables 
% t time series; wt water temperature series; proy: coordinates; 
% day obvious; ech1 echo 1 ; ech2 echo 2; WN nens 
% dpro profile resolution
% Tv time series per period 
% Wt water temperature per period 
% ECH1 ech1 organized per period
% ECH2 ech2 organized per perido
%
WF=handles.OutputFolder.String;
if iscell(WF)
    WorkingFolder=WF{1}; %'C:\Users\Rui Aleixo\SharePoint\Massimo Guerrero\Kokel_Monitoring\Risultati_';
else
    WorkingFolder=WF;
end
% listing_res=dir([WorkingFolder],'*.mat');
listing_res=dir(fullfile([WorkingFolder], '*.mat'));
% listing_res=dir(WF{1});
start=(handles.StartDateMonitor.String);
endng=(handles.EndDateMonitor.String);

Start=datenum(start,'yyyymmdd');
Endng=datenum(endng,'yyyymmdd');
I=0;
progressbar('Reading data for monitoring') 
NN=length(listing_res);
for m_in=1:NN %NN  %estava 3  574:574 %
    progressbar((m_in/NN))   
%     aaa(m_in)=str2num(listing_res(m_in).name(1:8));
%     bb1(m_in)=str2num(start);
%     bb2(m_in)=str2num(endng);
    if str2num(listing_res(m_in).name(1:8))>=str2num(start) && str2num(listing_res(m_in).name(1:8))<=str2num(endng) %fixing the data subset
        %strcat(WorkingFolder,adcp,'\',num2str(listing_res(m_in).name))
%          m_in
%         FileName=strcat(WorkingFolder,adcp,'\',num2str(listing_res(m_in).name));
         FileName=strcat(WorkingFolder,'\',num2str(listing_res(m_in).name));
        if exist(FileName)
            A=load(FileName);
            
            t_=(A.Res{1});
            proy_=((A.Res{2}));  %% Distance from ADCP head in m
            proysize=size(proy_,2);
            ech1_=(A.Res{3});  %%%Echo beam1 same freq
            ech1size=size(ech1_,2);
            ech2_=(A.Res{4});  %%%Echo beam2 same freq
            ech2size=size(ech2_,2);
            wt_=(A.Res{14});  %%%Water temperature
            wtsize=size(wt_,2);
            uecho=(A.Res{22});  %%%Electric tension of the battery
            uechosize=size(uecho,2);
            tvec=datevec(t_);
            tstart=datevec(Start);
            tend=datevec(Endng);
            sq=tvec(:,3)>=tstart(:,3);
%             sw=find(sq==0);
%             if sw
%                 nx=length(sw);
%                 i=find(tvec(nx+1:end,1)>=tstart(:,1) & tvec(nx+1:end,2)>=tstart(:,2) & ...
%                     tvec(nx+1:end,3)>=tstart(:,3) & tvec(nx+1:end,1)<=tend(:,1) & ...
%                     tvec(nx+1:end,2)<=tend(:,2) & tvec(nx+1:end,3)<=tend(:,3));
%                 isize=length(i)+nx;
%             else
%                 i=find(tvec(:,1)>=tstart(:,1) & tvec(:,2)>=tstart(:,2) & tvec(:,3)>=tstart(:,3) & ...
%                     tvec(:,1)<=tend(:,1) & tvec(:,2)<=tend(:,2) & tvec(:,3)<=tend(:,3));
%                 %             i=find(t_>=Start & t_<=Endng);
%             isize=length(i);
%             end
        %    if  ~isempty(i) && proysize==isize && ech1size==isize && ech2size==isize && wtsize==isize %&& uechosize==isize
                I=I+1;
                t{I}=t_;
                wt{I}=wt_;
                Uecho{I}=uecho;
                proy{I}=proy_;
                day(I)=datenum(listing_res(m_in).name(1:8),'yyyymmdd');
                ech1{I}=ech1_;
                ech2{I}=ech2_;
                WN=size(proy{I});
                nens=WN(2);
                WN=WN(1);%                 I=I+1;
%                 t{I}=t_(i);
%                 wt{I}=wt_(i);
%                 Uecho{I}=uecho(i);
%                 proy{I}=proy_(:,i);
%                 day(I)=datenum(listing_res(m_in).name(1:8),'yyyymmdd');
%                 ech1{I}=ech1_(:,i);
%                 ech2{I}=ech2_(:,i);
%                 WN=size(proy{I});
%                 nens=WN(2);
%                 WN=WN(1);
%             else
%                  disp('Here I am - Corrupted file')
% %                  m_in
%             end  
        else
            disp('file not found')
        end
    end
end
% progressbar(1)
if I==0
    msgbox('Check the dates')
    
else
    dpro=median(diff(proy_(:,1)));%profile resolution %why the median?
    Tv=cell2mat(t);
    Wt=cell2mat(wt);
    % size(ech1)
    PROY=cell2mat(proy);
    ECH1=cell2mat(ech1);
    ECH2=cell2mat(ech2);
    UECHO=cell2mat(Uecho);
    
    varargout{1}=t;    %[t wt proy day ech1 ech2 WN nens dpro]
    varargout{2}=wt;
    varargout{3}=PROY;
    varargout{4}=day;
    varargout{5}=ech1;
    varargout{6}=ech2;
    varargout{7}=WN;
    varargout{8}=nens;
    varargout{9}=dpro;
    varargout{10}=Tv;
    varargout{11}=Wt;
    varargout{12}=ECH1;
    varargout{13}=ECH2;
    varargout{14}=UECHO;
end
