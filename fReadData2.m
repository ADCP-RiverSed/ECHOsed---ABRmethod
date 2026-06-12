function [Echo, Echominus, Echoplus, Proy, WT, TV]=fReadData2(handles,StartDate,EndDate,WorkingFolder,adcp,frequency,listing_res,box)


    start=StartDate; %[year starting{ndate}];%fixing the data subset start
    endng=EndDate; %[year ending{ndate}]; %1231';%fixing the data subset end

    % Beam angles in the x-y instrument coordinates (x from transducer 2 to 1; y from instrument to farfield)
    b1=pi*70/180;b2=pi*110/180;
    
    I=0;%day index
    
    Start=datenum(start,'yyyymmdd');
    Endng=datenum(endng,'yyyymmdd');
    
    % Data reading
    [t, wt, proy1, ~, ech1, ech2, WN, nens, dpro, Tv, Wt, ECH1, ECH2, Uecho] = fReadParameters3(WorkingFolder,adcp,listing_res, start, endng);

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
%     save('tempus.mat','TV');
    WT=nanmedian(WT);WT=WT(1:end-1);
    UU=nanmedian(UU);UU=UU(1:end-1);

    IndexAux=zeros(size(TV,2),1); % track the indexes changed
    
    csound=fCsound(WT,0);
    
    %% Determining where the far field conditions are valid
    SensorDiam=0.1144; 
    [ffield, r0index]=fFarField(SensorDiam,frequency,csound,proy_);
    %%
    %Boxcar averagging for echoes
    k0=size(ECH1,1); %k=kk(1);
    baux=find(SKIP);
    for i=1:k0
        Ech1_=ECH1(i,:); Ech2_=ECH2(i,:);
        Ech1_=(buffer(Ech1_,box)); Ech2_=(buffer(Ech2_,box));
        ECh1(i,:)=nanmedian(Ech1_);ECh2(i,:)=nanmedian(Ech2_);
        ECh1std(i,:)=nanstd(Ech1_);ECh2std(i,:)=nanstd(Ech2_);
        %     ECh1(i,baux)=NaN; ECh2(i,baux)=NaN; %using logical indexing
        Proy_=proy_(i,:);
        Proy_=(buffer(Proy_,box));
        Proy(i,:)=nanmedian(Proy_);
    end
    ECh1=ECh1(:,1:end-1);ECh2=ECh2(:,1:end-1);Proy=Proy(:,1:end-1);
    ECh1std=ECh1std(:,1:end-1);ECh2std=ECh2std(:,1:end-1);
    
    ECh1plus=ECh1+2*ECh1std;
    ECh1minus=ECh1-2*ECh1std;
    
    ECh2plus=ECh2+2*ECh2std;
    ECh2minus=ECh2-2*ECh2std;
    
% UU=UU(:,1:end-1);
% for paper
save('Echos_raw.mat','Tv','ECH1','TV','UU','Uecho','ECh1','Proy','Wt');


nbeams = get(handles.BeamNumber,'String');
SelectedBeam=str2double(nbeams); %beam to be used
%% Beam selection
switch SelectedBeam
    case 1
        ECh1=ECh1;
        ECh1plus=ECh1plus;
        ECh1minus=ECh1minus;
    case 2
        clear ECh1 ECh1plus ECh1minus;
        ECh1=ECh2;
        ECh1plus=ECh2plus;
        ECh1minus=ECh2minus;
    otherwise
        msgbox('Error! Beam should be 1 or 2. Using Beam 1')
        %return
        %error('Error! Beam should be 1 or 2')
end

%% Convert values to dB
[ECh1dB,Eom]=fConvert2dB1(ECh1,UU,WT,3);
[ECh1plusdB,Eom]=fConvert2dB1(ECh1plus,UU,WT,3);
[ECh1minusdB,Eom]=fConvert2dB1(ECh1minus,UU,WT,3);
aInf=find(ECh1dB==-Inf); ECh1dB(aInf)=NaN;
bInf=find(ECh1dB==Inf); ECh1dB(bInf)=NaN;

ECh1dBplus(aInf)=NaN; ECh1dBplus(bInf)=NaN;
ECh1dBminus(aInf)=NaN; ECh1dBminus(bInf)=NaN;

Echo=ECh1dB;
Echominus=ECh1minusdB;
Echoplus=ECh1plusdB;

save('Echos_raw.mat','Tv','ECH1','TV','UU','Uecho','ECh1','Proy','Wt','Echo');