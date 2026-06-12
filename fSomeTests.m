
% figure, plot(ECh1dB(:,1:5),'o-')
x=1:35;
Qr=ECh1dBa(:,1);
Qr(2)=Qr(1)

wp=diff(Qr);
da=find(wp<-2)
figure, plot(x,ECh1dBa(:,1),'ko-'), hold on, plot(x,Qr,'ks-')
        plot(x(da),Qr(da),'r*')


method=1;

switch method
    case method==1
        dmax=-0.5;
        wp=diff(ECh1dB);
        for i=1:size(wp,2)
            
            
        figure, plot(wp,'o-')
        
        [aa,bb]=find(wp<-2 & wp<-0.5);
    case method==2
        wp;
    otherwise
        disp('no method')
end
        