function yyyymmdd = fdateformat(ddmmyyyy)
% this function converts date in the format 'dd/mm/yyyy' into the format
% 'yyyymmdd' to be used by the EchoSed program
 yyyy=ddmmyyyy(7:10);
 mm=ddmmyyyy(4:5);
 dd=ddmmyyyy(1:2);
 
 yyyymmdd=[yyyy mm dd];