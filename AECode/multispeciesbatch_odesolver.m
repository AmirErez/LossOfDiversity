function [rho_sigma, Nr, c_i, t] = multispeciesbatch_odesolver(params,plt)

% Amir Erez 2022-02-08
% This function computes one batch of m microbes competing for p nutrients
% Monod growth

%PARAMETERS----------------------------------------------------------------

y0 = [params.P*10.^params.log10c0; params.b0*params.rho0];
tspan=[0,Inf];
% options = odeset('RelTol',1e-5,'Stats','on','OutputFcn',@odeplot);
%options = odeset('NonNegative',1,'RelTol',1e-7, 'AbsTol', 1e-7, ...
%    'Events', @(t,y)eventfun(t,y,params));%, ...
    %'Jacobian', @(t,y)jacobfun(t,y,params) );%,'Stats','on','OutputFcn',@odeplot);

%options = odeset('NonNegative',1,'RelTol',1e-11, ...
%    'Events', @(t,y)eventfun(t,y,params));%, ...

options = odeset('NonNegative',1,'RelTol',1e-11);

%[t,y] = ode89(@(t,y) odefun(t,y,params), tspan, y0, options);
%[t,y] = ode15s(@(t,y) odefun(t,y,params), tspan, y0, options);
[t,y] = ode15s(@(t,y) odefun(t,y,params), [0,20], y0, options);

c_i = y(:,1:params.p)';
rho_sigma = y(:,(params.p+1):end)';
Nr = trapz(t,transpose((c_i./(params.K+c_i)))); %Compute integral of growth

%PLOTTING(Activated with plt = 1)------------------------------------------

if plt == 1 
    figure
    mmap = jet(params.m);
    leg = cell(params.m, 1);
    for mm=1:params.m
        plot(t,rho_sigma(mm,:),'Color',mmap(mm,:), ...
            'DisplayName', mat2str(params.alpha(mm,:)))
        hold on
    end
    title('$\rho_{sigma}$ vs. Time', 'Interpreter','latex')
    xlabel('Time','Interpreter','latex')
    ylabel('$\rho_{sigma}$', 'Interpreter','latex')
    legend;

    %PLOT CONCENTRATIONS
    figure
    colors2 = lines(params.p);
    for pp=1:params.p
        plot(t,c_i(pp,:),'Color',colors2(pp,:),...
            'DisplayName', ['Nutrient ' num2str(pp)]')
        hold on
    end
    title('Nutrient concentration vs. Time','Interpreter','latex')
    xlabel('Time','Interpreter','latex')
    ylabel('$c_i$','Interpreter','latex')
    legend
end


end

