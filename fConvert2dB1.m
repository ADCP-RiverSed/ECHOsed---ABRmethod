function [ECh1dB, Eom]=fConvert2dB1(ECh1,UU,WT,method)
% converts echo signals into dB using different expression. 
% Use method=3 for better results
% method=1 Expression by Deines;
% method=2 Gostiaux and van Haren; (has an error)
% method=3: Expression by TRDI-FST 

% ECh1 echos, UU voltage, WT water temperature

% kc=0.4;
kc=127.3./(WT+273.16);

ns=size(ECh1,1);
Uecho=repmat(UU,ns,1);

Eom=min(ECh1);

switch method
            
    case 1
        %Deines
        Eom=min(ECh1);
        D2=repmat(Eom,size(ECh1,1),1);
        D=kc*(ECh1-D2);
    case 2
        % Gostiaux and van Haren
        % Eo determination: media of the 3 last values
        % Eom=zeros(size(ECh1,2),1);
        % Eom=min(ECh1)-1;
        Eom=min(ECh1);
        thresh=kc.*(ECh1-Eom);
        [ithresh,jthresh]=find(thresh(1,:)<=40); %perche 40?
        
        NoValue=0; %This cuts the contribution of the voltage.
        
        A1=10.^(ECh1.*kc/10);
        a2=10.^(Eom.*kc/10); A2=repmat(a2,size(ECh1,1),1);
        A3=10*log10(Uecho.^2)*NoValue;
        ECh1dB=10*log10((A1-A2))-A3;
        ECh1dB(:,jthresh)=NaN;
%         ECh1dB=(ECh1-repmat(Eom,size(ECh1,1),1))*kc;
    case 3
        % TRDI-FST expression     
        A1=10.^(ECh1.*kc/10);
        a2=10.^(Eom.*kc/10); A2=repmat(a2,size(ECh1,1),1);
        B=(A1./A2);
        ECh1dB=10*log10(B-1);
end