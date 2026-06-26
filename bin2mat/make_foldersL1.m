clear

DAT=dir;
nf=size(DAT);nf=nf(1);
start=260101;
endin=260131;
warning off

current0=0;count=0;
for i=1:nf
    if length(DAT(i).name)==12
        current=DAT(i).name(3:8);
        if str2num(current)>=start & str2num(current)<=endin
            folder=['C:\Users\massimo.guerrero\OneDrive - Alma Mater Studiorum Università di Bologna\Monitoring@Kokel\ADCP_rawdata\Dati_L1\20' current];
            mkdir(folder);curent0=str2num(current);
            movefile(DAT(i).name,folder,'f');
            if DAT(i).name(end)=='1'
                disp(folder(end-10:end))
            end
        end
    end
end
warning on