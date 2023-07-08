function output = serialdil_odesolver(params, plt)

% Amir Erez 2022-02-08.
% This function simulates serial dilutions
% Simulation ends dependent on extinction tolerance and RAE tolerance

output = struct;
output.rho = zeros(params.m, params.max_batches);
output.NutIntegrals = zeros(params.p, params.max_batches);
tol = 1e-8;  % Lowered to 1e-8 from 1-9 because some runs got stuck 2022-04-27
er=Inf;

params.rho_initial = params.b0;

for cnt=1:params.max_batches
    if(mod(cnt,1000)==0)
       disp(['   Done ' num2str(cnt) '  ;  err ' num2str(max(er))]);
    end
    %Simulate batch
    [rho_sigma, Nr] = multispeciesbatch_odesolver(params,0);
    params.b0=rho_sigma(:,end)/sum(rho_sigma(:,end));
    output.rho(:,cnt) = params.b0*params.rho0;
    output.NutIntegrals(:, cnt) = Nr';

    %Compute relative error between batches of populations or diversity
    if(cnt>1)
        if params.errtype == 1
            er = abs((output.rho(:,cnt) - output.rho(:,cnt-1)))/sum(output.rho(:,cnt));
        else
            Dcurr = -sum(output.rho(:,cnt).*log(output.rho(:,cnt)));
            Dprev = -sum(output.rho(:,cnt-1).*log(output.rho(:,cnt-1)));
            er = abs((Dcurr - Dprev)/Dcurr);
        end

        if max(er) < tol %Exit loop of error below threshold
            break;
             disp(['The model has been ended due to an error of '...
                    num2str(transpose(er))])
             disp('The populations are')
             disp(output.rho(:,i+1))
        end
    end
end

if(cnt==params.max_batches)
    error('Reached max batches. Increase params.max_batches to attain steady state.')
end

%PROCESS DATA--------------------------------------------------------------

output.rho = output.rho(:,1:cnt);
output.NutIntegrals = output.NutIntegrals(:, 1:cnt);
output.ShannonS = calc_entropy_nats(output.rho);

%PLOTTING------------------------------------------------------------------

if plt == 1

    %PLOT END BIOMASS RATIO DYNAMICS
    colors = jet(params.m);
    figure
    set(gcf, 'Position', [500 250 750 600]);
    for h=1:params.m  %Plot end-batch biomass ratios vs. transfer number
        hold on
        if params.p ==3
        semilogy(output.rho(h,:), 'LineWidth',1.5,'color',params.alpha(h,:))
        else
        semilogy(output.rho(h,:), 'LineWidth',1.5,'color',colors(h,:))
        end
    end
    title(['Competition between ' num2str(params.m) ' species for ' num2str(params.p) ...
        ' nutrients at ' num2str(params.P(1)) '/' num2str(params.P(2))])
    xlabel('Transfer number')
    ylabel('Population fraction at batch start')
    leg = [];
    for h = 1:params.m %Generate legend from strategies
        legi = [];
        for k = 1:params.p
            if k < params.p
                legi = [legi num2str(params.alpha(h,k),'%5.2f') '/'];
            else
                legi = [legi num2str(params.alpha(h,k),'%5.2f')];
            end
        end
        leg = [leg; legi];
    end
    legend(leg)
    % if min(endb) < extol
    % ylim([extol, 1.5]);
    % end
    set(gca,'YScale', 'log')

    %SIMPLEX PLOTS IF P = 3
    if params.p == 3 %Plots this only when there are three nutrients
        figure %Plot strategies and nutrient supply on the simplex
        set(gcf, 'Position', [500 500 750 600]);
        for i = 1:params.m
        ternplot(s(i,1),s(i,2),s(i,3),'o','MarkerEdgeColor',s(i,:),'majors',...
            0,'MarkerFaceColor',s(i,:),'majors',0)
        hold on
        end
        ternplot(P(1),P(2),P(3),'kd','majors',0,'LineWidth',2)
    end

    %NR PLOTS
    figure
    if params.p == 2
        plot((output.NutIntegrals(:,1)-output.NutIntegrals(:,2))./(output.NutIntegrals(:,1)+output.NutIntegrals(:,2)))
        title('(N1-N2)/(N1+N2) vs. Transfer Number')
        xlabel('Transfer Number')
        ylabel('(N1-N2)/(N1+N2)')
    elseif params.p ==3
        plot((abs(output.NutIntegrals(:,1)-output.NutIntegrals(:,2)) + abs(output.NutIntegrals(:,1)-...
            output.NutIntegrals(:,3))+abs(output.NutIntegrals(:,2)-output.NutIntegrals(:,3)))./(output.NutIntegrals(:,1)+output.NutIntegrals(:,2)+output.NutIntegrals(:,3)))
        title('Absolute differences/sums vs. Transfer Number')
        xlabel('Transfer Number')
        ylabel('Absolute differences/sums')
    end

end

end
