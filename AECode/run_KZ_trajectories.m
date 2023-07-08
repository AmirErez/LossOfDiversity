% Calculates several KZ trajectories

t_ramp = 10000;

% params.log10c0 = -2;
% dirname='ramp_10K_c0_-2_new';
% loaded = load([dirname filesep 'params_KZ.mat']);
% tabfile = ['../AEData/collected/collected_m_' num2str(ms(mm)) '__c0_-2__alpha_0.75.csv'];
% Pc = 0.74926991433781; % c0=10^-2


dirname='../AEData/ramp_10K_c0_1_new';
loaded = load([dirname filesep 'params_KZ.mat']);
params.log10c0 = 1;
Pc = 0.706555624235447; %c0=10^1

ms=2.^[1:10];
filenames = cell(length(ms),1);
for mm=1:length(ms)
    filenames{mm} = ['ramp_' num2str(t_ramp) '__m_' num2str(ms(mm))];
end
%%
P_trajectory = make_P_trajectory([0.5; 0.5], [1; 0], t_ramp);
for mm=10:length(ms)
    disp('===============================================')
    disp(['Doing ramp m=' num2str(ms(mm))])
    params = loaded.params;
    params.m = ms(mm);
    params.b0 = 1/params.m*ones(params.m,1);
    params.alpha = make_uniform_alpha(params.alpha_val, params.m);
    params.P = P_trajectory(:,1);
    output = serialdil_odesolver_KZ(params, P_trajectory, 0);
    save([dirname filesep filenames{mm}], 'P_trajectory', 'output', 'params');
end
  
%%% Plot entropy
%width = 3.375;
%height = 2.5;
%newfigure(width,height)
%hold on

%fmap=colormap(copper(length(filenames)));
%for mm=1:length(filenames)
%    try   
%        disp(['Loading ' filenames{mm}])
%        loaded = load([dirname filesep filenames{mm}]);
%    catch
%        disp(['Failed ' filenames{mm}])
%        continue
%    end
%    S = calc_entropy_nats(loaded.output.rho);
%    d = Pc-loaded.P_trajectory(1,:);
%    dalpha = (2*loaded.params.alpha_val-1)/(loaded.params.m-1);
%    plot(d/dalpha, exp(S)-1, '-', 'Color', fmap(mm,:), 'LineWidth', 3)
%end
%xlabel('$d/\delta_{\alpha}$', 'Interpreter','Latex');
%ylabel('$m_e - 1$', 'Interpreter','Latex');
%xline(0,':k', 'LineWidth',2)
%set(gca,'FontSize', 18)
%% grid on
%% xlim([-40,100]);
%xlim([-40,40]);
%ylim([0, 100]);

%colormap(copper)
%c = colorbar();
%c.Position = [ 0.7572    0.3533    0.0291    0.1800];
%set(c,'Fontsize', 15);
%c.Ticks = [0 1];
%c.TickLabels = [ms(1) ms(end)];
%c.TickLabelInterpreter = 'latex';
%t=title(c,'$m$','Interpreter','latex');
%print(gcf,'-dpng', '../AEFigures/fig_KZ_linear.png', '-r600')
%print(gcf,'-dsvg', '../AEFigures/fig_KZ_linear.svg')

%%% Now log scale
%width = 3.375;
%height = 2.5;
%newfigure(width,height)
%hold on
%
%fmap=colormap(copper(length(filenames)));
%for mm=[2,5,8]
%    try   
%        disp(['Loading ' filenames{mm}])
%        loaded = load([dirname filesep filenames{mm}]);
%    catch
%        disp(['Failed ' filenames{mm}])
%        continue
%    end
%    S = calc_entropy_nats(loaded.output.rho);
%    d = Pc-loaded.P_trajectory(1,:);
%    dalpha = (2*loaded.params.alpha_val-1)/(loaded.params.m-1);
%    plot(d/dalpha, exp(S)-1, '-', 'Color', fmap(mm,:), 'LineWidth', 3)
%
%    tabfile = ['../AEData/collected/collected_m_' num2str(ms(mm)) '__c0_1__alpha_0.75.csv'];
%    tab = readtable(tabfile, 'Delimiter',',');
%    tab = sortrows(tab, 'P1','ascend');
%    tabd = Pc-tab.P1;
%    tempm=length(eval(tab.rho_initial{1}));
%    dalpha = (2*tab.alpha_val-1)/(tempm-1);
%    % plot(tabd./dalpha, exp(tab.ShannonS)-1,'--','Color', fmap(mm,:))
%    plot(tabd./dalpha, exp(abs(tab.ShannonS))-1,':','Color', fmap(mm,:), 'LineWidth',2.5)
%end
%xlabel('$d/\delta_{\alpha}$', 'Interpreter','Latex');
%ylabel('$m_e - 1$', 'Interpreter','Latex');
%set(gca,'XScale','log')
%set(gca,'YScale','log')
%set(gca,'FontSize', 18)
%% grid on
%xlim(10.^[-4,2]);
%xticks(10.^[-4,-2,0,2]);
%ylim(10.^[-2, 2.5]);
%yticks(10.^[-2,0,2]);

%colormap(copper)
%c = colorbar();
%c.Position = [ 0.7572    0.3533    0.0291    0.1800];
%set(c,'Fontsize', 15);
%c.Ticks = [0 1];
%c.TickLabels = [ms(1) ms(end)];
%c.TickLabelInterpreter = 'latex';
%t=title(c,'$m$','Interpreter','latex');
%print(gcf,'-dpng', '../AEFigures/fig_KZ_log.png', '-r600')
%print(gcf,'-dsvg', '../AEFigures/fig_KZ_log.svg')


