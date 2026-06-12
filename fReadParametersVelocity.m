function  [varargout] = fReadParametersVelocity(WorkingFolder,listing_res, start, endng)
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

%Ambiguity velocity  % what is this
adcp='L1'; %attention here
if adcp=='L1'
    WV=2.30;
elseif adcp=='L2'
    WV=2.90;
end

b1=pi*70/180;b2=pi*110/180;

progressbar('Reading data')
NN=length(listing_res);
I=0;%day index
for m_in=3:length(listing_res)
    if str2num(listing_res(m_in).name(1:8))>=str2num(start) & str2num(listing_res(m_in).name(1:8))<=str2num(endng);%fixing the data subset
       
    FileName=strcat(WorkingFolder,'\',num2str(listing_res(m_in).name));   
    if exist(FileName)
        A=load(FileName);
        t_=(A.Res{1});
        proy_=((A.Res{2}));  %% Distance from ADCP head in m
        ech1_=(A.Res{3});  %%%Echo beam1
        ech2_=(A.Res{4});  %%%Echo beam2
        v1_=(A.Res{5})./1000;  %%%x direction velocity in m/s
        v2_=(A.Res{6})./1000;  %%%y direction velocity in m/s here
%         disp('here')
    i=find(t_>=Start & t_<=Endng);
    if isempty(i)==0
        I=I+1;
        t{I}=t_(i);
        v1{I}=v1_(:,i);
        v2{I}=v2_(:,i);
        proy{I}=proy_(:,i);
        day(I)=datenum(listing_res(m_in).name(1:8),'yyyymmdd');
        ech1{I}=ech1_(:,i);ech2{I}=ech2_(:,i);
        WN=size(proy{I});nens=WN(2);WN=WN(1);
        %Beam versors
        versoreb1(:,1)=zeros(WN,1)+cos(b1);versoreb1(:,2)=zeros(WN,1)+sin(b1);
        versoreb2(:,1)=zeros(WN,1)+cos(b2);versoreb2(:,2)=zeros(WN,1)+sin(b2);
        %Water velocity in beam coordinates (+ for ejecting velocities from transducers)
        for i=1:nens
            vb1{I}(:,i)=sum(([v1{I}(:,i) v2{I}(:,i)].*versoreb1)')';
            vb2{I}(:,i)=sum(([v1{I}(:,i) v2{I}(:,i)].*versoreb2)')';
            %WV limit trashold
            J=find(abs(vb1{I}(:,i))>WV | abs(vb2{I}(:,i))>WV);% | v1{I}(:,i)>5 v2{I}(:,i)>5;
            if isempty(J)==0
                vb1{I}(J,i)=NaN;v1{I}(J,i)=NaN;
                vb2{I}(J,i)=NaN;v2{I}(J,i)=NaN;
                clear J
            end
        end
        %Polar coordinates
        ro{I}=(v1{I}.^2+v2{I}.^2).^.5;ph{I}=atan2(v2{I},v1{I});             
        %figure(1),polar(ph{I},ro{I},[colore(I) 'o']);hold on
        
        

    else
        disp('File not found')
    end
    end
    end
end
% m_in

%Results from daily variables to entire period vectors 
Tv=cell2mat(t);
v1v=cell2mat(v1);
v2v=cell2mat(v1);
vb1v=cell2mat(vb1);
vb2v=cell2mat(vb2);
rov=cell2mat(ro);
phv=cell2mat(ph);
ECH1=cell2mat(ech1);
ECH2=cell2mat(ech2);
% 
% Tv=[];v1v=[];v2v=[];vb1v=[];vb2v=[];rov=[];phv=[];ECH1=[];ECH2=[];
% for i=1:I
%     Tv=[Tv t{i}];
%     v1v=[v1v v1{i}];
%     v2v=[v2v v2{i}];    
%     vb1v=[vb1v vb1{i}];
%     vb2v=[vb2v vb2{i}];    
%     rov=[rov ro{i}];
%     phv=[phv ph{i}];
%     ECH1=[ECH1 ech1{i}];
%     ECH2=[ECH2 ech2{i}];
% end


varargout{1}=Tv;
varargout{2}=v1v;
varargout{3}=v2v;
varargout{4}=vb1v;
varargout{5}=vb2v;
varargout{6}=rov;
varargout{7}=phv;
varargout{8}=ECH1;
varargout{9}=ECH2;
varargout{10}=WN;
varargout{11}=proy_;

