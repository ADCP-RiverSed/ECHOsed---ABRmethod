function  [varargout] = fReadParametersTempLevel2(WorkingFolder,listing_res, dhp, dh, start, endng)
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

plim1=-100;plim2=100;
wlim=10;%fixing the minimum of vertical beam good ensembles in 1 day

I=0;%day index

progressbar('Reading data',0)
NN=length(listing_res);

for m_in=3:length(listing_res)
    if str2num(listing_res(m_in).name(1:8))>=str2num(start) & str2num(listing_res(m_in).name(1:8))<=str2num(endng);%fixing the data subset
       
    FileName=strcat(WorkingFolder,'\',num2str(listing_res(m_in).name));   
    if exist(FileName)
        A=load(FileName);
        t_=(A.Res{1});
        p_=(A.Res{11})./980.61+dhp;  %%%Pressure in m water column
        w_=((A.Res{13})./1000)+dh;  %% Water level from vertical beam above ADCP Axis in m
        V_=(A.Res{22});%%Battery voltage
        wtc_=(A.Res{14});
        
        dh=dh;
        i=find(t_>=Start & t_<=Endng & p_>plim1 & p_<plim2);
        if isempty(i)==0
            I=I+1;t{I}=t_(i);p{I}=p_(i);w{I}=w_(i);wtc{I}=wtc_(i);V{I}=V_(i);
            day(I)=datenum(listing_res(m_in).name(1:8),'yyyymmdd');
            pday(I)=nanmean(p{I});
            wday(I)=nanmean(w{I});
            if sum(length(find(w{I}~=dh)))>10
                Iw(I)=sum(length(find(w{I}~=dh)))/length(w{I});
                i0=find(w{I}~=dh);
                I0{I}=find(w{I}~=dh);
                [xData,yData]=prepareCurveData(p{I}(i0),w{I}(i0));
                ft=fittype('poly1');
                [fitresult{I},gof{I}]=fit(xData,yData,ft);
                fit_coef{I}=confint(fitresult{I});
                Rs(I)=gof{I}.rsquare;
                %            figure(1),plot(t{I},p{I},[colore(I) '.'],t{I},w{I},[colore(I) 'o'])
            else
                %            figure(1),plot(t{I},p{I},[colore(I) '.'])
                Iw(I)=0;Rs(I)=0;
            end
        end
    else
        disp('File not found')
    end
    end
end
progressbar('Reading data',0.5)
IR=find(Iw>0 & Rs>0.5);%criteria for fitting day selection
Wv=[];Tv=[];pv=[];wv=[];Vv=[];WTc=[];
for i=1:I
    [mn, iw]=min(abs(i-IR));
    if isempty(iw)
        Id(i)=NaN;W{i}=NaN;
    else
        Id(i)=IR(iw);W{i}=[fitresult{Id(i)}(p{i})]';
    end
    Tv=[Tv t{i}];
    Wv=[Wv W{i}];%pressure fitted over vertical beam
    pv=[pv p{i}];%pressure transducer
    wv=[wv w{i}];%vertical beam
    Vv=[Vv V{i}];%voltage    
    WTc=[WTc wtc{i}];%temperature in Celsius
end
%combinig (or selecting) vertical beam and pressure transducer readings
%I=find(wv==min(wv));WV=wv;WV(I)=Wv(I);
% remove temperatures above 50ºC
a1=find(WTc>50);
WTc(a1)=NaN;

varargout{1}=Tv;
varargout{2}=Wv;
varargout{3}=pv;
varargout{4}=wv;
varargout{5}=Vv;
varargout{6}=WTc;
varargout{7}=day;
varargout{8}=pday;
varargout{9}=wday;
varargout{10}=Iw;
varargout{11}=Rs;
varargout{12}=Id;
progressbar('Reading data',1)

