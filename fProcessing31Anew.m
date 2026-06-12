function [TV,abr,dk1,dk2,DK95,abrplus,dk1plus,dk2plus,abrminus,dk1minus,dk2minus,Quality,Qualityplus,Qualityminus]=fProcessing31Anew(method,handles)

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
StartDate=handles.ProcessStartDate.String;
EndDate=handles.ProcessEndDate.String;
progressbar(10/100)
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
[ECh1dB01, ECh1dB01minus, ECh1dB01plus, Proy, WT, TV]=fReadData2(handles,StartDate,EndDate,WorkingFolder,adcp,frequency,listing_res,box);
[Echo, Echominus, Echoplus, Proy, WT, TV]=fReadData2(handles,StartDate,EndDate,WorkingFolder,adcp,frequency,listing_res,box);

NoiseLevel=str2double(handles.NoiseLevel.String);
Lused=str2double(handles.StopAnalysis.String);

ECh1dBa=fCleanProfilesStandard(ECh1dB01,Proy,NoiseLevel,Lused);
ECh1dBaplus=fCleanProfilesStandard(ECh1dB01plus,Proy,NoiseLevel,Lused);
ECh1dBaminus=fCleanProfilesStandard(ECh1dB01minus,Proy,NoiseLevel,Lused);
ECh1dBPrima=ECh1dBa;
progressbar(40/100)
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
            ECh1dBaplus(max(1,min(aj)-1):end,n)=NaN; 
            ECh1dBaminus(max(1,min(aj)-1):end,n)=NaN;  
        end
    case 2
        %% 1.5 Cleaning based on the derivative, only when profile slope is negative method==2
            %% 1.5 Cleaning based on the derivative, only when profile slope is negative method==2
%             disp('Method 2')
            dthresh = str2double(get(handles.Method02Lim2,'String'));
%            dLim1=str2double(get(handles.Method02Lim1,'String'));
            
            for kk=1:size(ECh1dBa,2)
                contador(kk)=kk;
                AW=diff(ECh1dBa(:,kk));
                if length(AW)>1
                    AW2=[AW(1) AW' AW(end)];
                    AWmean=nanmean([AW2(1:end-1)' AW2(2:end)'],2);
                else
                    AWmean=AW;
                end
                AW=AWmean;
                
                an=find(AW<dthresh);
                
                if ~isempty(an) && size(an,1)>1
                    n1(kk)=min(an);
                    n2(kk)=max(an);
                    if n1(kk)>1
                        ECh1dBa(1:n1(kk)-1,kk)=NaN;
                        ECh1dBaplus(1:n1(kk)-1,kk)=NaN; 
                        ECh1dBaminus(1:n1(kk)-1,kk)=NaN;  
                    end
                    ECh1dBa(n2(kk)+1:end,kk)=NaN;
                    ECh1dBaplus(n2(kk)+1:end,kk)=NaN;
                    ECh1dBaminus(n2(kk)+1:end,kk)=NaN;
                else
                    n1(kk)=1;
                    n2(kk)=1;
                    ECh1dBa(:,kk)=NaN;
                    ECh1dBaplus(:,kk)=NaN;
                    ECh1dBaminus(:,kk)=NaN;
                end
                 
            end
%             a=find(n2<=2);
%             rui=10;
    case 3
%         disp('Method 3')
        %% 1.6 Cleaning based on the points given by the user method==3
        %             ECh1dBa=ECh1dBoriginal;
%         n1 = str2double(get(handles.Method03Crop1,'String'))-1;
        n1 = str2double(get(handles.Method03Crop1,'String'));
        n2 = str2double(get(handles.Method03Crop2,'String'));
        %             index=n1:n2;
        for n=1:size(ECh1dBa,2)
            ECh1dBa(1:n1,n)=NaN;
            ECh1dBa(n2+1:end,n)=NaN;

            ECh1dBaplus(1:n1,n)=NaN;
            ECh1dBaplus(n2+1:end,n)=NaN;

            ECh1dBaminus(1:n1,n)=NaN;
            ECh1dBaminus(n2+1:end,n)=NaN;
        end
    otherwise
        disp('Hello! error')
end
%%
ECh1dB02=ECh1dBa;
ECh1dB02plus=ECh1dBaminus;
ECh1dB02minus=ECh1dBaplus;

WLH=ones(size(WT))*2; %needs to be chax\nged with the right level
%adcp=get(handles.ADCPChannel,'String');
nmedfilt=str2num(get(handles.SmoothFactor,'String'));
frequency=str2num(get(handles.ADCPFrequency,'String'))*1000;
[alfw, ~]=falfaw(WT,WLH,frequency);

[~, mk]=(find(isnan(ECh1dB02)));
[nb, mb]=size(ECh1dB02);
progressbar(60/100)
% Prod=fproduct(B);
flag0=1;

if nb*mb ~= size(mk,1)
    
    if method==1
        [aa,bb, SSE, R2, RMSE, a95plus,a95minus,b95plus,b95minus]=ffitechomodel2(Proy,ECh1dB02);
        [aaplus,bbplus, SSEplus, R2plus, RMSEplus,a95plus,a95minus,b95plus,b95minus]=ffitechomodel2(Proy,ECh1dB02plus);
        [aaminus,bbminus, SSEminus, R2minus, RMSEminus, a95plus,a95minus,b95plus,b95minus]=ffitechomodel2(Proy,ECh1dB02minus);        
        
%         aa
        d2=aa./(-40*log10(exp(1)))-alfw';
        d2plus=aaplus./(-40*log10(exp(1)))-alfw';
        d2minus=aaminus./(-40*log10(exp(1)))-alfw';
        
        [s1,r1]=hist(d2,100);
        
        C=str2double(handles.CInstrument.String);
        d1=10.^((bb+C)/10);
        d1plus=10.^((bbplus+C)/10);
        d1minus=10.^((bbminus+C)/10);
        
        d2(find(d2<=0))=NaN;
        d2plus(find(d2plus<=0))=NaN;
        d2minus(find(d2plus<=0))=NaN;
        
        d2md=medfilt1(d2,nmedfilt,'omitnan'); %median filter on abr
        d2mdplus=medfilt1(d2plus,nmedfilt,'omitnan'); %median filter on abr
        d2mdminus=medfilt1(d2minus,nmedfilt,'omitnan'); %median filter on abr
        
        d1md=medfilt1(d1,nmedfilt,'omitnan'); %median filter on abr
        d1mdplus=medfilt1(d1plus,nmedfilt,'omitnan'); %median filter on abr
        d1mdminus=medfilt1(d1minus,nmedfilt,'omitnan'); %median filter on abr
        
        ABR=d2md./d1md;
        ABRplus=d2mdplus./d1mdplus;
        ABRminus=d2mdminus./d1mdminus;
        AA=aa;
        BB=bb;
        SSSE=SSE;
        RR2=R2;
        RRMSE=RMSE;
        RR21=R21;
        RRMSE1=RMSE1;
    elseif method==2
        
        echosize=size(ECh1dBa,1);
        %         C=-120;
        C=str2double(handles.CInstrument.String);
        % this was for debug save('NilsTest2.mat','Proy','n1','n2','ECh1dB02plus','ECh1dBa','ECh1dB01')
        for k=1:size(n1,2)

            n11=n1(k);
            n22=n2(k);
 
            if n22<echosize && (n22-n11>2) %fit works with more than 3 points
%                 [aa,bb, SSE, R2, RMSE, R21, RMSE1]=ffitechomodel2(Proy(n11:n22,k),ECh1dB02(n11:n22,k));
%                 [aaplus,bbplus, SSEplus, R2plus, RMSEplus, R21plus, RMSE1plus]=ffitechomodel2(Proy(n11:n22,k),ECh1dB02plus(n11:n22,k));
%                 [aaminus,bbminus, SSEminus, R2minus, RMSEminus, R21minus, RMSE1minus]=ffitechomodel2(Proy(n11:n22,k),ECh1dB02minus(n11:n22,k));

                [aa,bb, SSE, R2, RMSE,a95plus,a95minus,b95plus,b95minus]=ffitechomodel2(Proy(n11:n22,k),ECh1dB02(n11:n22,k));
                [aaplus,bbplus, SSEplus, R2plus, RMSEplus,a95plus_,a95minus_,b95plus_,b95minus_]=ffitechomodel2(Proy(n11:n22,k),ECh1dB02plus(n11:n22,k));
                [aaminus,bbminus, SSEminus, R2minus, RMSEminus,a95plus_,a95minus_,b95plus_,b95minus_]=ffitechomodel2(Proy(n11:n22,k),ECh1dB02minus(n11:n22,k));
                
                
                AA(k)=aa;
                BB(k)=bb;
                SSSE(k)=SSE; RR2(k)=R2; RRMSE(k)=RMSE; %rR21(k)=R21; rRMSE1(k)=RMSE1;
                d2(k)=aa./(-40*log10(exp(1)))-alfw(k);                                
                d1(k)=10.^((bb+C)/10);
                
                d2_95plus(k)=a95plus./(-40*log10(exp(1)))-alfw(k);                                
                d1_95plus(k)=10.^((b95plus+C)/10);

                d2_95minus(k)=a95minus./(-40*log10(exp(1)))-alfw(k);                                
                d1_95minus(k)=10.^((b95minus+C)/10);
                
                % %
                AAplus(k)=aaplus;
                BBplus(k)=bbplus;                
                SSSEplus(k)=SSEplus; RR2plus(k)=R2plus; RRMSEplus(k)=RMSEplus; %rR21plus(k)=R21plus; rRMSE1plus(k)=RMSE1plus;
                d2plus(k)=aaplus./(-40*log10(exp(1)))-alfw(k);
                d1plus(k)=10.^((bbplus+C)/10);
                
                AAminus(k)=aaminus;
                BBminus(k)=bbminus;                
                SSSEminus(k)=SSEminus; RR2minus(k)=R2minus; RRMSEminus(k)=RMSEminus; %rR21minus(k)=R21minus; rRMSE1minus(k)=RMSE1minus;
                d2minus(k)=aaminus./(-40*log10(exp(1)))-alfw(k);
                d1minus(k)=10.^((bbminus+C)/10);
                           
                
            else
                AA(k)=NaN;
                BB(k)=NaN;
                SSSE(k)=NaN;
                RR2(k)=NaN;
                RRMSE(k)=NaN;
%                 RR21(k)=NaN;
%                 RRMSE1(k)=NaN;
                %plus
                AAplus(k)=NaN;
                BBplus(k)=NaN;
                SSSEplus(k)=NaN;
                RR2plus(k)=NaN;
                RRMSEplus(k)=NaN;
                d2(k)=NaN;                                
                d1(k)=NaN;
                d2plus(k)=NaN;
                d1plus(k)=NaN;
                
                %minus
                AAminus(k)=NaN;
                BBminus(k)=NaN;
                SSSEminus(k)=NaN;
                RR2minus(k)=NaN;
                RRMSEminus(k)=NaN;
                
                d2minus(k)=NaN;
                d1minus(k)=NaN;
                
                d2_95plus(k)=NaN;
                d1_95plus(k)=NaN;
                
                d2_95minus(k)=NaN;
                d1_95minus(k)=NaN;
            end
            
        end
        %                  d2=AA./(-40*log10(exp(1)))-alfw';
        
        [s1,r1]=hist(d2,100);
     
        d2(find(d2<=0))=NaN;
        
        d2md=medfilt1(d2,nmedfilt); %median filter on abr
        d1md=medfilt1(d1,nmedfilt); %median filter on abr
        ABR=d2md./d1md;
        
        %+95
        d2md95p=medfilt1(d2_95plus,nmedfilt); %median filter on abr
        d1md95p=medfilt1(d1_95plus,nmedfilt); %median filter on abr
        ABR95p=d2md95p./d1md95p;
        
        %-95
        d2md95m=medfilt1(d2_95minus,nmedfilt); %median filter on abr
        d1md95m=medfilt1(d1_95minus,nmedfilt); %median filter on abr
        ABR95m=d2md95m./d1md95m;
        %%%%%%%%%%%%%%%%%
        
        % plus
        d2plus(find(d2plus<=0))=NaN;
        d2mdplus=medfilt1(d2plus,nmedfilt); %median filter on abr
        d1mdplus=medfilt1(d1plus,nmedfilt); %median filter on abr

        d2minus(find(d2minus<=0))=NaN;
        d2mdminus=medfilt1(d2minus,nmedfilt); %median filter on abr
        d1mdminus=medfilt1(d1plus,nmedfilt); %median filter on abr

        
        ABRplus=d2mdplus./d1mdplus;
        ABRminus=d2mdminus./d1mdminus;
      
    elseif method==3
        %             C=-120;
        C=str2double(handles.CInstrument.String);
        for in=1:size(ECh1dBa,2)
            av=find(~isnan(ECh1dBa(:,in)));
            if size(av,1)>3
%                 [aa,bb, SSE, R2, RMSE, R21, RMSE1]=ffitechomodel(Proy(av,in),ECh1dB02(av,in));
                [aa,bb, SSE, R2, RMSE,a95plus,a95minus,b95plus,b95minus]=ffitechomodel2(Proy(av,in),ECh1dB02(av,in));
                %[aa,bb, SSE, R2, RMSE]=ffitechomodel2(Proy(av,in),ECh1dB02(av,in));
                d2(in)=aa./(-40*log10(exp(1)))-alfw(in);
                d1(in)=10.^((bb+C)/10);
                AA(in)=aa; BB(in)=bb;
                RR2(in)=R2; SSSE(in)=SSE;
                RRMSE(in)=RMSE; %RR21(in)=R21; RRMSE1(in)=RMSE1;
                %plus
%                 [aaplus,bbplus, SSEplus, R2plus, RMSEplus]=ffitechomodel2(Proy(av,in),ECh1dB02plus(av,in));
                [aaplus,bbplus, SSEplus, R2plus, RMSEplus,a95plus_,a95minus_,b95plus_,b95minus_]=ffitechomodel2(Proy(av,in),ECh1dB02(av,in));
                d2plus(in)=aaplus./(-40*log10(exp(1)))-alfw(in);
                d1plus(in)=10.^((bbplus+C)/10);
                AAplus(in)=aaplus; BBplus(in)=bbplus;
                RR2plus(in)=R2plus; SSSEplus(in)=SSEplus;
                RRMSEplus(in)=RMSEplus; %RR21plus(in)=R21plus; RRMSE1plus(in)=RMSE1plus;
                %minus
%                 [aaminus,bbminus, SSEminus, R2minus, RMSEminus]=ffitechomodel2(Proy(av,in),ECh1dB02minus(av,in));
                [aaminus,bbminus, SSEminus, R2minus, RMSEminus,a95plus_,a95minus_,b95plus_,b95minus_]=ffitechomodel2(Proy(av,in),ECh1dB02minus(av,in));
                d2minus(in)=aaminus./(-40*log10(exp(1)))-alfw(in);
                d1minus(in)=10.^((bbminus+C)/10);
                AAminus(in)=aa; BBminus(in)=bb;
                RR2minus(in)=R2minus; SSSEminus(in)=SSEminus;
                RRMSEminus(in)=RMSEminus; %RR21minus(in)=R21minus; RRMSE1minus(in)=RMSE1minus; 
                
                
                AA(in)=aa;
                BB(in)=bb;
                SSSE(in)=SSE; RR2(in)=R2; RRMSE(in)=RMSE; %rR21(k)=R21; rRMSE1(k)=RMSE1;
                d2(in)=aa./(-40*log10(exp(1)))-alfw(in);                                
                d1(in)=10.^((bb+C)/10);
                
                d2_95plus(in)=a95plus./(-40*log10(exp(1)))-alfw(in);                                
                d1_95plus(in)=10.^((b95plus+C)/10);
 
                d2_95minus(in)=a95minus./(-40*log10(exp(1)))-alfw(in);                                
                d1_95minus(in)=10.^((b95minus+C)/10);
 
                
                % %
                AAplus(in)=aaplus;
                BBplus(in)=bbplus;                
                SSSEplus(in)=SSEplus; RR2plus(in)=R2plus; RRMSEplus(in)=RMSEplus; %rR21plus(k)=R21plus; rRMSE1plus(k)=RMSE1plus;
                d2plus(in)=aaplus./(-40*log10(exp(1)))-alfw(in);
                d1plus(in)=10.^((bbplus+C)/10);
                
                AAminus(in)=aaminus;
                BBminus(in)=bbminus;                
                SSSEminus(in)=SSEminus; RR2minus(in)=R2minus; RRMSEminus(in)=RMSEminus; %rR21minus(k)=R21minus; rRMSE1minus(k)=RMSE1minus;
                d2minus(in)=aaminus./(-40*log10(exp(1)))-alfw(in);
                d1minus(in)=10.^((bbminus+C)/10);
                
            else 
                d2(in)=NaN; d1(in)=NaN;
                AA(in)=NaN; BB(in)=NaN;
                RR2(in)=NaN; SSSE(in)=NaN;
                RRMSE(in)=NaN; %RR21(in)=NaN;
               % RRMSE1(in)=NaN;
                %plus
                d2plus(in)=NaN; d1plus(in)=NaN;
                AAplus(in)=NaN; BBplus(in)=NaN;
                RR2plus(in)=NaN; SSSEplus(in)=NaN;
                RRMSEplus(in)=NaN;% RR21plus(in)=NaN;
                %RRMSE1plus(in)=NaN;
                %minus
                d1_95plus(in)=NaN;
                d1_95minus(in)=NaN;
                d2_95minus(in)=NaN;                                
                d2_95plus(in)=NaN;
                             
                d2minus(in)=NaN; d1minus(in)=NaN;
                AAminus(in)=NaN; BBminus(in)=NaN;
                RR2minus(in)=NaN; SSSEminus(in)=NaN;
                RRMSEminus(in)=NaN;% RR21minus(in)=NaN;
                %RRMSE1minus(in)=NaN;
            end
        end

        [s1,r1]=hist(d2,100);
   
        d2(find(d2<=0))=NaN;
        
        d2md=medfilt1(d2,nmedfilt); %median filter on abr
        d1md=medfilt1(d1,nmedfilt); %median filter on abr
        ABR=d2md./d1md;
        
        %+95
        d2md95p=medfilt1(d2_95plus,nmedfilt); %median filter on abr
        d1md95p=medfilt1(d1_95plus,nmedfilt); %median filter on abr
        ABR95p=d2md95p./d1md95p;
        
        %-95
        d2md95m=medfilt1(d2_95minus,nmedfilt); %median filter on abr
        d1md95m=medfilt1(d1_95minus,nmedfilt); %median filter on abr
        ABR95m=d2md95m./d1md95m;
        %%%%%%%%%%%%%%%%%
        
        % plus
        d2plus(find(d2plus<=0))=NaN;
        d2mdplus=medfilt1(d2plus,nmedfilt); %median filter on abr
        d1mdplus=medfilt1(d1plus,nmedfilt); %median filter on abr

        d2minus(find(d2minus<=0))=NaN;
        d2mdminus=medfilt1(d2minus,nmedfilt); %median filter on abr
        d1mdminus=medfilt1(d1plus,nmedfilt); %median filter on abr

        
        ABRplus=d2mdplus./d1mdplus;
        ABRminus=d2mdminus./d1mdminus;
    
  
else
    %     disp('here')
    %     ik
    d2=NaN; d2md=NaN;
    d1=NaN; d1md=NaN;
    ECh1dB02=ECh1dBa;
    ABR=NaN;
    AA=NaN;
    BB=NaN;
    RR2=NaN;
    SSSE=NaN;
    RRMSE=NaN;
%     RR21=NaN;
%     RRMSE1=NaN;
    flag0=0;
    flag1='Problem with the profiles!!!!!';
end

abr=ABR;
dk1=d1md;
% dk1mean=nanmean(dk1);
dk2=d2md;

dk1p_95=d1md95p;
% dk1p95mean=nanmean(dk1p_95);
% dk1p_95=(d1md95p./dk1p95mean)*dk1mean;
dk2p_95=d2md95p;

dk1m_95=d1md95m;
% dk1m95mean=nanmean(dk1m_95);
% dk1m_95=(d1md95m./dk1m95mean)*dk1mean;
dk2m_95=d2md95m;
DK95={ABR95p, ABR95m, dk1p_95,dk2p_95,dk1m_95,dk2m_95};


%plus
abrplus=ABRplus;
dk1plus=d1mdplus;
dk2plus=d2mdplus;
%minus
abrminus=ABRminus;
dk1minus=d1mdminus;
dk2minus=d2mdminus;

Quality={AA, BB, RR2, SSSE, RRMSE, ECh1dBa};%,RR21,RRMSE1};
Qualityplus={AAplus, BBplus, RR2plus, SSSEplus, RRMSEplus}; %,RR21plus,RRMSE1plus};
Qualityminus={AAminus, BBminus, RR2minus, SSSEminus, RRMSEminus};  %,RR21minus,RRMSE1minus};
        
progressbar(100/100)
end
