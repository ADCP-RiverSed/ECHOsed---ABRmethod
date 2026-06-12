function [C1, C2, CC1, CCx, pcoef, xmin, xmax, yfit,S,r2,rmse,CLevel,Errors,epsilon]=fCalibrationRationalPolynomial(aabbrr, dd22, Ccalib, DataC, DataCDaily)
%     

    %% determination of the calibration curve
    C1=cell2mat(DataC);
    C2=cell2mat(DataCDaily);
    
    xcal=C1(6,:); ycal=C1(5,:);
    xcal=xcal(~(isnan(xcal)));
    ycal=ycal(~(isnan(ycal)));
    npoints=size(xcal,2);
    %Fitting with Rational models are polynomials over polynomials with the leading coefficient of the denominator set to 1
%Y = (p1*x^2+p2*x+p3)/(x+q1)
% order of magnitude                                  p1 p2 p3  q1
%     fit06_21=fit(cc061(:,2),cc061(:,1),'rat21','Startpoint',[10^-5 -.01 400 200]);
    
%     fit06_21=fit(xcal',ycal','rat21','Startpoint',[10^-5 -.01 400 200]);
    [fit06_21, Errors]=fit(xcal',ycal','rat21','Startpoint',[10^-5 -.01 400 200]);
    ci = confint(fit06_21,0.95);
    p1_95=ci(:,1);
    p2_95=ci(:,2);
    p3_95=ci(:,3);
    q1_95=ci(:,4);
    CLevel={p1_95,p2_95,p3_95,q1_95};
  

%     A1=fit06_21.p1*(xcal).*(xcal)+fit06_21.p2*(xcal)+fit06_21.p3;
%     B1=((xcal)+fit06_21.q1);
%     Cfit=A1./B1;
    
    
    pcoefN=[fit06_21.p1 fit06_21.p2 fit06_21.p3];
    pcoef=[fit06_21.p1 fit06_21.p2 fit06_21.p3 fit06_21.q1];
%     pcoefN95m=[p1_95(1) p2_95(1) p3_95(1)];
%     pcoefN95p=[p1_95(2) p2_95(2) p3_95(2)];
    xmin=min(xcal);
    xmax=max(xcal);
    xtest=logspace(0.01,npoints);
    amin=find(xtest<=xmin); xtest(amin)=xmin;
    amax=find(xtest>=xmax); xtest(amax)=xmax;
    
    ytestN=polyval(pcoefN,(xtest));
    ytest=ytestN./(xtest+fit06_21.q1);
    
    y_valN=polyval(pcoefN,(xcal));
    y_val=y_valN./(xcal+fit06_21.q1);
    
    epsilon=sum(abs(y_val-ycal))/size(y_val,2);  %mean realtive error
%     abs(y_val-ycal)/ycal
%     ytestN95p=polyval(pcoefN95p,(xtest));
%     ytest95p=ytestN95p./(xtest+q1_95(2));
%     
%     ytestN95m=polyval(pcoefN95m,(xtest));
%     ytest95m=ytestN95m./(xtest+q1_95(1));
    
    load('ratio06.mat')
    figure('Name','Data vs Monogranular'),
    loglog((xtest),(ytest),'k-','linewidth',2), hold on;
    %loglog(ratio,zetav,'k.','MarkerSize',6), hold on,
    scatter((ratio0(1:end-8)),(zeta0v(1:end-8)),100,(gg(1:end-8)*10^6),'o','filled');
    loglog((xtest),(ytest),'k-','linewidth',2)
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
    loglog((xtest),(ytest),'k-','linewidth',2)
    loglog((xtest),(ytest*10^(2*epsilon)),'k--','linewidth',2)
    loglog((xtest),(ytest/10^(2*epsilon)),'k--','linewidth',2)
%   loglog((xtest),(ytest95p),'r--','linewidth',2)
%     loglog((xtest),(ytest95m),'m--','linewidth',2)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    set(gca,'linewidth',2,'fontsize',18)
%    title(['zeta vs Abr. r^2 = ' num2str(r2)] ,'fontsize',26)
    ylabel('\zeta_{s} (m^2/kg)','fontname','times','fontsize',28);
    xlabel('ABR','fontname','times','fontsize',28);
    
    %     hm=msgbox('Calibration curve determined')
    
%     zebra=exp(polyval(pcoef,log(aabbrr)))';
%     Cmeasured=dd22'./zebra;
    zebraN=polyval(pcoefN,(aabbrr));
    zeta=zebraN./(aabbrr+fit06_21.q1);
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
%     [Lmin,Lmax]=fminmaxC((Cmeasured),(Ccalib));
%     i1=floor(log10(Lmin));
%     i2=ceil(log10(Lmax));
%     xx11=logspace(i1,i2);
%     yval=polyval(yfit,Cy);
    [r2, rmse]=frsquare(log10(CCx),log10(CC1));
    
%     %%
%     StringTitle=['y =' num2str(yfit(1))   '*x' ' + ' num2str(yfit(2)) '  R^2 = ' num2str(r2)];
%     figure, loglog(CCx,CC1,'k*'), hold on, loglog(CCx,CCx,'r-')
% %     figure, loglog(Ccalib,Cmeasured,'k*','MarkerSize',10), hold on, plot(xx11,xx11,'k-','linewidth',2), ...
% %         plot(xx11,10.^polyval(yfit,log10(xx11)),'linewidth',2)
%     set(gcf,'units','normalized','outerposition',[0 0 1 1])
%     set(gca,'linewidth',2,'fontsize',18)
%     xlabel('C from samples')
% %     legend('Data','y=x','linear fit','location','NorthWest')
%     title(StringTitle)
    
    Cmin=min(CCx)-0.20*min(CCx);
    Cmax=max(CCx)+0.20*max(CCx);
    n=20;
    Ctest=Cmin:((Cmax-Cmin)/(n-1)):Cmax;
    Cplot=polyval([yfit(1),yfit(2)],Ctest);
    fitsignal='+';
    if yfit(2)<0
        fitsignal='-';
    end
        
    StringTitle=['y =' num2str(yfit(1))   '*x' '' fitsignal '' num2str(abs(yfit(2))) '  R^2 = ' num2str(r2)];
    figure, loglog(CCx,CC1,'k*'), hold on, loglog(Ctest,Cplot,'r-'), loglog(Ctest,Ctest,'b--')
    legend('Data','Fit','y = x','location','NorthWest')
%     figure, loglog(Ccalib,Cmeasured,'k*','MarkerSize',10), hold on, plot(xx11,xx11,'k-','linewidth',2), ...
%         plot(xx11,10.^polyval(yfit,log10(xx11)),'linewidth',2)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    set(gca,'linewidth',2,'fontsize',18)
    xlabel('C from samples'); ylabel('C calculated')
    legend('Data','y=x','linear fit','location','NorthWest')
    title(StringTitle)