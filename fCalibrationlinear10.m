function [C1, C2, CC1, CCx, pcoef, xmin, xmax, yfit,S,r2,rmse,CLevel,Errors,epsilon]=fCalibrationlinear10(aabbrr, dd22, Ccalib, DataC, DataCDaily)
% [C1, C2, pcoef, xmin, xmax, yfit,S,r2,rmse,CLevel,Errors,epsilon]
%     

    %% determination of the calibration curve
    C1=cell2mat(DataC);
    C2=cell2mat(DataCDaily);
    
    xcal=C1(6,:); ycal=C1(5,:);
    xcal=xcal(~(isnan(xcal)));
    ycal=ycal(~(isnan(ycal)));
       
%     linearfit=polyfit(xcal',ycal',1);
     
    npoints=size(xcal,2);
    [fit01_11, Errors]=fit(log10(xcal)',log10(ycal)','poly1');
    if npoints>2
        ci = confint(fit01_11,0.95);
        p1_95=ci(:,1);
        p2_95=ci(:,2);
        CLevel={p1_95,p2_95};
    else
        p1_95=NaN;
        p2_95=NaN;
        CLevel={p1_95,p2_95};
    end
       
    pcoef=[fit01_11.p1 fit01_11.p2];
     linearfit=pcoef;
    xmin=floor(min(log10(xcal)))-1;
    xmax=ceil(max(log10(xcal)))+1;
    xtest=logspace(xmin,xmax);

    ytest=polyval(linearfit,log10(xtest));
    
    y_val=polyval(linearfit,log10(xcal));
%     y_val=y_valN./(xcal+fit06_21.q1);
    
    epsilon=sum(abs(10.^y_val-ycal))/size(y_val,2);  %mean realtive error
         
    load('ratio06.mat')
    figure('Name','Data vs Monogranular'),
    loglog(ratio,zetav,'k.','MarkerSize',6), hold on,
    scatter((ratio0(1:end-8)),(zeta0v(1:end-8)),100,(gg(1:end-8)*10^6),'o','filled');
    caxis([1 200]), colorbar;
    h = colorbar;
    loglog(C1(6,:),C1(5,:),'ks','MarkerSize',12,'MarkerFaceColor',[0 0 0]), hold on,
    loglog((xtest),10.^(ytest),'r-','linewidth',2)
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
    loglog((xtest),10.^(ytest),'r-','linewidth',2)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    set(gca,'linewidth',2,'fontsize',18)
    title('zeta vs Abr','fontsize',26)
    ylabel('\zeta_{s} (m^2/kg)','fontname','times','fontsize',28);
    xlabel('ABR','fontname','times','fontsize',28);
    
    %%    
%     zebra=exp(polyval(pcoef,log(aabbrr)))';
%     Cmeasured=dd22'./zebra;
    zebra=polyval(linearfit,log10(aabbrr));
    zeta=10.^zebra;
%     (polyval(pcoefN,log(aabbrr)))'
    Cmeasured=dd22./zeta;
    
    naux1=(isfinite(Cmeasured));
    CC1=Cmeasured(naux1); %measured without nan
    CCx=Ccalib(naux1); %values from calibration
    naux2=find(CC1);
    CC2=CC1(naux2);
    Cy=CCx(naux2);
%     figure, loglog(CCx,CC1)
    [yfit,S]=polyfit(log10(CCx),log10(CC1),1);
    
    
%     [fitlin, Errors]=fit(log10(CCx),log10(CC1),'linear');
%     ci = confint(fitlin,0.95);
    p1_95=[NaN NaN];
    p2_95=[NaN NaN];
    p3_95=[NaN NaN];
    q1_95=[NaN NaN];
    CLevel={p1_95,p2_95,p3_95,q1_95};
     
    [r2, rmse]=frsquare(log10(CCx),log10(CC1));
    
    %%
    Cmin=min(CCx)-0.20*min(CCx);
    Cmax=max(CCx)+0.20*max(CCx);
    n=20;
    Ctest=Cmin:((Cmax-Cmin)/(n-1)):Cmax;
    Cplot=polyval(yfit,log10(Ctest));   %
    fitsignal='+';
    if yfit(2)<0
        fitsignal='-';
    end
        
    StringTitle=['y =' num2str(yfit(1))   '*x' '' fitsignal '' num2str(abs(yfit(2))) '  R^2 = ' num2str(r2)];
    figure, loglog(CCx,CC1,'k*'), hold on, loglog(Ctest,10.^Cplot,'r-'), loglog(Ctest,Ctest,'b--')
    legend('Data','Fit','y = x','location','NorthWest')
%     figure, loglog(Ccalib,Cmeasured,'k*','MarkerSize',10), hold on, plot(xx11,xx11,'k-','linewidth',2), ...
%         plot(xx11,10.^polyval(yfit,log10(xx11)),'linewidth',2)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    set(gca,'linewidth',2,'fontsize',18)
    xlabel('C from samples'); ylabel('C calculated')
    legend('Data','linear fit','y=x','location','NorthWest')
    title(StringTitle)