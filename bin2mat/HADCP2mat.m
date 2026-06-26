
clear all
%close all
clc

beams=2;%numero di fasci
adcp='L1';%L1 is 600 kHz, L2 is 1200 kHz
if char(adcp)=='L1';kHz='001001011';else; kHz='001001100';end
    
listing1=dir(['C:\Users\massimo.guerrero\OneDrive - Alma Mater Studiorum Università di Bologna\Kokel_Monitoring\ADCP_rawdata\Dati_' adcp]); %%%%Folders in the data's folder

start=20250101;%fixing the data subset start
endng=20250531;%fixing the data subset end
ndays=endng-start+1;
disp('Month00-Days00')
disp(num2str(ndays))
%pause(200)
for m_in=3:length(listing1)
        
    if str2num(listing1(m_in).name)>=start & str2num(listing1(m_in).name)<=endng;%fixing the data subset
  
    clear listing2 nome pop EX EZ EZ1 EA EB EH EP ER WT SS V1 PROY PGD1 PGD2 STD1 STD2
    clear V2 PS B1ST Vb1 Vb2 COR1 COR2 ECH1 ECH2 WP WS WF TP TIME TIM_m ED ES XmitV
    clear VL WT EP ER WS WF B1ST ADCP
    nens=0;NENS=0;
    listing2=dir(strcat('C:\Users\massimo.guerrero\OneDrive - Alma Mater Studiorum Università di Bologna\Kokel_Monitoring\ADCP_rawdata\Dati_',adcp,'\',num2str(listing1(m_in).name))');
    
    nfiles=length(listing2)-2;
    
    for pop=1:nfiles
        nome{pop}=listing2(pop+2).name;
    end
        
    %%%%%Precedent functions
   
    for file=1:nfiles
        [fid,message] = fopen(strcat('C:\Users\massimo.guerrero\OneDrive - Alma Mater Studiorum Università di Bologna\Kokel_Monitoring\ADCP_rawdata\Dati_',adcp,'\',num2str(listing1(m_in).name),'\',nome{file}),'r','n','ISO-8859-1');
        [RDAT,sz_RD] = fread(fid,inf,'char');sz_RD0=0;
        fclose(fid);
        q7=quantizer([7 0]);
        q8_1=quantizer([8 0]);
        q8=quantizer([9 0]);
        q16=quantizer([17 0]);
        q32=quantizer([33 0]);
        I=0;fixx=-1;
%         nome(file
        bpe=0;
        corruptedbyte=0;
        
        while I+bpe+2<sz_RD
            
            if sum(char([num2hex(q8,RDAT(I+1)) num2hex(q8,RDAT(I+2))])=='07f07f')~=6;I=I+1;%finding Header line
                corruptedbyte=corruptedbyte+1;
            else
                warning off
                LSB=num2bin(q8,RDAT(I+3));
                MSB=num2bin(q8,RDAT(I+4));
                bpe=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)])+2;%bytes x ensembel
                ndt=RDAT(I+6);%number of data type
                hed_dat=6+2*ndt;%lunghezza header data
                
                
                k=I+hed_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='000000')==6;else;disp('Fixed leader not found');I=I+1;continue;end;%test to skip corrupted data
                
                k=min([I+hed_dat+bpe sz_RD-2]);
                
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));                
                if sum(char([LSB MSB])=='000000')==6;k=I+hed_dat;else;disp('End file or incomplete ensemble');I=I+1;continue;end;%test to skip corrupted data

                fix_led=58;%lunghezza fix leader (cambia da strumento a strumento: 52;53;59)             
               
                if nens>1; if RDAT(k+10)~=WN;disp('Fixed leader corrupted_2');I=I+1;continue;end;end 
                WN=RDAT(k+10);%numero di celle
                
                var_led=60;%lunghezza var leader (cambia da strumento a strumento: 65)
                vel_dat=(2+8*WN);%lunghezza vel. data
                cor_dat=(2+4*WN);%lunghezza correlation data
                ech_dat=(2+4*WN);%lunghezza echo data
                pgd_dat=(2+4*WN);%lunghezza %good data
                stf_dat=(2+4*WN);%lunghezza status format data
                sur_dat=95;%lunghezza surface amplitude data
                suc_dat=28;%lunghezza surface command data
                sus_dat=46;%lunghezza surface status data
                end_dat=4;%reserved & check data
                nens=nens+1;%numero di ensembel
                ADCP(nens,:)=num2bin(q8,RDAT(k+5));
                if char(ADCP(nens,:))==char(kHz);else;disp('Fixed leader corrupted_1');I=I+1;continue;end;%test to skip corrupted data
              
                
                WP(nens)=RDAT(k+11);%ping x ensembel
                WS(nens)=RDAT(k+13);%cell length [cm]
                WF(nens)=RDAT(k+15);%blank [cm]
                TP(nens)=RDAT(k+25);%time ping [s/100]
                ex=char(num2bin(q8_1,RDAT(k+26)));EX(nens,:)=ex;%EX command
                ez=char(num2bin(q7,RDAT(k+31)));EZ(nens,:)=ez;%EZ command sensor source
                ez1=char(num2bin(q7,RDAT(k+32)));EZ1(nens,:)=ez1;%Sensor available
                LSB=num2bin(q8,RDAT(k+33));
                MSB=num2bin(q8,RDAT(k+34));
                B1ST(nens)=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]);%BIN 1 distance  [m/10]
                PROY(:,nens)=[1:WS(nens):WN*WS(nens)]/100+B1ST(nens)/100;%Distance in meters along instrument axis y

                
                k=I+hed_dat+fix_led;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='080000')==6;else;disp('Variable leader not found');I=I+1;continue;end;%test to skip corrupted data
                %tempo di ens. in secondi
                TIME(nens)=sum([0*RDAT(k+5) ...%anno
                    0*RDAT(k+6) ...%mese
                    3600*24*RDAT(k+7) ...%giorno
                    3600*RDAT(k+8) ...%ora
                    60*RDAT(k+9) ...%minuto
                    1*RDAT(k+10) ...%secondo
                    1/100*RDAT(k+11)]');%centesimo
                ore(nens)=RDAT(k+8);minuti(nens)=RDAT(k+9);%ora e minuti
                TIM_m(nens)=datenum([RDAT(k+5)+2000 RDAT(k+6:k+10)']);%data e orario al secondo in formato matlab
                %depth strumento [m/10]
                LSB=num2bin(q8,RDAT(k+17));
                MSB=num2bin(q8,RDAT(k+18));
                ED(nens)=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]);%depth strumento [m/10]
                %pitch [°]
                LSB=num2bin(q8,RDAT(k+21));
                MSB=num2bin(q8,RDAT(k+22));
                if RDAT(k+22)==255
                    EP(nens)=min([bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]).*.01 (RDAT(k+21)-256)*.01]);%pitch [°]
                elseif RDAT(k+22)>=1 & RDAT(k+22)<=2
                    EP(nens)=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]).*.01;
                elseif RDAT(k+22)==0
                    EP(nens)=0.01*RDAT(k+21);
                elseif RDAT(k+22)==254
                    EP(nens)=-0.01*(256+(256-RDAT(k+21)));
                elseif RDAT(k+22)==253
                    EP(nens)=-0.01*(2*256+(256-RDAT(k+21)));
                end
                %roll [°]
                LSB=num2bin(q8,RDAT(k+23));
                MSB=num2bin(q8,RDAT(k+24));
                if RDAT(k+24)==255
                    ER(nens)=min([bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]).*.01 (RDAT(k+23)-256)*.01]);%roll [°]
                elseif RDAT(k+24)>=1 & RDAT(k+24)<=2
                    ER(nens)=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]).*.01;
                elseif RDAT(k+24)==0
                    ER(nens)=0.01*RDAT(k+23);
                elseif RDAT(k+24)==254
                    ER(nens)=-0.01*(256+(256-RDAT(k+23)));
                elseif RDAT(k+24)==253
                    ER(nens)=-0.01*(2*256+(256-RDAT(k+23)));
                end
                ES(nens)=RDAT(k+25);%salinità ppt
                XmitV(nens)=RDAT(k+36);%Battery voltage [V]
                %temperatura acqua [C°]
                LSB=num2bin(q8,RDAT(k+27));
                MSB=num2bin(q8,RDAT(k+28));
                WT(nens)=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]).*.01;%temperatura acqua [C°]
                %speed of sound in m/s
                LSB=num2bin(q8,RDAT(k+15));
                MSB=num2bin(q8,RDAT(k+16));
                SS(nens)=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)]);%speed of sound in m/s
                %pressure transducer decaPascal
                LSB=num2bin(q8,RDAT(k+49));
                MSB=num2bin(q8,RDAT(k+50));
                LSB1=num2bin(q8,RDAT(k+51));
                MSB1=num2bin(q8,RDAT(k+52));
                PS(nens)=bin2num(q16,[MSB(:,2:9) LSB(:,2:9)])-bin2num(q16,[MSB1(:,2:9) LSB1(:,2:9)]);%pressure transducer decaPascal
                
                k=I+hed_dat+fix_led+var_led;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='000001')==6;else;disp('Velocity data not found');I=I+1;continue;end
                LSB=num2bin(q8,RDAT(k+3:2:k+vel_dat));
                MSB=num2bin(q8,RDAT(k+4:2:k+vel_dat));
                for i=1:WN %velocità [mm/s] riferite secondo il comando EX
                    V1(i,nens)=(bin2num(q16,[MSB(1+(i-1)*4,3:9) LSB(1+(i-1)*4,2:9)])-2^15*str2num(MSB(1+(i-1)*4,2)));
                    V2(i,nens)=(bin2num(q16,[MSB(2+(i-1)*4,3:9) LSB(2+(i-1)*4,2:9)])-2^15*str2num(MSB(2+(i-1)*4,2)));
                end
                
                k=I+hed_dat+fix_led+var_led+vel_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='000002')==6;else;disp('Correlation data not found');I=I+1;continue;end;%test to skip corrupted data
                COR1(:,nens)=RDAT(k+3:4:k+cor_dat);%correlazione trasduttori 1->2
                COR2(:,nens)=RDAT(k+4:4:k+cor_dat);
                
                k=I+hed_dat+fix_led+var_led+vel_dat+cor_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='000003')==6;else;disp('Echo data not found');I=I+1;continue;end;%test to skip corrupted data
                ECH1(:,nens)=RDAT(k+3:4:k+ech_dat); %eco trasduttori 1->2 [counts]
                ECH2(:,nens)=RDAT(k+4:4:k+ech_dat);
%                 if median(ECH1(:,nens))<50;ECH1(:,nens)=NaN;ECH2(:,nens)=NaN;V1(:,nens)=NaN;V2(:,nens)=NaN;end
                
                k=I+hed_dat+fix_led+var_led+vel_dat+cor_dat+ech_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='000004')==6;else;disp('Percent good data not found');I=I+1;continue;end;%test to skip corrupted data
                PGD1(:,nens)=RDAT(k+3:4:k+pgd_dat); %percent good trasduttori 1->2 [%]
                PGD2(:,nens)=RDAT(k+4:4:k+pgd_dat);
                
                k=I+hed_dat+fix_led+var_led+vel_dat+cor_dat+ech_dat+pgd_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='000005')==6;else;disp('Status data not found');I=I+1;continue;end;%test to skip corrupted data
                STD1(:,nens)=RDAT(k+3:4:k+stf_dat); %status profile trasduttori 1->2 [%]
                STD2(:,nens)=RDAT(k+4:4:k+stf_dat);
                
                
                k=I+hed_dat+fix_led+var_led+vel_dat+cor_dat+ech_dat+pgd_dat+stf_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='002040')==6;else;disp('Surface data not found');I=I+1;continue;end;%test to skip corrupted data
                VL(nens)=(255*RDAT(k+5)+RDAT(k+4)); %%%Water level mm
                
                
                k=I+hed_dat+fix_led+var_led+vel_dat+cor_dat+ech_dat+pgd_dat+stf_dat+sur_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='001040')==6;else;disp('Surface command not found');I=I+1;continue;end;%test to skip corrupted data
                
                k=I+hed_dat+fix_led+var_led+vel_dat+cor_dat+ech_dat+pgd_dat+stf_dat+sur_dat+suc_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='000040')==6;else;disp('Surface status not found');I=I+1;continue;end;%test to skip corrupted data
                
                k=I+hed_dat+fix_led+var_led+vel_dat+cor_dat+ech_dat+pgd_dat+stf_dat+sur_dat+suc_dat+sus_dat;
                LSB=num2hex(q8,RDAT(k+1));
                MSB=num2hex(q8,RDAT(k+2));
                if sum(char([LSB MSB])=='002000')==6;else;disp('Firmware version not found');I=I+1;continue;end;%test to skip corrupted data
                
                FILE(nens)=file;
                
                warning('on')
                
                I=I+bpe;
                if fix(I/(bpe*10))>fixx
                    fixx=fixx+1;
                    disp(['ens n.: ' num2str(nens) ', of: ' num2str((sz_RD+sz_RD0-corruptedbyte)/bpe+NENS) '; file n.: ' num2str(file) ', of: ' num2str(nfiles) ', Day: ' num2str(listing1(m_in).name)  ])
                end
            end
        end
        NENS=sz_RD/bpe+NENS;
                
        [II,J]=find(V1==32768);for i=1:length(II);V1(II(i),J(i))=NaN;end
        [II,J]=find(V2==32768);for i=1:length(II);V2(II(i),J(i))=NaN;end
        
        nnens=length(TIME);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        %%%NUOVA
        
        Res(1)={TIM_m};
        Res(2)={PROY};
        Res(3)={ECH1};
        Res(4)={ECH2};
        Res(5)={V1};
        Res(6)={V2};
        Res(7)={PGD1};
        Res(8)={PGD2};
        Res(9)={STD1}; %%%Parametri qualità: Status profile from 0 to 1 (1 bad)
        Res(10)={STD2}; %%%Parametri qualità: Status profile
        Res(11)={PS};  %%Pressure transducer output (daN/m2)
        Res(12)={ED};  %%Instrument level
        Res(13)={VL}; %%%Water level
        Res(14)={WT}; %%%Water temperature
        Res(15)={SS}; %%%Sound speed 
        Res(16)={EP}; %%Pitch
        Res(17)={ER}; %%Roll
        Res(18)={WS};
        Res(19)={WF};
        Res(20)={B1ST};
        Res(21)={ADCP};
        Res(22)={XmitV}; %%Battery voltage
        
%                 figure(1)
%                 subplot(211)
%                 plot(Res{2},Res{3})
%                 title('ECHO')
%                 subplot(212)
%                 plot(Res{2},Res{4})
        
        %             close all
        sz_RD0=sz_RD0+sz_RD;
    end
    save(strcat('C:\Users\massimo.guerrero\OneDrive - Alma Mater Studiorum Università di Bologna\Kokel_Monitoring\Risultati_',adcp,'\',num2str(listing1(m_in).name),'.mat'),'Res');
    
    end
    
end