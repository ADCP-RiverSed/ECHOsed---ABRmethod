function RangeIndex=fBSAnalyser3(ECh1,r0index,method,Lmax)
% crops the backscatter profiles into useful regions for the backscatter
% analysis. Different methods are implemented. One is based on threshold
% values for the first derivative, the other is based on the derivative's
% signal change


DECh1=diff(ECh1(r0index:end,:));
[b, n] = size(DECh1);

if method==1
    B=zeros(1,n)+NaN; B1=B;
    
    %% original version
    for i=1:n
        k=find(DECh1(:,i)>=-.1);%lower limit for echo derivative starting from near to ADCP
        n4{i}=k;
        k1=find(DECh1(:,i)<-5);%upper limit for echo derivative starting from far field
        n5{i}=k1;
        if ~isempty(k) %==0;
            B(i)=max([1 min(k)-1]);
        end
        if ~isempty(k1) %==0;
            B1(i)=max(k1);
        end
    end
    BB=min([B;B1]);
elseif method==2
    
    %% uses the derivative to estimate the number of points. criterion: when
    % the 1st derivative changes its signf
%     close all
%     r0=r0index;
    for i=1:n  %i=300; %
        rt0=sign(DECh1(:,i));
        RangeIndex(i)=min(min(find(rt0>=0)),Lmax);
%         rt=diff(sign(DECh1(:,i)));
%         rt2=diff(sign(diff(DECh1(:,i))));
    end
    
%     for i=1:n  %i=300; %
%         rt0=sign(DECh1(:,i));
%         rt=diff(sign(DECh1(:,i)));
%         rt2=diff(sign(diff(DECh1(:,i))));
%         
%         if isempty((find(rt(r0:end))))
%             if isempty((find(rt(1:r0)))) && isempty(find(rt2))
%                 BB(i)=0;
%             else
%                 if isempty((find(rt(1:r0)))) && ~isempty(find(rt2))
%                     BB(i)=b;
%                 else
%                     BB(i)=min(find(rt(1:r0)));
%                 end
%             end
%         else
% %             if isempty((find(rt(1:r0)))) && ~isempty(find(rt2));
% %                 BB(i)=30;
% %                 disp('here')
% %             else
%                 BB(i)=min(find(rt(r0:end)));
% %             end
%             
%         end
% %        if i==300    
% %             figure(i), plot(ECh1(1:end,i),'ko-'), hold on, plot(r0x:BB(i),ECh1(r0x:BB(i),i),'r+-')
% %         end
%     end
end
% D2ECh1=diff(DECh1);

% for i=1:n
%     y=polyfit((1:3)',ECh1(1:3,i),1);
%     y2=polyfit((1:8)',D2ECh1(1:8,i),2);
%     mm(i)=y(1);
%     mm2(i)=y2(2);
% end
% s=find(abs(mm)>0 & abs(mm)<5);
% figure, plot(xrow,mm,'k-'), hold on, plot(xrow(s),DECh1(:,s),'ro')
% %%
% nbeg=3000;
% nend=3001;
% figure, hold on,
% 
%     subplot(3,1,1), plot(ECh1(1:15,nbeg:nend),'k-s'), hold on
%     subplot(3,1,2), plot(sign(DECh1(1:15,nbeg:nend)),'ko-'), hold on
%     subplot(3,1,3), plot(diff(sign(DECh1(1:15,nbeg:nend))),'r+-'), hold on
