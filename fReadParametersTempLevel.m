function  [varargout] = fReadParametersTempLevel(WorkingFolder,listing_res, start, endng)
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

Start=datenum(start,'yyyymmdd');
Endng=datenum(endng,'yyyymmdd');
I=0;

progressbar('Reading data')
NN=length(listing_res);
for m_in=3:NN %NN  %estava 3  574:574 %
    progressbar((m_in/NN))
    %     m_in
    aaa(m_in)=str2num(listing_res(m_in).name(1:8));
    bb1(m_in)=str2num(start);
    bb2(m_in)=str2num(endng);
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
            wl_=(A.Res{13});  %%%Echo beam1 same freq
            wlsize=size(wl_,2);
            wt_=(A.Res{14});  %%%Water temperature
            wtsize=size(wt_,2);
            tvec=datevec(t_);
            tstart=datevec(Start);
            tend=datevec(Endng);
            
            I=I+1;
            t{I}=t_;
            wl{I}=wl_;
            wt{I}=wt_;
%             Uecho{I}=uecho;
%             proy{I}=proy_;
            day(I)=datenum(listing_res(m_in).name(1:8),'yyyymmdd');
%             ech1{I}=ech1_;
%             ech2{I}=ech2_;
%             WN=size(proy{I});
%             nens=WN(2);
%             WN=WN(1);%                 I=I+1;
            
            
        else
            disp('file not found')
        end
    end
end
% progressbar(1)

Tv=cell2mat(t);
Wt=cell2mat(wt);
Wl=cell2mat(wl);
% size(ech1)

varargout{1}=Tv;
varargout{2}=Wt;
varargout{3}=Wl;




