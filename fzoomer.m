function [imin, imax]=fzoomer(TV8,tstart,tend)
%this function returns the indexes imin and imax to do a zoom in a time
%series
datebegin=datenum(tstart,'yyyymmdd'); dateend=datenum(tend,'yyyymmdd');

T1=abs(TV8-datebegin); T2=abs(TV8-dateend);
imin=find(T1==min(abs(T1))); imax=find(T2==min(abs(T2)));
