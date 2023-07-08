function [corr, errcorr, correction, ft, gof, A0, corrected_data] = extract_corr(data_,col,fig)
    % Extract correlation length via fit of ln(data - data(end)+correction) vs batch. With
    % correction for data(end) vs. data(steady state) - which is unknown.
    % col - for color of plot
    % fig - figure handle to plot in (or zero for no plot)
    data = data_;
    if(size(data,1)>size(data,2)), data=data'; end
    data = data - data(end);
    f = find( abs(data) < max(abs(data))/200); % Fit only last 0.5% where a single scale is "guaranteed"
    final_data = data(f);

    optfun= @(correction) (fitdecay_withshift(final_data, correction)');

    options = optimset('Display','final','MaxIter',1000, 'TolX', 1e-8, 'TolFun', 1e-8);
    [correction, ~] = fminsearch(optfun,eps,options);
    % options = optimoptions('fsolve');%,'Display','iter');
    % [correction, ~] = fsolve(optfun,eps,options);

    corrected_data = data + correction;
    corrected_final_data = corrected_data(f);

    % Fit in log scale, to get initial guess for nonlinear fit
    y = corrected_final_data;
    fn = find(y);
    x = 0:(length(y)-1);
    x = x(fn);
    y = corrected_final_data(fn);
    if(size(y,2) > size(y,1)), y=y'; end
    if(size(x,2) > size(x,1)), x=x'; end
    [ft, gof] = fit(x,log(y),'poly1');
    corr = -1/ft.p1;
    A0 = exp(ft.p2)*exp(f(1)/corr);
    ci = confint(ft);
    errcorr = (ci(2,1)-ci(1,1))/(ft.p1^2); % delta y = dy/dx delta x

   

%------------------------------------------------------

if fig ~= 0
    figure(fig);
    hold on
    semilogy(corrected_data,'-','Color',col, 'LineWidth',2);
    hold on
    semilogx(x+f(1),A0*exp(-(x+f(1))/corr),'--', 'LineWidth', 3);

end



