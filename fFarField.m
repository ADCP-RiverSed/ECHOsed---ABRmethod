function [ffield, r0index]=fFarField(SensorDiam,frequency,csound,xdistance)
% determines at which point the far field conditions can be considered
% input variables:
% SensorDiam = sensor diameter (m)   L1 0.1144
% frequency = emitting frequency (Hz) f = 600E3
% xdistance = sample distance vector (proy_) (m)
% 
%expression from Kinsler, Frey et al. pag 180. e 7..4.9

a=SensorDiam/2; 
% AreaSensor=pi*R*R;
lambda=csound/frequency;
r0=a.^2./lambda-lambda/4;
ffield=r0;
m=find(~isnan(r0));
mnan=find(isnan(r0));
r0index=zeros(size(r0));
for i=1:size(m,2)
    if isempty(min(find(xdistance(:,m(i))<r0(m(i)))))
        r0index(m(i))=0;
    else
        r0index(m(i))=max(find(xdistance(:,m(i))<r0(m(i))));
    end
end
r0index(mnan)=NaN;

%