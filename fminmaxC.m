function [Lmin, Lmax]=fminmaxC(x1,x2)
%this function returns the minimun non-zero and the maximum non zero of x1
%and x2, else returns an interval [1E-3 1E2]

xaux1=min(x1);
xaux2=min(x2);

if xaux1==0 && xaux2==0
    Lmin=1E-3;
elseif xaux1==0 && xaux2~=0
    Lmin=xaux2;
elseif xaux1~=0 && xaux2==0
    Lmin=xaux1;
elseif xaux1~=0 && xaux2~=0
    Lmin=min(xaux1,xaux2);
end
clear xuax1 xaux2;
xaux1=max(x1);
xaux2=max(x2);
Lmax=max(xaux1,xaux2);

