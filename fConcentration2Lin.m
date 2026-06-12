function C = fConcentration2(a,b,abr,dk2)
% this function returns the Concentration value based on the model C =
% dk2/zeta.

% zeta is computed from the polynomial ratio
% and if abr> b(2)
% C = dk2/zeta
% a(1)
% a(2)
pcoef=a;
% b
%check limits of abr
n1=find(abr<b(1));
n2=find(abr>b(2));
abr(n1)=b(1);
abr(n2)=b(2);

zetaN=polyval(pcoef(1:end),(abr));
% zebraN1=polyval(pcoef(1:end-1),(abr(n1)));
% zebraN2=polyval(pcoef(1:end-1),(abr(n2)));

% zeta=zebraN./(abr+pcoef(end));
zeta=zetaN;
% zeta1=zebraN1./(abr(n1)+pcoef(end));
% zeta2=zebraN2./(abr(n2)+pcoef(end));

% figure(100), loglog(abr,zebraN,'ko'), hold on, loglog(abr(n1),zebraN1,'rs'), loglog(abr(n2),zebraN2,'rs')
% figure(101), loglog(abr,zeta,'ko'), hold on, loglog(abr(n1),zeta1,'rs'), loglog(abr(n2),zeta2,'rs')
% % zebra=exp(polyval(pcoef,log(aabbrr)))';
% zeta=exp(polyval(pcoef,log(abr)));
C=dk2./zeta;
% disp('here')

