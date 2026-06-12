function C = fConcentration(a,b,abr,dk2)
% this function returns the Concentration value based on the model C =
% dk2/zeta.
% zeta is computed from the linear fit given by a and b coefficients
% zeta = a(1)*abr + a(2) and valid between the limits b(1) < abr < b(2)
% this means that if abr < b(1) the function "saturates" and returns b(1)
% and if abr> b(2)
% C = dk2/zeta
% a(1)
% a(2)
pcoef=a;
%check limits of abr
n1=find(abr<b(1));
n2=find(abr>b(2));
abr(n1)=b(1);
abr(n2)=b(2);

% zebra=exp(polyval(pcoef,log(aabbrr)))';
zeta=exp(polyval(pcoef,log(abr)));
C=dk2./zeta;
% disp('here')

