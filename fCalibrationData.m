function [aabbrr, dd22, Ccalib, DataC, DataCDaily,PlotData]=fCalibrationData(method,handles)
% function that determines the calibration parameters for the samples given
% in a .xls file

WF=handles.OutputFolder.String;
if iscell(WF)
    WorkingFolder=WF{1}; %'C:\Users\Rui Aleixo\SharePoint\Massimo Guerrero\Kokel_Monitoring\Risultati_';
else
    WorkingFolder=WF;
end
% listing_res=dir(WorkingFolder);
listing_res=dir(fullfile([WorkingFolder], '*.mat'));

adcp=get(handles.ADCPChannel,'String');
%frequency=str2double(get(handles.ADCPFrequency,'String'))*1000;
% listing_res=dir([WorkingFolder,adcp]);
calibfolder = get(handles.CalibrationFolder,'String');
box=str2double(get(handles.BoxAverageWindowCalib,'String'));

filename=get(handles.FirstCalibXLS,'String');
[num,txt,raw] = xlsread([calibfolder '\' filename]);

npoints=size(num,1);

for ik=1:npoints
    A=num(ik,1); hr=datestr(A,'HH:MM');
    hour1(ik)=str2double(hr(1:2));
    dat1=txt{ik+1,1};
    %         datok=fdateformat(dat1)
    minutes1(ik)=str2double(hr(4:5));
    B=num(ik,2); hr=datestr(B,'HH:MM');
    hour2(ik)=str2double(hr(1:2));
    minutes2(ik)=str2double(hr(4:5));
    Ccalib(ik)=num(ik,3);
    
    start=fdateformat(dat1);
    day1=start(7:8);
    endng=fdateformat(dat1);%fixing the data subset start
    
    label=dat1;
    
    [t, wt, proy1, day, ech1, ech2, WN, nens, dpro, Tv, Wt, ECH1, ECH2, Uecho] = fReadParameters3(WorkingFolder,adcp,listing_res, start, endng);
    
    %% routine calib
    proy_=(proy1)/cos(20*pi/180); %to correct for angle
    
    % Boxcar averaging for time vector
    TV=(buffer(Tv,box));
    WT=(buffer(Wt,box));
    UU=(buffer(Uecho,box));
    dTV=diff(TV)*86400;%distance between samples in sec
    n=size(TV,2); %n=n(2);
    %
    SKIP=zeros(n,1);
    [m1, n1]=find(dTV>box*120); %maximal distance between sample admitted (3600 sec)
    TV(:,n1)=NaN;
    WT(:,n1)=NaN;
    SKIP(n1)=1;
    
    TV=nanmean(TV);TV=TV(1:end-1);
    WT=nanmedian(WT);WT=WT(1:end-1);
    UU=nanmedian(UU);UU=UU(1:end-1);
    
    IndexAux=zeros(size(TV,2),1); % track the indexes changed
    
    csound=fCsound(WT,0);
    
    %     %% Determining where the far field conditions are valid
    %     SensorDiam=0.1144;
    %     [ffield, r0index]=fFarField(SensorDiam,frequency,csound,proy_);
    %% Boxcar averaging for echoes
    k0=size(ECH1,1); %k=kk(1);
    baux=find(SKIP);
    
    for in=1:k0
        Ech1_=ECH1(in,:); Ech2_=ECH2(in,:);
        Ech1_=(buffer(Ech1_,box)); Ech2_=(buffer(Ech2_,box));
        ECh1(in,:)=nanmedian(Ech1_);ECh2(in,:)=nanmedian(Ech2_);
        %     ECh1(i,baux)=NaN; ECh2(i,baux)=NaN; %using logical indexing
        Proy_=proy_(in,:);
        Proy_=(buffer(Proy_,box));
        Proy(in,:)=nanmedian(Proy_);
    end
    ECh1=ECh1(:,1:end-1);ECh2=ECh2(:,1:end-1);Proy=Proy(:,1:end-1);
    % UU=UU(:,1:end-1);
    nbeams = get(handles.BeamNumber,'String');
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
    
    %% Convert values to dB
    [ECh1dB,Eom]=fConvert2dB1(ECh1,UU,WT,3);
    aInf=find(ECh1dB==-Inf); ECh1dB(aInf)=NaN;
    bInf=find(ECh1dB==Inf); ECh1dB(bInf)=NaN;
    
    NoiseLevel=str2double(handles.NoiseLevel.String);
    %         Lmax=str2num(handles.ChannelWidth.String);
    Lused=str2double(handles.StopAnalysis.String);
    
    ECh1dBa=fCleanProfilesStandard(ECh1dB,Proy,NoiseLevel,Lused);
    ECh1dBoriginal=ECh1dBa;
    ECh1dBa=ECh1dBoriginal;
    %%%%%%%%
    switch method
        case 1
            %% 1.4 Cleaning based on the derivative method==1
            disp('Method 1')
            dthresh = str2double(get(handles.dThresh1,'String'));
            %                 dthresh=str2num(handles.dThresh1.string;)
            AW=diff(ECh1dBa,1);
            
            for n=1:size(ECh1dBa,2)
                aj=find(AW(:,n)>=dthresh);
                ECh1dBa(max(1,min(aj)-1):end,n)=NaN;
            end
        case 2
            %% 1.5 Cleaning based on the derivative, only when profile slope is negative method==2
            disp('Method 2')
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
                       
                    end
                    ECh1dBa(n2(kk)+1:end,kk)=NaN;

                else
                    n1(kk)=1;
                    n2(kk)=1;
                    ECh1dBa(:,kk)=NaN;
                end
                 
            end

        case 3
            disp('Method 3')
            %% 1.6 Cleaning based on the points given by the user method==3
%             ECh1dBa=ECh1dBoriginal; 
            n1 = str2double(get(handles.Method03Crop1,'String'));
            n2 = str2double(get(handles.Method03Crop2,'String'));
%             index=n1:n2;
            for n=1:size(ECh1dBa,2)
                ECh1dBa(1:n1,n)=NaN;
                ECh1dBa(n2+1:end,n)=NaN;
            end
        otherwise
            disp('Error! No valid method!!!!')
    end
    %%
    ECh1dB02=ECh1dBa;
    WLH=ones(size(WT))*2; %needs to be chax\nged with the right level
    adcp=get(handles.ADCPChannel,'String');
    nmedfilt=str2double(get(handles.SmoothFactor,'String'));
    frequency=str2double(get(handles.ADCPFrequency,'String'))*1000;
    [alfw, AW]=falfaw(WT,WLH,frequency);
    
    [nk, mk]=(find(isnan(ECh1dB02)));
    [nb, mb]=size(ECh1dB02);
    
    % Prod=fproduct(B);
    flag0=1;
    if nb*mb ~= size(mk,1)
        
        if method==1
            [aa,bb, SSE, R2, RMSE]=ffitechomodel(Proy,ECh1dB02);
            d2=aa./(-40*log10(exp(1)))-alfw';
            
                     
%             C=-120;
            C=str2double(handles.CInstrument.String);
            d1=10.^((bb+C)/10);
            d2(find(d2<=0))=NaN;
            [s1,r1]=hist(d2,100);
            
            d2md=medfilt1(d2,nmedfilt); %median filter on abr
            d1md=medfilt1(d1,nmedfilt); %median filter on abr
            ABR=d2md./d1md;
        elseif method==2
            echosize=size(ECh1dBa,1);
%             C=-120;
            C=str2double(handles.CInstrument.String);
            for k=1:size(n1,2)
                
                n11=n1(k);
                n22=n2(k);
%                 [n11 n22]
                if n22<echosize && (n22-n11>2)
                    [aa,bb, SSE, R2, RMSE]=ffitechomodel(Proy(n11:n22,k),ECh1dB02(n11:n22,k));
                    AA(k)=aa;
                    BB(k)=bb;
                    sSSE(k)=SSE; rR2(k)=R2; rRMSE(k)=RMSE; %rR21(k)=R21; rRMSE1(k)=RMSE1;
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
            
            d2(find(d2<=0))=NaN;
            [s1,r1]=hist(d2,100);
            d2md=medfilt1(d2,nmedfilt); %median filter on abr
            d1md=medfilt1(d1,nmedfilt); %median filter on abr
            ABR=d2md./d1md;
            
        elseif method==3
%             C=-120;
            C=str2double(handles.CInstrument.String);
            for in=1:size(ECh1dBa,2)
                av=find(~isnan(ECh1dBa(:,in)));
                if size(av,1)>3
%                     [aa,bb, SSE, R2, RMSE, R21, RMSE1]=ffitechomodel(Proy(av,in),ECh1dB02(av,in));
                    [aa,bb, SSE, R2, RMSE]=ffitechomodel(Proy(av,in),ECh1dB02(av,in));
                    d2(in)=aa./(-40*log10(exp(1)))-alfw(in);
                    d1(in)=10.^((bb+C)/10);
                else
                    d2(in)=NaN;
                    d1(in)=NaN;
                end
            end
                
%                 d2(find(d2<=0))=NaN;
                d2(find(d2<=0))=NaN;
                [s1,r1]=hist(d2,100);
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
    
    %% calibration routine
    if flag0
        
        qdate=datevec(TV);
        if minutes2(ik)==minutes1(ik)
            minutes2(ik)=minutes1(ik)+5;
        end
        
        %     [qdate(:,3) qdate(:,4) qdate(:,5)]
        %     [str2num(day1) hour2(ik) hour1(ik) minutes2(ik) minutes1(ik)]
        rt1=find(qdate(:,3)==str2num(day1) & qdate(:,4)<=hour2(ik) & qdate(:,4)>=hour1(ik) & qdate(:,5)<=minutes2(ik) & qdate(:,5)>=minutes1(ik));
        
        d2mean=nanmean(d2(rt1)); d2dailymean=nanmean(d2);
        d1mean=nanmean(d1(rt1)); d1dailymean=nanmean(d1);
        abrmean=d2mean./d1mean; abrdaily=d2dailymean./d1dailymean;
        aabbrr(ik)=abrmean; dd22(ik)=d2mean;
        DataC{ik}=[qdate(1,2) qdate(1,3) hour1(ik) minutes1(ik) d2mean/Ccalib(ik) abrmean d2mean d1mean ]';
        DataCDaily{ik}=[qdate(1,2) qdate(1,3) hour1(ik) minutes1(ik) d2dailymean/Ccalib(ik) abrdaily d2dailymean d1dailymean ]';
        % ABRmean=nanmean(ABR)
    else
        d2mean=NaN; d2dailymean=NaN;
        d1mean=NaN; d1dailymean=NaN;
        abrmean=NaN; abrdaily=NaN;
        DataC{ik}=[qdate(1,2) qdate(1,3) hour1(ik) minutes1(ik) d2mean/Ccalib(ik) abrmean d2mean d1mean ]';
        DataCDaily{ik}=[qdate(1,2) qdate(1,3) hour1(ik) minutes1(ik) d2dailymean/Ccalib(ik) abrdaily d2dailymean d1dailymean]';
        
    end
    %%
    amin=max(min(TV),datenum(start,'yyyymmdd')); amax=max(TV); aminv=datevec(amin); amaxv=datevec(amax);
    % if aminv(2)<10
    %     aux='0';
    % else
    %     aux='';
    % end
    mydate=[num2str(aminv(1))  fAddChar0(aminv(2)) fAddChar0(aminv(3))];
    mydatehour1=datenum([mydate 'T' fAddChar0(hour1(ik)) fAddChar0(minutes1(ik)) '00'],'yyyymmddTHHMMSS');
    mydatehour2=datenum([mydate 'T' fAddChar0(hour2(ik)) fAddChar0(minutes2(ik)) '00'],'yyyymmddTHHMMSS');
    amin1=datenum(mydate,'yyyymmdd');
    % amax1=datenum([num2str(amaxv(1)) aux num2str(amaxv(2)) num2str(amaxv(3))],'yyyymmdd');
    amax1=amin1+1;
    
    figure('Name',label), hold on;
    
    subplot(2,3,1), bar(r1,s1), title('Attenuation histogram')
    set(gca,'linewidth',2,'fontsize',18)
    xlabel('Attenuation (Neper/m)','fontsize',20), ylabel('# events','fontsize',20)
    
    subplot(2,3,2), plot(Proy(:,1:end),ECh1dB02(:,1:end),'o-')
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    set(gca,'linewidth',2,'fontsize',18)
    xlabel('r (m)','fontsize',20), ylabel('I (dB)','fontsize',20)
    if flag0
        title({'Processed profiles', 'DAY PROFILES'})
    else
        title(flag1)
    end
    
    rk1=find(abs(TV-mydatehour1)==min(abs(TV-mydatehour1)));
    rk2=find(abs(TV-mydatehour2)==min(abs(TV-mydatehour2)));
    subplot(2,3,3), plot(Proy(:,rk1:rk2),ECh1dB02(:,rk1:rk2),'o-')
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    set(gca,'linewidth',2,'fontsize',18)
    xlabel('r (m)','fontsize',20), ylabel('I (dB)','fontsize',20)
    if flag0
        title({'Processed profiles', 'IN THE TIME INTERVAL'})
    else
        title(flag1)
    end
    
    subplot(2,3,4), plot(TV,d2), hold on, plot(TV,d2md,'+-'), datetick('x','yymmdd')
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    set(gca,'linewidth',2,'fontsize',18)
    xlim([amin1 amax1])
    xlabel('T','fontsize',20), ylabel('alfa (dk2)','fontsize',20)
    title('Attenuation dk2','fontsize',26)
    fvline(mydatehour2); hold off
    fvline(mydatehour1);

    
    subplot(2,3,5), semilogy(TV,d1,'+-'), datetick('x','yymmdd')
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    set(gca,'linewidth',2,'fontsize',18)
    xlim([amin1 amax1])
    xlabel('T','fontsize',20), ylabel('backscatter(d1)','fontsize',20)
    title('Backscatter dk1','fontsize',26)
    fvline(mydatehour2); hold off;
    fvline(mydatehour1);
    
    subplot(2,3,6), semilogy(TV,ABR,'+-'), datetick('x','yymmdd')
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    set(gca,'linewidth',2,'fontsize',18)
    xlim([amin1 amax1])
    xlabel('T','fontsize',20), ylabel('ABR','fontsize',20)
    title('ABR','fontsize',26)
    fvline(mydatehour2); hold off;
    fvline(mydatehour1);
    %%
    TCaux=TV';
    PlotData{ik}=[TCaux ABR' d1' d2' ];
    clear L Ech1_ Ech2_ ECh1 ECh2 Proy_ Proy alfw d2 d1 aa nb mb flag0 ...
        Proy ECh1dB02 WT WLH ECh1dB TV AW ECH1 ECH2 UU aj ak i1
end
xls_check_if_open(filename,'close');