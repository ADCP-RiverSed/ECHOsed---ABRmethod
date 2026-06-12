function [aa, bb, SSE, R2, RMSE]=ffitechomodel(Proy,ECh1dB)

%,aaplus,aaminus,bbplus,bbminus
%this function implements the fit 'a*x - 20*log(x)+b' to the intensity
%profile data
%SSE, R2, RMSE= sum of squares due to error; R2 correlation coefficient;
%root mean squared error

n0=size(ECh1dB,2);
aa=zeros(n0,1); bb=aa;
n1=1; 
for j=1:n0
    n2=length(find(~isnan(ECh1dB(:,j))));
    if n2>1
        [g, gdata] = fit( Proy(n1:n2,j), ECh1dB(n1:n2,j), 'a*x - 20*log10(x)+b', 'StartPoint', [Proy(n1,j),ECh1dB(n1,j)] );
        aa(j)=g.a;
        bb(j)=g.b;
        SSE(j)=gdata.sse;
        R2(j)=gdata.rsquare;
        RMSE(j)=gdata.rmse;
        if size(ECh1dB(n1:n2,j),1)>=3
            ci = confint(g,0.95);
            aaplus=ci(1,1);
            aaminus=ci(2,1);
            bbplus=ci(1,2);
            bbminus=ci(2,2);
        end
%         R21(j)=.1;
%         RMSE1(j)=.1;
%         if size(ECh1dB(n1:n2,j),1)>=3
%             [g1, gdata1] = fit( Proy(n1+1:n2,j), ECh1dB(n1+1:n2,j), 'a*x - 20*log10(x)+b', 'StartPoint', [Proy(n1,j),ECh1dB(n1,j)] )
%             R21(j)=gdata1.rsquare;
%             RMSE1(j)=gdata1.rmse;
%         end
    else
        aa(j)=NaN;
        bb(j)=NaN;
        SSE(j)=NaN;
        R2(j)=NaN;
        RMSE(j)=NaN;
        R21(j)=NaN;
        RMSE1(j)=NaN;

    end

end

% disp('here')
