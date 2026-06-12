function string = ftag2str2(i)
%TAG2STR2   like int2str, but format integer (from 0 to 99) with a constant length of 2
% 
% Prepared by Benoit Spinewine

if i<10
  string = ['0' int2str(i)];
else
  string = int2str(i);
end