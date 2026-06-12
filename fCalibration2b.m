function [C1, C2, pcoef, xmin, xmax, yfit,S,r2,rmse]=fCalibration2b(aabbrr, dd22, Ccalib, DataC, DataCDaily)
%     

    %% determination of the calibration curve
    C1=cell2mat(DataC);
    C2=cell2mat(DataCDaily);
    
    xcal=C1(6,:); ycal=C1(5,:);
    xcal=xcal(~(isnan(xcal)));
    ycal=ycal(~(isnan(ycal)));
    
    pcoef=polyfit(log(xcal),log(ycal),1);
    xmin=min(xcal);
    xmax=max(xcal);
    xtest=logspace(1,8);
    amin=find(xtest<=xmin); xtest(amin)=xmin;
    amax=find(xtest>=xmax); xtest(amax)=xmax;
    ytest=polyval(pcoef,log(xtest));
    
    %     header={'Month' 'Day' 'hour' 'minute' 'zeta' 'Abr' 'Attenuation' 'Backscatter'};
    %     xlswrite('CalibrationOutput.xlsx',header,'Hour','A1');
    %     xlswrite('CalibrationOutput.xlsx',C1','Hour','A2');
    %     xlswrite('CalibrationOutput.xlsx',header,'Daily','A1');
    %     xlswrite('CalibrationOutput.xlsx',C2','Daily','A2');
    
    load('ratio06.mat')
    figure('Name','Data vs Monogranular'),
    loglog(ratio,zetav,'k.','MarkerSize',6), hold on,
    scatter((ratio0(1:end-8)),(zeta0v(1:end-8)),100,(gg(1:end-8)*10^6),'o','filled');
    caxis([1 200]), colorbar;
    h = colorbar;
    loglog(C1(6,:),C1(5,:),'ks','MarkerSize',12,'MarkerFaceColor',[0 0 0]), hold on,
    title(h, 'd ($$\mu$$m)','interpreter','latex','fontsize',30)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    set(gca,'linewidth',2,'fontsize',18)
    ylabel('\zeta_{s} (m^2/kg)','fontname','times','fontsize',28);
    xlabel('ABR','fontname','times','fontsize',28);
    
    % % % 
    figure('Name','Calibration')
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    %loglog(ratio,zetav,'k.','MarkerSize',6), hold on,
    %scatter((ratio0(1:end-8)),(zeta0v(1:end-8)),100,(gg(1:end-8)*10^6),'o','filled');
    %caxis([1 200]), colorbar;
    %h = colorbar;
    %title(h, 'd ($$\mu$$m)','interpreter','latex','fontsize',30)
       
    %figure,
    loglog(C1(6,:),C1(5,:),'ks','MarkerSize',12,'MarkerFaceColor',[0 0 0]), hold on,
    loglog((xtest),exp(ytest),'r-','linewidth',2)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    set(gca,'linewidth',2,'fontsize',18)
    title('zeta vs Abr','fontsize',26)
    ylabel('\zeta_{s} (m^2/kg)','fontname','times','fontsize',28);
    xlabel('ABR','fontname','times','fontsize',28);
    
    %     hm=msgbox('Calibration curve determined')
    
    zebra=exp(polyval(pcoef,log(aabbrr)))';
    Cmeasured=dd22'./zebra;
    
    naux1=(isfinite(Cmeasured));
    CC1=Cmeasured(naux1);
    CCx=Ccalib(naux1);
    naux2=find(CC1);
    CC2=CC1(naux2);
    Cy=CCx(naux2);
    [yfit,S]=polyfit(log10(CC2),log10(Cy'),1);
    [Lmin,Lmax]=fminmaxC((Cmeasured),(Ccalib));
    i1=floor(log10(Lmin));
    i2=ceil(log10(Lmax));
    xx11=logspace(i1,i2);
    yval=polyval(yfit,Cy);
    [r2, rmse]=frsquare(log10(Cy),log10(yval));
    
    %%
    StringTitle=['y =' num2str(yfit(1))   '*x' ' + ' num2str(yfit(2)) '  R^2 = ' num2str(r2)];
    figure, loglog(Ccalib,Cmeasured,'k*','MarkerSize',10), hold on, plot(xx11,xx11,'k-','linewidth',2), ...
        plot(xx11,10.^polyval(yfit,log10(xx11)),'linewidth',2)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    set(gca,'linewidth',2,'fontsize',18)
    legend('Data','y=x','linear fit','location','NorthWest')
    title(StringTitle)