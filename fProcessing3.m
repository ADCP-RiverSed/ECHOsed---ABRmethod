function [TV,abr,dk1,dk2]=fProcessing3(method,handles)

WorkingFolder=get(handles.OutputFolder,'String');
adcp=get(handles.ADCPChannel,'String');
frequency=str2num(get(handles.ADCPFrequency,'String'))*1000;
% listing_res=dir([WorkingFolder,adcp]);
WF=WorkingFolder{1};
listing_res=dir(WF);

box=str2num(get(handles.BoxAverageWindow,'String'));
StartDate=handles.ProcessStartDate.String;
EndDate=handles.ProcessEndDate.String;

% adcp=handles.ADCPChannel.String;
% frequency=str2num(handles.ADCPFrequency.String);
% StartDate=handles.StartDateMonitor.String;
% EndDate=handles.EndDateMonitor.String;
% box=str2num(handles.BoxAverageWindow.String);
% WorkFolder=handles.OutputFolder.String;
% % dThresh=str2num(handles.DerivativeThreshold.String);
% RiverWidth=str2num(handles.ChannelWidth.String);
% WorkingFolder=WorkFolder{1}; %'C:\Users\Rui Aleixo\SharePoint\Massimo Guerrero\Kokel_Monitoring\Risultati_';
% listing_res=dir([WorkingFolder]); 


%% where the data is stored
%adcp='L1';%L1 is 600 kHz, L2 is 1200 kHz
% if strcmp(adcp,'L1')
%     frequency;
% elseif strcmp(adcp,'L2')
%     frequency=freq;
% end

%%
[ECh1dB01, Proy, WT, TV]=fReadData(StartDate,EndDate,WorkingFolder,adcp,frequency,listing_res,box);

NoiseLevel=str2double(handles.NoiseLevel.String);
Lused=str2double(handles.StopAnalysis.String);

ECh1dBa=fCleanProfilesStandard(ECh1dB01,Proy,NoiseLevel,Lused);

switch method
    case 1
        %% 1.4 Cleaning based on the derivative method==1
%         disp('Method 1')
        dthresh = str2num(get(handles.dThresh1,'String'));
        %                 dthresh=str2num(handles.dThresh1.string;)
        AW=diff(ECh1dBa,1);
        
        for n=1:size(ECh1dBa,2)
            aj=find(AW(:,n)>=dthresh);
            ECh1dBa(max(1,min(aj)-1):end,n)=NaN;
        end
    case 2
        %% 1.5 Cleaning based on the derivative, only when profile slope is negative method==2
            %% 1.5 Cleaning based on the derivative, only when profile slope is negative method==2
%             disp('Method 2')
            dthresh = str2double(get(handles.Method02Lim2,'String'));
%            dLim1=str2double(get(handles.Method02Lim1,'String'));
            
            for kk=1:size(ECh1dBa,2)
                AW=diff(ECh1dBa(:,kk));
                an=find(AW<dthresh);
                if ~isempty(an) && size(an,1)>1
                    n1(kk)=min(an);
                    n2(kk)=max(an);
                    if n1(kk)>1
                        ECh1dBa(1:n1(kk)-1,kk)=NaN;
                       
                    end
                    ECh1dBa(n2(kk)+1:end,kk)=NaN;
                elseif ~isempty(an) && size(an,1)==1
                    n1(kk)=min(an);
                    n2(kk)=n1(kk)+1;
                else
                    n1(kk)=1;
                    n2(kk)=size(ECh1dBa(:,kk),1);
                end
                 
            end
    case 3
%         disp('Method 3')
        %% 1.6 Cleaning based on the points given by the user method==3
        %             ECh1dBa=ECh1dBoriginal;
        n1 = str2double(get(handles.Method03Crop1,'String'))-1;
        n2 = str2double(get(handles.Method03Crop2,'String'));
        %             index=n1:n2;
        for n=1:size(ECh1dBa,2)
            ECh1dBa(1:n1,n)=NaN;
            ECh1dBa(n2+1:end,n)=NaN;
        end
    otherwise
        disp('Hello! error')
end
%%
ECh1dB02=ECh1dBa;
WLH=ones(size(WT))*2; %needs to be chax\nged with the right level
adcp=get(handles.ADCPChannel,'String');
nmedfilt=str2num(get(handles.SmoothFactor,'String'));
frequency=str2num(get(handles.ADCPFrequency,'String'))*1000;
[alfw, AW]=falfaw(WT,WLH,frequency);

[nk, mk]=(find(isnan(ECh1dB02)));
[nb, mb]=size(ECh1dB02);

% Prod=fproduct(B);
flag0=1;
if nb*mb ~= size(mk,1)
    
    if method==1
        [aa,bb, SSE, R2, RMSE, R21, RMSE1]=ffitechomodel(Proy,ECh1dB02);
        d2=aa./(-40*log10(exp(1)))-alfw';
        
        [s1,r1]=hist(d2,100);
        
        C=-120;
        d1=10.^((bb+C)/10);
        d2(find(d2<=0))=NaN;
        
        d2md=medfilt1(d2,nmedfilt); %median filter on abr
        d1md=medfilt1(d1,nmedfilt); %median filter on abr
        ABR=d2md./d1md;
    elseif method==2
        echosize=size(ECh1dBa,1);
        C=-120;
        for k=1:size(n1,2)
            
            n11=n1(k);
            n22=n2(k);
            
            if n22<echosize
                [aa,bb, SSE, R2, RMSE, R21, RMSE1]=ffitechomodel(Proy(n11:n22,k),ECh1dB02(n11:n22,k));
                AA(k)=aa;
                BB(k)=bb;
                sSSE(k)=SSE; rR2(k)=R2; rRMSE(k)=RMSE; rR21(k)=R21; rRMSE1(k)=RMSE1;
                d2(k)=aa./(-40*log10(exp(1)))-alfw(k);
                
                d1(k)=10.^((bb+C)/10);
            else
                AA(k)=NaN;
                BB(k)=NaN;
                sSSE(k)=NaN; rR2(k)=NaN; rRMSE(k)=NaN; rR21(k)=NaN; rRMSE1(k)=NaN;
                d2(k)=NaN;
                d1(k)=NaN;
            end
            
        end
        %                  d2=AA./(-40*log10(exp(1)))-alfw';
        
        [s1,r1]=hist(d2,100);
        d2(find(d2<=0))=NaN;
%         size(d2)
%         size(d1)
        d2md=medfilt1(d2,nmedfilt); %median filter on abr
        d1md=medfilt1(d1,nmedfilt); %median filter on abr
        ABR=d2md./d1md;
            
        elseif method==3
            C=-120;
            for in=1:size(ECh1dBa,2)
                av=find(~isnan(ECh1dBa(:,in)));
                if size(av,1)>3
                    [aa,bb, SSE, R2, RMSE, R21, RMSE1]=ffitechomodel(Proy(av,in),ECh1dB02(av,in));
                    d2(in)=aa./(-40*log10(exp(1)))-alfw(in);
                    d1(in)=10.^((bb+C)/10);
                else
                    d2(in)=NaN;
                    d1(in)=NaN;
                end
            end
                [s1,r1]=hist(d2,100);
                d2(find(d2<=0))=NaN;
                d2(find(d2<=0))=NaN;
                d2md=medfilt1(d2,nmedfilt); %median filter on abr
                d1md=medfilt1(d1,nmedfilt); %median filter on abr
                ABR=d2md./d1md;
        end
        
    else
        %     disp('here')
        %     ik
        d2=NaN;
        d2md=NaN;
        d1=NaN;
        d1md=NaN;
        ECh1dB02=ECh1dB;
        ABR=NaN;
        flag0=0;
        flag1='Problem with the profiles!!!!!';
    end

abr=ABR;
dk1=d1md;
dk2=d2md;

end
