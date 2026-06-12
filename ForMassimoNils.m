close all; clear all; clc;
load('C0600_Unc.mat','TV','C','Ccm','Ccp','Cplus','Cminus');
TV06=TV; C06=C; Ccm06=Ccm; Ccp06=Ccp; Cplus06=Cplus; Cminus06=Cminus;

load('C1200_Unc.mat','TV','C','Ccm','Ccp','Cplus','Cminus');
TV12=TV; C12=C; Ccm12=Ccm; Ccp12=Ccp; Cplus12=Cplus; Cminus12=Cminus;

figure, semilogy(TV06(1:end),C06,'r-'), datetick('x','dd/mm/yy');
hold on
semilogy(TV06(1:end),Ccm06,'r--'), datetick('x','dd/mm/yy');
semilogy(TV06(1:end),Ccp06,'r--'), datetick('x','dd/mm/yy');

semilogy(TV12(1:end),C12,'b-'), datetick('x','dd/mm/yy');
hold on
semilogy(TV12(1:end),Ccm12,'b--'), datetick('x','dd/mm/yy');
semilogy(TV12(1:end),Ccp12,'b--'), datetick('x','dd/mm/yy');
xlabel('Time (ddmmyy)','fontsize',16), ylabel('C (g/L)','fontsize',16)
set(gca,'linewidth',2,'fontsize',16)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
print('-dpng','-r300','TS01.png')

%%

d1=datenum('01052016','ddmmyyyy');
d2=datenum('31052016','ddmmyyyy');
s06=find(TV06>=d1 & TV06<=d2);
s12=find(TV12>=d1 & TV12<=d2);

figure, subplot(2,1,1), semilogy(TV06(s06),C06(s06),'r-');
hold on
semilogy(TV06(s06),Ccm06(s06),'r--');
semilogy(TV06(s06),Ccp06(s06),'r--');
datetick('x','dd/mm/yy');
xlabel('Time (ddmmyy)','fontsize',16), ylabel('C (g/L)','fontsize',16)
title('C (g/L) @ 0.6 MHz','fontsize',16)
set(gca,'linewidth',2,'fontsize',16)
subplot(2,1,2), 
semilogy(TV12(s12),C12(s12),'b-')
hold on
semilogy(TV12(s12),Ccm12(s12),'b--')
semilogy(TV12(s12),Ccp12(s12),'b--')
% xlim([d1 d2]);
datetick('x','dd/mm/yy');
xlabel('Time (ddmmyy)','fontsize',16), ylabel('C (g/L)','fontsize',16)
title('C (g/L) @ 1.2 MHz','fontsize',16)
set(gca,'linewidth',2,'fontsize',16)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
print('-dpng','-r300','TS02.png')

%% histograms
[s600,b600]=hist(log(C06),50);
[s1200,b1200]=hist(log(C12),50);
figure, bar(b600,s600), hold on, bar(b1200,s1200)
axis([-4 3 0 2500 ])
xlabel('log(C)'), ylabel('N')
set(gca,'linewidth',2,'fontname','times','fontsize',16);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
legend('C 600','C 1200')
print('-dpng','-r300','hist01.png')

figure, subplot(2,1,1), bar(b600,s600), hold on, 
        set(gca,'linewidth',2,'fontname','times','fontsize',16);
        axis([-4 3 0 2500 ])
        xlabel('log(C)'), ylabel('N')
        title('C @ 0.6 MHz')
        subplot(2,1,2), bar(b1200,s1200)
        axis([-4 3 0 2500 ])
        title('C @ 1.2 MHz')
xlabel('log(C)'), ylabel('N')
set(gca,'linewidth',2,'fontname','times','fontsize',16);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
print('-dpng','-r300','hist02.png')

% semilogy(TV(1:end),C95plus,['k--']), datetick('x','dd/mm/yy');
% hold on
% semilogy(TV(1:end),C95minus,['k--']), datetick('x','dd/mm/yy');
% xlabel('Time (ddmmyy)'), ylabel('C (g/L)')
% semilogy(TV(1:end),Ccm,'b--'), datetick('x','dd/mm/yy');
% semilogy(TV(1:end),Ccp,'b--'), datetick('x','dd/mm/yy');
