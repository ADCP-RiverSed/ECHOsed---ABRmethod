% function fCalibration2(method,arguments)
    
    % generic data for calibration processing
    dthresh=-2; method=1;
    box=2; %number of ens to be averaged () 1 measurement each 2 min: 2* 30 = 60 min
    nmedfilt=3; %median smooth
    b1=pi*70/180;b2=pi*110/180;
    WorkingFolder=get(handles.OutputFolder,'String');
    adcp=get(handles.ADCPChannel,'String');
    frequency=str2num(get(handles.ADCPFrequency,'String'))*1000;
    listing_res=dir([WorkingFolder,adcp]);
    calibfolder = get(handles.CalibrationFolder,'String');
    RiverWidth=15; %maximum extension
    nlimit=5; %to be defined by the user number of cells before the oppposite bank
    
    filename='Calibration.xlsx';
    [num,txt,raw] = xlsread([calibfolder filename]);
    
    
    npoints=size(num,1);
    
    for ik=1:npoints
        A=num(ik,1); hr=datestr(A,'HH:MM');
        hour1(ik)=str2num(hr(1:2));
        dat1=txt{ik+1,1};
        %         datok=fdateformat(dat1)
        minutes1(ik)=str2num(hr(4:5));
        B=num(ik,2); hr=datestr(B,'HH:MM');
        hour2(ik)=str2num(hr(1:2));
        minutes2(ik)=str2num(hr(4:5));
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
        %% Convert values to dB
        [ECh1dB,Eom]=fConvert2dB1(ECh1,UU,WT,3);
        aInf=find(ECh1dB==-Inf); ECh1dB(aInf)=NaN;
        bInf=find(ECh1dB==Inf); ECh1dB(bInf)=NaN;
        
        NoiseLevel=str2num(handles.NoiseLevel.String);
%         Lmax=str2num(handles.ChannelWidth.String);
        Lused=str2num(handles.StopAnalysis.String);
        
        ECh1dBa=fCleanProfilesStandard(ECh1dB,Proy,NoiseLevel,Lused);
%         %% 1.1 Cleaning the ECh1dB profiles that have NaN in the first 2 values
%         ECh1dBa=ECh1dB;
%         [aw, bw]=find(isnan(ECh1dB(1:2,:)));
%         ECh1dBa(:,bw)=NaN;
% 
%         %% 1.2 Setting to NaN the profile parts that are longer than the river width - a given number of cells
%         % 1. river limit
%         Lmax=find(abs(proy_(:,1)-RiverWidth)==min(abs(proy_(:,1)-RiverWidth)));
%         Lmax=15; ncells=3; dx=mean(mean(diff(Proy))); N=floor(Lmax/dx);
%         Lthresh=floor(N-ncells);
%         ECh1dBa(Lthresh:end,:)=NaN;
%         
%         %% 1.3 Cleaning the part of ECh1dB profiles that are under the noise level NL. By default NL=10
%         NL=10;
%         anl=find(ECh1dBa<=NL);
%         ECh1dBa(anl)=NaN;
%         ECh1dBoriginal=ECh1dBa;

        switch method
            case method==1
                %% 1.4 Cleaning based on the derivative method==1
                disp('Method 1')
                AW=diff(ECh1dBa,1);
                
                for n=1:size(ECh1dBa,2)
                    aj=find(AW(:,n)>=dthresh);
                    ECh1dBa(max(1,min(aj)-1):end,n)=NaN;
                end
            case method==2
                %% 1.5 Cleaning based on the derivative, only when profile slope is negative method==2
                disp('Method 2')
                dLim1=-0.5;
                ECh1dBa=ECh1dBoriginal;
                for n=1:size(ECh1dBa,2)
                    AW=diff(ECh1dBa(:,n));
                    an=find(AW<dLim1);
                    AuxDB=AW;
                    AuxDB(~an)=NaN;
                    ak{n}=find(AuxDB<=dthresh);
                    ECh1dBa(~ak{n},n)=NaN;
                end
            case method==3
                disp('Method 3')
                %% 1.6 Cleaning based on the points given by the user method==3
                ECh1dBa=ECh1dBoriginal; nelements=5;
                n1=0; n2=n1+nelements;
                index=n1:n2;
                for n=1:size(ECh1dBa,2)
                    ECh1dBa(1:n1,n)=NaN;
                    ECh1dBa(n2+1:end,n)=NaN;
                end
            otherwise
                disp('error')
        end
       %%
       ECh1dB02=ECh1dBa;
       WLH=ones(size(WT))*2; %needs to be chax\nged with the right level
       [alfw, AW]=falfaw(WT,WLH,frequency);
       
       [nk, mk]=(find(isnan(ECh1dB02)));
       [nb, mb]=size(ECh1dB02);
       
       % Prod=fproduct(B);
       flag0=1;
       if nb*mb ~= size(mk,1)
           [aa,bb, SSE, R2, RMSE, R21, RMSE1]=ffitechomodel(Proy,ECh1dB02);
           d2=aa./(-40*log10(exp(1)))-alfw';
           
           [s1,r1]=hist(d2,100);
           
           C=-120;
           d1=10.^((bb+C)/10);
           d2(find(d2<=0))=NaN;
           
           d2md=medfilt1(d2,nmedfilt); %median filter on abr
           d1md=medfilt1(d1,nmedfilt); %median filter on abr
           ABR=d2md./d1md;
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
       
       figure('Name',label),
       
       subplot(2,3,1), bar(r1,s1), title('Attenuation histogram')
       set(gca,'linewidth',2,'fontsize',18)
       xlabel('Attenuation (Neper/m)','fontsize',20), ylabel('# events','fontsize',20)
       subplot(2,3,2), plot(Proy(:,1:end),ECh1dB02(:,1:end),'o-')
       set(gcf,'units','normalized','outerposition',[0 0 1 1])
       set(gca,'linewidth',2,'fontsize',18)
       xlabel('r (m)','fontsize',20), ylabel('I (dB)','fontsize',20)
       if flag0
           title('Processed profiles')
       else
           title(flag1)
       end
       
       subplot(2,3,3), plot(TV,d2), hold on, plot(TV,d2md,'r-'), datetick('x','yymmdd')
       fvline(mydatehour2); fvline(mydatehour1)
       set(gcf,'units','normalized','outerposition',[0 0 1 1])
       set(gca,'linewidth',2,'fontsize',18)
       xlim([amin1 amax1])
       xlabel('T','fontsize',20), ylabel('alfa (dk2)','fontsize',20)
       title('Attenuation dk2','fontsize',26)
       
       subplot(2,3,4), semilogy(TV,d1), datetick('x','yymmdd')
       fvline(mydatehour2); fvline(mydatehour1)
       set(gcf,'units','normalized','outerposition',[0 0 1 1])
       set(gca,'linewidth',2,'fontsize',18)
       xlim([amin1 amax1])
       xlabel('T','fontsize',20), ylabel('backscatter(d1)','fontsize',20)
       title('Backscatter dk1','fontsize',26)
       
       
       subplot(2,3,5), semilogy(TV,ABR), datetick('x','yymmdd')
       fvline(mydatehour2); fvline(mydatehour1)
       set(gcf,'units','normalized','outerposition',[0 0 1 1])
       set(gca,'linewidth',2,'fontsize',18)
       xlim([amin1 amax1])
       xlabel('T','fontsize',20), ylabel('ABR','fontsize',20)
       title('ABR','fontsize',26)
       
       %%
       
       clear L Ech1_ Ech2_ ECh1 ECh2 Proy_ Proy alfw d2 d1 aa nb mb flag0 ...
           Proy ECh1dB02 WT WLH ECh1dB TV AW ECH1 ECH2 UU aj ak i1
    end
    %     DataC
    %% determination of the calibration curve
    C1=cell2mat(DataC);
    C2=cell2mat(DataCDaily);
    
    xcal=C1(6,:); ycal=C1(5,:);
    xcal=xcal(~(isnan(xcal)));
    ycal=ycal(~(isnan(ycal)));
    
    pcoef=polyfit(log(xcal),log(ycal),1);
    xmin=min(xcal);
    xmax=max(xcal);
    xtest=logspace(1,8);
    amin=find(xtest<=xmin); xtest(amin)=xmin;
    amax=find(xtest>=xmax); xtest(amax)=xmax;
    ytest=polyval(pcoef,log(xtest));
    
    %     header={'Month' 'Day' 'hour' 'minute' 'zeta' 'Abr' 'Attenuation' 'Backscatter'};
    %     xlswrite('CalibrationOutput.xlsx',header,'Hour','A1');
    %     xlswrite('CalibrationOutput.xlsx',C1','Hour','A2');
    %     xlswrite('CalibrationOutput.xlsx',header,'Daily','A1');
    %     xlswrite('CalibrationOutput.xlsx',C2','Daily','A2');
    
    load('ratio06.mat')
    figure('Name','Calibration')
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    loglog(ratio,zetav,'k.','MarkerSize',6), hold on,
    scatter((ratio0(1:end-8)),(zeta0v(1:end-8)),100,(gg(1:end-8)*10^6),'o','filled');
    caxis([1 200]), colorbar;
    h = colorbar;
    title(h, 'd ($$\mu$$m)','interpreter','latex','fontsize',30)
    ylabel('\zeta_{s} (m^2/kg)','fontname','times','fontsize',28);
    xlabel('ABR','fontname','times','fontsize',28);
    
    %figure,
    loglog(C1(6,:),C1(5,:),'ks','MarkerSize',12,'MarkerFaceColor',[0 0 0])
    loglog((xtest),exp(ytest),'r*-')
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    set(gca,'linewidth',2,'fontsize',18)
    
    title('zeta vs Abr','fontsize',26)
    
    %     hm=msgbox('Calibration curve determined')
    
    zebra=exp(polyval(pcoef,log(aabbrr)))';
    Cmeasured=dd22'./zebra;
    
    naux1=(isfinite(Cmeasured));
    CC1=Cmeasured(naux1);
    CCx=Ccalib(naux1);
    naux2=find(CC1);
    CC2=CC1(naux2);
    Cy=CCx(naux2);
    [yfit,S]=polyfit(log10(CC2),log10(Cy'),1);
    [Lmin,Lmax]=fminmaxC((Cmeasured),(Ccalib));
    i1=floor(log10(Lmin));
    i2=ceil(log10(Lmax));
    xx11=logspace(i1,i2);
    yval=polyval(yfit,Cy);
    [r2, rmse]=frsquare(log10(Cy),log10(yval));
    
    %%
    StringTitle=['y =' num2str(yfit(1))   '*x' ' + ' num2str(yfit(2)) '  R^2 = ' num2str(r2)];
    figure, loglog(Ccalib,Cmeasured,'k*','MarkerSize',10), hold on, plot(xx11,xx11,'k-','linewidth',2), ...
        plot(xx11,10.^polyval(yfit,log10(xx11)),'linewidth',2)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    set(gca,'linewidth',2,'fontsize',18)
    legend('Data','y=x','linear fit','location','NorthWest')
    title(StringTitle)