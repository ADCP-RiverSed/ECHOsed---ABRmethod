function [TV,abr,dk1,dk2]=fProcessing(adcp,WorkFolder,freq,StartDate,EndDate,box,dThresh,RiverWidth)
%  dk2 and dk1: the attenuation and backscatter

% disp('here')
% StartDate

%% where the data is stored
%adcp='L1';%L1 is 600 kHz, L2 is 1200 kHz
if strcmp(adcp,'L1')
    frequency=freq;
elseif strcmp(adcp,'L2')
    frequency=freq;
end

WorkingFolder=WorkFolder; %'C:\Users\Rui Aleixo\SharePoint\Massimo Guerrero\Kokel_Monitoring\Risultati_';
listing_res=dir([WorkingFolder,adcp]); %%%%Folders in the data's folder
%% 
% year='2016';
% starting={'1110'}; %{'1129'}; %{'0919'};
% ending={'1110'};

% day1=str2num(ending{1}(3:4)); hour1=10; minutes1=20; hour2=10; minutes2=30;

% starting={'0912'}; % ending={'0914'}; 
dthresh=dThresh;
%%
for ndate=1:1

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
        %     ECh1(i,baux)=NaN; ECh2(i,baux)=NaN; %using logical indexing
        Proy_=proy_(i,:);
        Proy_=(buffer(Proy_,box));
        Proy(i,:)=nanmedian(Proy_);
    end
    ECh1=ECh1(:,1:end-1);ECh2=ECh2(:,1:end-1);Proy=Proy(:,1:end-1);
% UU=UU(:,1:end-1);
%% Convert values to dB
[ECh1dB,Eom]=fConvert2dB1(ECh1,UU,WT,3);
aInf=find(ECh1dB==-Inf); ECh1dB(aInf)=NaN;
bInf=find(ECh1dB==Inf); ECh1dB(bInf)=NaN;
%% Cleaning the ECh1dB profiles that have NaN in the first 2 values
[aw, bw]=find(isnan(ECh1dB(1:2,:)));
ECh1dB(:,bw)=NaN;

% clean profiles needs improvement 
% 1. river limit
riverwidth=RiverWidth; %maximum extension
Lmax=find(abs(proy_(:,1)-riverwidth)==min(abs(proy_(:,1)-riverwidth)));
nlimit=5; %to be defined by the user number of cells before the oppposite bank
ECh1dB02=ECh1dB;
ECh1dB02(Lmax-nlimit:end,:)=NaN;

i1=find(ECh1dB02(1,:)<=0);
%remove useless profiles
ECh1dB02(:,i1)=NaN;
%here we select which second points are in the noise region
[aa,ss]=find(ECh1dB02<=0);
for j=1:size(aa,1)
    ECh1dB02(aa(j):end,ss(j))=NaN;
end

for j=1:size(ECh1dB02,2)
    L(j) = length(find(~isnan(ECh1dB02(:,j))));
end
ak=find(L<=1);
ECh1dB02(:,ak)=NaN;

%calculate the derivative
AW=diff(ECh1dB02,1);

for n=1:size(ECh1dB02,2)
    aj=find(AW(:,n)>=dthresh);
    ECh1dB02(max(1,min(aj)-1):end,n)=NaN;
end
    
WLH=ones(size(WT))*2; %needs to be chax\nged with the right level
[alfw, AW]=falfaw(WT,WLH,frequency);
% size(alfw)
% size(Proy)
[nk, mk]=(find(isnan(ECh1dB02)));
[nb, mb]=size(ECh1dB02);
% Prod=fproduct(B);
flag0=1;
if nb*mb ~= size(mk,1) 
    [aa,bb, SSE, R2, RMSE, R21, RMSE1]=ffitechomodel(Proy,ECh1dB02);
    d2=aa./(-40*log10(exp(1)))-alfw';
    
    [s1,r1]=hist(d2,100);
    figure, bar(r1,s1), title('Attenuation histogram')
    
    C=-120;
    d1=10.^((bb+C)/10);
    d2(find(d2<=0))=NaN;
    nmedfilt=3;
    d2md=medfilt1(d2,nmedfilt); %median filter on abr
    d1md=medfilt1(d1,nmedfilt); %median filter on abr
    ABR=d2md./d1md;
else
    d2=NaN;
    d2md=NaN;
    d1=NaN;
    d1md=NaN;
    ECh1dB02=ECh1dB;
    ABR=NaN;
    flag0=0;
    flag1='Problem with the profiles!!!!!';
end

end
%%

figure, subplot(2,2,1), plot(Proy(:,1:end),ECh1dB02(:,1:end),'o-')
set(gcf,'units','normalized','outerposition',[0 0 1 1])
set(gca,'linewidth',2,'fontsize',18)
xlabel('r (m)','fontsize',20), ylabel('I (dB)','fontsize',20)
if flag0
    title('Processed profiles')
else
    title(flag1)
end
% print('-dpng','-r600','I01.png')
%
amin=min(TV); amax=max(TV); aminv=datevec(amin); amaxv=datevec(amax);
amin1=datenum([num2str(aminv(1)) fAddChar0(aminv(2)) fAddChar0(aminv(3))],'yyyymmdd');
amax1=datenum([num2str(amaxv(1)) fAddChar0(amaxv(2)) fAddChar0(amaxv(3))],'yyyymmdd');

subplot(2,2,2), plot(TV,d2), hold on, plot(TV,d2md,'r-'), xlim([amin1 amax1+1]), datetick('x','yymmdd')
set(gcf,'units','normalized','outerposition',[0 0 1 1])
set(gca,'linewidth',2,'fontsize',18)
xlabel('T','fontsize',20), ylabel('alfa (dk2)','fontsize',20)
title('Attenuation dk2','fontsize',26)
% print('-dpng','-r600',['d02_' '.png'])
%
subplot(2,2,3), semilogy(TV,d1), datetick('x','yymmdd')
set(gcf,'units','normalized','outerposition',[0 0 1 1])
set(gca,'linewidth',2,'fontsize',18)
xlabel('T','fontsize',20), ylabel('backscatter(d1)','fontsize',20)
title('Backscatter dk1','fontsize',26)
% print('-dpng','-r600','d01.png')

subplot(2,2,4), semilogy(TV,ABR), datetick('x','yymmdd')
set(gcf,'units','normalized','outerposition',[0 0 1 1])
set(gca,'linewidth',2,'fontsize',18)
xlabel('T','fontsize',20), ylabel('ABR','fontsize',20)
title('ABR','fontsize',26)

% print('-dpng','-r600',['ABR' starting{1}      'A' '.png'])
% 
% d11=nanmedian(d1(tk1.DataIndex(1):tk2.DataIndex(1)))
% d22=nanmedian(d2(tk1.DataIndex(1):tk2.DataIndex(1)))

% Dates={'20160406' '20160920' '20161110' '20161128' '20161130' '20171202' '20171205' '20171207'};
% CKokel=[(45+51)/2 431 1117 45 52 (4424+7795)/2 776 170];
% for i=1:8
%     T=Dates{i};
%     S0=datenum(T,'yyyymmdd');
%     S1=S0+1;
%     q0=find(abs(TV-S0)==min(abs(TV-S0)));
%     q1=find(abs(TV-S1)==min(abs(TV-S1)));
%     
%     d2mean(i)=nanmean(d2(q0:q1)); d2std(i)=nanstd(d2(q0:q1));
%     d1mean(i)=nanmean(d1(q0:q1)); d1std(i)=nanstd(d1(q0:q1));
% end
%%
% 
% load forfit.mat
% x2=P1.Position(1); y2=P1.Position(2);
% x1=P2.Position(1); y1=P2.Position(2);
% 
% yfit=polyfit(log10([x1 x2]),[y1 2*y2],1);
% zeta=polyval(yfit,log10(ABR));
% figure, semilogx(ABR,zeta), title('Zeta function'), xlabel('ABR'), ylabel('zeta')
% 
%   start='20160501'; endng='20160914';  %start='20160720'; endng='20160801';
% load Level_Nils.mat; 
% % figure, plot(t1,p1,'k-') datetick('x','dd/mm/yy'); 
% 
% [i,j]=fzoomer(t1,start,endng);
% % [i1,j1]=fzoomer(TV,start,endng);
% xmin=min(min(TV));
% xmax=max(max(TV));
% 
% % figure, subplot(2,1,1), plot(t1(i:j),p1(i:j)), xlim([xmin xmax]), ylim([0 3]), title('Level'),hold on
% %         %subplot(3,1,2), plot(TV,dk2,'r'), xlim([xmin xmax]), title('Attenuation 1st point')
% %         subplot(2,1,2), plot(TV,d2,'k'), xlim([xmin xmax]), title('Attenuation profile')
% %         set(gcf,'units','normalized','outerposition',[0 0 1 1])
% % 
% 
% Concentration=d2./zeta;
% figure, semilogy(TV,Concentration,'ko-'), hold on,  plot(t1(i:j),p1(i:j),'r-'), xlim([xmin xmax]), title('Concentration time-series')
% datetick('x','dd/mm/yy')
% 
% 
% [g,h]=hist(log10((Concentration)),100); title('Concentration histogram')
% figure, bar(h,g)
% % [dECho,dEChoMax,Imax]=fechoderivative(ECh1dB02);
% %%
% i1=Day1.DataIndex;
% i2=Day2.DataIndex;
% i3=Day3.DataIndex;
% i4=Day4.DataIndex;
% 
% figure, plot(ECh1dB02(:,i1),'r+-'), hold on, plot(ECh1dB02(:,i2),'ko-'),plot(ECh1dB02(:,i3),'bd-'),plot(ECh1dB02(:,i4),'m<-')
% 


abr=ABR;
dk1=d1md;
dk2=d2md;

end
