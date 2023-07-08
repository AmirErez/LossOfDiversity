function err=fitdecay_withshift(data_,shift)
    data = data_((data_+shift)>0);
    if(size(data,2)>size(data,1)), data=data'; end
    xx=(1:length(data))';
    yy=log(data+shift);
    xx=xx(~isinf(yy));
    yy=yy(~isinf(yy));
    [ft, gof] = fit(xx,yy,'poly1');
    err=gof.rmse;
%     ci = confint(ft);
%     err = abs(ci(2,1)-ci(1,1))/(ft.p1^2); % Minimize confidence interval for xi
end

