function csound = fCsound(WT,display)
% this function calculates the speed of sound in water for the measured
% temperatures. Data was collected from http://nvlpubs.nist.gov/nistpubs/jres/59/jresv59n4p249_A1b.pdf
%pdf file is stored in folder Papers under the name Speed_of_Sound_water.pdf
%WT temprature in ºCelsius
%display=1 shows the plot

Tvec=0:1:50;
Cvec1=[2.74 7.71 12.57 17.32 21.96 26.50 30.92 35.24 39.46 43.58 47.59 51.51 55.34 59.07 62.70...
      66.25 69.70 73.07 76.35 79.55 82.66 85.69 88.63 91.50 94.29 97.00 99.64]+1400;
Cvec2=[2.20 4.68 7.10 9.44 11.71 13.91 16.05 18.12 20.12 22.06 23.93 25.74 27.49 29.18 30.80...
      32.37 33.88 35.33 36.72 38.06 39.34 40.57 41.74 42.87]+1500;
Cvec=[Cvec1 Cvec2];
Ccoef = polyfit(Tvec,Cvec,4);
csound=polyval(Ccoef,WT);

if display
    figure, plot(Tvec,Cvec,'k-'),hold on, plot(WT,csound,'r*')
    title('C sound (m/s) as function of temperature (ºC)')
    xlabel('Temperature (ºC)'),xlabel('Csound (m/s)')
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    legend('NIST values','Measured values','location','SouthEast')
end
