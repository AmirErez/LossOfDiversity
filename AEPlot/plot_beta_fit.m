%% Plot the beta fit and collapse
% COMMENT - First run the python file species_steady_state.py which does
% the fits and calculates beta and the RMSE. It saves the table file below.

c0str = '__log10c0_1';
tab = readtable('../AEData/collected/collected_log10c0_1_withbeta.csv');
ms = unique(tab.m);
Is = [50,100, 150,180,220];
alpha=0.75;
Pc = 0.706555624235447;  % log10c0=1, alpha=0.75
figure();
mmap = colormap(copper(length(ms)));
close()
rho_sigma = @(sigma, beta,m) (exp(beta)-1)/(1-exp(-beta*m))*exp(-beta*sigma);

%% Plot fit results example
xsize=3.375;
ysize=2.5;
fig = newfigure(xsize,ysize);
fig.Name=['fig_fit_beta' c0str];
hold on
m=8;
for ii=1:length(Is)
    tabm = tab(tab.m==m,:);
    rho_ss = tabm.rho_ss{Is(ii)};
    beta = tabm.Betas(Is(ii));
    rho_ss = eval(replace(rho_ss,char(10),' '));
    sigmas = 1:length(rho_ss);
    plot(sigmas, rho_ss, 'ok', 'MarkerSize',6,'MarkerFaceColor','k')
    plot(sigmas, rho_sigma(sigmas,beta,m),'-b', 'LineWidth',2)
end
set(gca,'yscale','log')
xl = xlabel('Species, $\sigma$', 'Interpreter','Latex');
yl = ylabel('Abundance, $\rho_\sigma$', 'Interpreter','Latex');
xticks(1:m);
xlim([1,m]);
ylim(10.^[-8,0]);
yticks(10.^[-8,-4,0]);
set(gca,'FontSize',18)
print(gcf,'-dpng', '../AEFigures/fig_fit_beta.png', '-r600')
print(gcf,'-dsvg', '../AEFigures/fig_git_beta.svg')

%% Plot all RMSE
fig = newfigure(xsize,ysize);
fig.Name=['fig_fit_beta' c0str];
hold on
for mm=1:length(ms)
    m = ms(mm);
    tabm = tab(tab.m==m,:);
    tabm.d = Pc-tabm.P1;
    plot(tabm.d, tabm.RMSE, 'o', 'Color',mmap(mm,:),'MarkerSize',2,'MarkerFaceColor',mmap(mm,:))
end
set(gca,'yscale','log')
xl = xlabel('Distance, $d$', 'Interpreter','Latex');
yl = ylabel('RMSE', 'Interpreter','Latex');
set(gca, 'FontSize',18)
ylim(10.^[-10,-6])
yticks(10.^[-10,-8,-6])
xlim([0,0.2])
xticks(0:0.1:0.2)
colormap(copper)
c = colorbar();
c.Position = [ 0.8107    0.7811    0.0332    0.1800];
set(c,'Fontsize', 15);
c.Ticks = [0 1];
c.TickLabels = [ms(1) ms(end)];
c.TickLabelInterpreter = 'latex';
t=title(c,'$m$','Interpreter','latex');
t.Position = [-8.9695   18.6500         0];
print(gcf,'-dpng', '../AEFigures/fig_fit_beta_RMSE.png', '-r600')
print(gcf,'-dsvg', '../AEFigures/fig_fit_beta_RMSE.svg')

%% Plot beta vs. delta_alpha
fig = newfigure(xsize,ysize);
fig.Name=['fig_collapse_beta' c0str];
hold on
for mm=1:length(ms)
    m = ms(mm);
    tabm = tab(tab.m==m,:);
    tabm.d = Pc-tabm.P1;
    delta_alpha = (2*alpha-1)/(m-1);
    plot(tabm.d/delta_alpha, tabm.Betas, 'o', 'Color',mmap(mm,:),'MarkerSize',4,'MarkerFaceColor',mmap(mm,:))
end
set(gca,'xscale','log')
xl = xlabel('$d/\delta_\alpha$', 'Interpreter','Latex');
yl = ylabel('$\beta$', 'Interpreter','Latex');
set(gca, 'FontSize',18)
ylim([0,10])
yticks(0:2:10)
xlim(10.^[-4,0])
xticks(10.^[-4,-2,0])
colormap(copper)
c = colorbar();
c.Position = [ 0.8107    0.7811    0.0332    0.1800];
set(c,'Fontsize', 15);
c.Ticks = [0 1];
c.TickLabels = [ms(1) ms(end)];
c.TickLabelInterpreter = 'latex';
t=title(c,'$m$','Interpreter','latex');
t.Position = [-8.9695   18.6500         0];
print(gcf,'-dpng', '../AEFigures/fig_collapse_beta.png', '-r600')
print(gcf,'-dsvg', '../AEFigures/fig_collapse_beta.svg')