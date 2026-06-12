function ECh1dBa=fCleanProfilesStandard(ECh1dB,Proy,NoiseLevel,Lused)
% This function applies the standard cleaning 
% 1.1 Cleaning the ECh1dB profiles that have NaN in the first 2 values
% 1.2 Setting to NaN the profile parts that are longer than the river width - a given number of cells
% 1.3 Cleaning the part of ECh1dB profiles that are under the noise level NL. By default NL=10

%% 1.1 Cleaning the ECh1dB profiles that have NaN in the first 2 values
ECh1dBa=ECh1dB;
[aw, bw]=find(isnan(ECh1dB(1:2,:)));
ECh1dBa(:,bw)=NaN;

%% 1.2 Setting to NaN the profile parts that are longer than the river width - a given number of cells
% 1. river limit
% Lmax=find(abs(proy_(:,1)-RiverWidth)==min(abs(proy_(:,1)-RiverWidth)));
dx=mean(mean(diff(Proy))); N=floor(Lused/dx);
% Lmax=Lmax;
Lthresh=floor(N);
ECh1dBa(Lthresh:end,:)=NaN;

%% 1.3 Cleaning the part of ECh1dB profiles that are under the noise level NL. By default NL=10
NL=NoiseLevel;
anl=find(ECh1dBa<=NL);
ECh1dBa(anl)=NaN;
ECh1dBoriginal=ECh1dBa;

%% 1.3.1 Cleaning profiles that have less than 3 points 
%% 1.1.1 Cleaning profiles that have only 2 non-Nan values
% ECh1dBa=ECh1dB;
NS=size(ECh1dBa,2);
NP=size(ECh1dBa,1);
for k=1:NS
    az=size(find(isnan(ECh1dBa(:,k))),1);
    if az>=NP-3
        ECh1dBa(:,k)=NaN;
    end
end