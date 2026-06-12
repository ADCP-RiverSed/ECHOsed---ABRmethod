function [dECho,dEChoMax,Imax]=fechoderivative(ECh1dB)
%this function determines the derivative of the echo profiles, its maximum
%and where it happens,
% ECh1dB=ECh1dB02;
dECho=diff(ECh1dB);
n0=size(dECho,2);
dEChoMax=zeros(n0,1); Imax=dEChoMax;
for j=1:n0
    dEChoMax(j)=max(dECho(:,j));
    aux=min(find(dECho(:,j)==dEChoMax(j)));  
    if isempty(aux)
        Imax(j)=NaN;
    else
        Imax(j)=aux;
    end
end