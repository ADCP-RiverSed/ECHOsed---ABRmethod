function [alfw, AW]=falfaw(WT,WLH,fr)
% INSTRUMENTAL AND OTHER PARAMETERS
% fr=600*10^3;                      % frequency of the instrument [Hz]
% WLH=2;                              % water depth [m]
ni=interp1([0:5:30],[1.9 1.5 1.3 1.2 1.0 0.9 0.8],WT)*10^-6;        % water viscosity
SS=1449.2+4.6*WT-0.055*WT.^2+0.00029*WT.^3-35*(1.34-0.01*WT)+0.016*(WLH);  % speed of sound [m/s](Medwin and Clay)

% sound attenuation in clear water in Neper/m (Medwin and Clay)
p=WLH./9.81;                    % [atm]
uu=interp1([0:5:30],[1.9 1.5 1.3 1.2 1.0 0.9 0.8],WT);
uu=fnaninterp(uu);
uu1=interp1([0:5:30],[5.6 4.4 3.7 3.2 2.9 2.5 2.3],WT);
uu1=fnaninterp(uu1);
u=uu.*10^-3.*(1-1.2.*10^-4.*p);
u1=uu1.*10^-3.*(1-1.2.*10^-4.*p);
alfw=fnaninterp((2*pi*fr).^2.*(4.*u./3+u1)./(2*1000*SS.^3));       % [Neper/m]
AW=2*20*log10(exp(1))*alfw;                            % [dB/m]