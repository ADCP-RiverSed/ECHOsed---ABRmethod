function Str=fClock2Str()
% converts the current time instatn to a string. it rpevents to delete
% already existing files since each file will have a different time stamp as
% file name.

timestamp=clock();
YY=num2str(timestamp(1));
Month=num2str(timestamp(2));
Day=num2str(timestamp(3));
HH=num2str(timestamp(4));
MM=num2str(timestamp(5));
SS=num2str(floor(timestamp(6)));

Str=[YY Month Day HH MM SS];