%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Select data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

option=1;

if option==1
    files = {'../AEData/collected/collected_m_2__c0_1__alpha_0.75.csv',...
             '../AEData/collected/collected_m_4__c0_1__alpha_0.75.csv',...
             '../AEData/collected/collected_m_8__c0_1__alpha_0.75.csv',...
             '../AEData/collected/collected_m_16__c0_1__alpha_0.75.csv',...
             '../AEData/collected/collected_m_32__c0_1__alpha_0.75.csv',...
             '../AEData/collected/collected_m_64__c0_1__alpha_0.75.csv',...
             '../AEData/collected/collected_m_128__c0_1__alpha_0.75.csv',...
             '../AEData/collected/collected_m_256__c0_1__alpha_0.75.csv',...
             '../AEData/collected/collected_m_512__c0_1__alpha_0.75.csv',...
             '../AEData/collected/collected_m_1024__c0_1__alpha_0.75.csv',...
    };
    c0str = '__log10c0_1';
elseif option==2
    files = {'../AEData/collected/collected_m_2__c0_3__alpha_0.75__grid_full.csv',...
             '../AEData/collected/collected_m_4__c0_3__alpha_0.75__grid_full.csv',...
             '../AEData/collected/collected_m_8__c0_3__alpha_0.75__grid_full.csv',...
             '../AEData/collected/collected_m_16__c0_3__alpha_0.75__grid_full.csv',...
             '../AEData/collected/collected_m_32__c0_3__alpha_0.75__grid_full.csv',...
             '../AEData/collected/collected_m_64__c0_3__alpha_0.75__grid_full.csv',...
             '../AEData/collected/collected_m_128__c0_3__alpha_0.75__grid_full.csv',...
             '../AEData/collected/collected_m_256__c0_3__alpha_0.75__grid_full.csv',...
             '../AEData/collected/collected_m_512__c0_3__alpha_0.75__grid_full.csv',...
             '../AEData/collected/collected_m_1024__c0_3__alpha_0.75__grid_full.csv',...
    };
    c0str = '__log10c0_3';
end
% files = {'../AEData/collected/collected_m_2__c0_-2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_4__c0_-2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_8__c0_-2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_16__c0_-2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_32__c0_-2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_64__c0_-2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_128__c0_-2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_256__c0_-2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_512__c0_-2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_1024__c0_-2__alpha_0.75__grid_full.csv',...
% };

% files = {'../AEData/collected/collected_m_2__c0_-2__alpha_0.75.csv',...
%          '../AEData/collected/collected_m_4__c0_-2__alpha_0.75.csv',...
%          '../AEData/collected/collected_m_8__c0_-2__alpha_0.75.csv',...
%          '../AEData/collected/collected_m_16__c0_-2__alpha_0.75.csv',...
%          '../AEData/collected/collected_m_32__c0_-2__alpha_0.75.csv',...
%          '../AEData/collected/collected_m_64__c0_-2__alpha_0.75.csv',...
%          '../AEData/collected/collected_m_128__c0_-2__alpha_0.75.csv',...
%          '../AEData/collected/collected_m_256__c0_-2__alpha_0.75.csv',...
%          '../AEData/collected/collected_m_512__c0_-2__alpha_0.75.csv',...
%          '../AEData/collected/collected_m_1024__c0_-2__alpha_0.75.csv',...
% };



% files = { ...
%     ... % '../AEData/collected/collected_m_2__c0_2.5__alpha_0.9__grid_full.csv', ...
%     '../AEData/collected/collected_m_3__c0_2.5__alpha_0.9__grid_full.csv', ...
%     '../AEData/collected/collected_m_5__c0_2.5__alpha_0.9__grid_full.csv', ...
%     '../AEData/collected/collected_m_9__c0_2.5__alpha_0.9__grid_full.csv', ...
%     '../AEData/collected/collected_m_17__c0_2.5__alpha_0.9__grid_full.csv', ...
%     '../AEData/collected/collected_m_33__c0_2.5__alpha_0.9__grid_full.csv', ...
%     '../AEData/collected/collected_m_65__c0_2.5__alpha_0.9__grid_full.csv', ...
%     '../AEData/collected/collected_m_129__c0_2.5__alpha_0.9__grid_full.csv' ...
% };

% Short ones upto 128:
% files = {'../AEData/collected/collected_m_2__c0_2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_4__c0_2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_8__c0_2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_16__c0_2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_32__c0_2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_64__c0_2__alpha_0.75__grid_full.csv',...
%          '../AEData/collected/collected_m_128__c0_2__alpha_0.75__grid_full.csv'};
% 

% files = {'../AEData/collected/collected_m_2__c0_2__alpha_1__grid_full.csv',...
%          '../AEData/collected/collected_m_4__c0_2__alpha_1__grid_full.csv',...
%          '../AEData/collected/collected_m_8__c0_2__alpha_1__grid_full.csv',...
%          '../AEData/collected/collected_m_16__c0_2__alpha_1__grid_full.csv',...
%          '../AEData/collected/collected_m_32__c0_2__alpha_1__grid_full.csv',...
%          '../AEData/collected/collected_m_64__c0_2__alpha_1__grid_full.csv',...
%          '../AEData/collected/collected_m_128__c0_2__alpha_1__grid_full.csv'};
% 

fmap = colormap(copper(length(files)));
Pcs = zeros(length(files),1);
ms = zeros(length(files),1);
mmap = colormap(copper(length(ms)));


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


xsize=3.375;
ysize=2.5;
figcorr_unscaled=newfigure(xsize,ysize);
figcorr_unscaled.Name=['fig_xi_vs_d_linear' c0str];

figcorr_dalpha=newfigure(xsize,ysize);
figcorr_dalpha.Name=['fig_xi_dalpha_vs_d_linear' c0str];

figcorr_negd=newfigure(xsize,ysize);
negd_ax = gca;
figcorr_negd.Name=['fig_xi_negd_log' c0str];

figcorr_negd_scaled=newfigure(xsize,ysize);
figcorr_negd_scaled.Name=['fig_xi_negd_log_scaled' c0str];

figcorr_log_noscale=newfigure(xsize,ysize);
figcorr_log_noscale.Name=['fig_xi_posd_log' c0str];

figcorr_log_dalpha=newfigure(xsize,ysize);
figcorr_log_dalpha.Name=['fig_xi_posd_log_dalpha' c0str];

figcorr_log_scaled=newfigure(xsize,ysize);
figcorr_log_scaled.Name=['fig_xi_posd_scaled' c0str];

figentropy=newfigure(xsize,ysize);
figentropy.Name=['fig_entropy_vs_d' c0str];

figentropy_scaled=newfigure(xsize,ysize);
figentropy_scaled.Name=['fig_entropy_scaled' c0str];



for ff=1:length(files)
    tab = readtable(files{ff}, 'Delimiter',',');
    if height(tab) == 0
        continue
    end
    ms(ff) = length(eval(tab.rho_ss{1}));
    txt=['m=' num2str(ms(ff))];
    
    % figure; 
    % loglog(tab.corrlen_Shannon, tab.corrlen_dI,'.');
%     tab.corrlen_Shannon = (tab.corrlen_Shannon);

    tab.c0=10.^tab.log10c0;
    tab = sortrows(tab,'P1');
    tempvals = tab.corrlen_Shannon;
    tab.corrlen_Shannon = abs(tab.corrlen_Shannon);
    x = tab.P1;
    % y = abs(tab.corrlen_rmse_Shannon)./abs(tab.corrlen_Shannon);
    y = abs(tab.corrlen_Shannon);
    [~,~, outliers] = find_outliers(x,y, 5,1.2);
    disp(['File ' files{ff} ' removing ' num2str(length(outliers)) ' outliers out of ' num2str(height(tab)) ...
          ' datapoints (' num2str(length(outliers)/height(tab)*100,2) '%).'])
    tab = tab(setdiff(1:height(tab), outliers), :);

    % figure; plot(x_new,y_new)
    % tab.corrlen_Shannon(abs(tab.corrlen_Shannon)>1e5) = NaN;
    % tab=tab(abs(tab.corrlen_rmse_Shannon)<1e-4,:);


    % tab=tab(tab.corrlen_err_Shannon<0.05,:);
%     tab.corrlen_Shannon(abs(tab.corrlen_err_Shannon./tab.corrlen_Shannon)>0.1) = NaN;
%     tab = tab((tab.corrlen_err_Shannon./tab.corrlen_Shannon)<1e-3,:);
    
    [mx,mind] = max(tab.corrlen_Shannon);
    Pcs(ff) = tab.P1(mind);
%     tab.corrlen_Shannon = tempvals;
%     Pc = Pcs(ff);
    Pc = Pcs(1);

    if(option==1)
        Pc = 0.70657;
    end
    if(option==2)
        Pc = 0.7468;
    end
    disp(['Pc ' num2str(Pc)])

%     Pc = 0.746738;

%     if ff<5
%         Pc = mean(Pcs(1:ff));
%     else
%         Pc = mean(Pcs(1:5));
%     end
%     Pc = 0.706555624235447;
%   Pc = 0.706570239663288;
    
    dalpha = (2*tab.alpha_val-1)/(ms(ff)-1);
%     dalpha = ones(size(tab.alpha_val))/(ms(ff)-1);

    [mn, mind] = min(abs(tab.P1-0.5));
    d=Pc-tab.P1;
    minusd=tab.P1-Pc;

    figure(figcorr_log_scaled);
    hold on
    % c0scale=tab.c0./(tab.rho0+tab.c0);
    c0scale=1;
%     scaled_corrlen = tab.corrlen_Shannon.*d.*dalpha;
    scaled_corrlen = tab.corrlen_Shannon.*c0scale.*d.*dalpha;
    fn = find(d<=0.1);
    plot(d(fn)./dalpha(fn), scaled_corrlen(fn),'.', 'Color', fmap(ff,:), 'MarkerSize',11, 'DisplayName', txt);
    xlabel('$d/\delta_\alpha$', 'Interpreter','latex');
    ylabel('$\xi\,\,d\,\,\delta_{\alpha}$', 'Interpreter','latex');
    set(gca,'YScale','log');
    set(gca,'XScale','log');

    figure(figcorr_log_noscale);
    hold on
    plot(d, tab.corrlen_Shannon,'.', 'Color', mmap(ff,:), 'MarkerSize',11, 'DisplayName', txt);
    set(gca,'YScale','log');
    set(gca,'XScale','log');
    xlabel('Distance, $d$', 'Interpreter','Latex');
    ylabel('Relaxation, $\xi$', 'Interpreter','Latex');
    set(gca,'FontSize',18)

    figure(figcorr_log_dalpha);
    hold on
    plot(d, tab.corrlen_Shannon.*dalpha,'.', 'Color', mmap(ff,:), 'MarkerSize',11, 'DisplayName', txt);
    set(gca,'YScale','log');
    set(gca,'XScale','log');
    xlabel('Distance, $d$', 'Interpreter','Latex');
    ylabel('Relaxation, $\xi\,\,\delta_\alpha$', 'Interpreter','Latex');
    set(gca,'FontSize',18)

%     figure(552);
%     hold on
%     plot(d, tab.corrlen_Shannon,'.', 'Color', fmap(ff,:),'MarkerSize',18, 'DisplayName', txt);
%     %plot(tab.P1-Pc, tab.corrlen_dI,'o','MarkerSize',18, 'DisplayName', txt);
%     ylim([1, 10^5]);
%     set(gca,'YScale','log');
%     set(gca,'XScale','log');
%     grid on

    figure(figcorr_negd);
    axes(negd_ax);
    hold on
    plot(minusd, tab.corrlen_Shannon,'.','MarkerSize',11, 'Color', mmap(ff,:), 'DisplayName', txt);
    % ylim(10.^[-2, 5]);
    % xlim(10.^[-5, 0]);
    % xticks(10.^[-5,0]);
    % yticks(10.^[0, 5]);
    ylim(10.^[0, 4]);
    xlim(10.^[-3, -1]);
    xticks(10.^[-3:-1]);
    yticks(10.^[0,2,4]);
    set(gca,'YScale','log');
    set(gca,'XScale','log');
    set(gca,'FontSize', 18);
    xlabel('Negative distance, $-d$', 'Interpreter','Latex')   
    ylabel('Relaxation, $\xi$', 'Interpreter','Latex')

    figure(figcorr_negd_scaled);
    % axes(negd_scaled_ax);
    % ax = gca;
    % ax.Position = [0.3712    0.4604    0.1885    0.1555];
    box off
    plot(minusd, tab.corrlen_Shannon.*dalpha,'.','MarkerSize',11, 'Color', mmap(ff,:), 'DisplayName', txt);
    % plot(minusd./dalpha, tab.corrlen_Shannon,'.','MarkerSize',11, 'Color', mmap(ff,:), 'DisplayName', txt);
    % loglog(minusd.*dalpha, tab.corrlen_Shannon,'.','MarkerSize',11, 'Color', mmap(ff,:), 'DisplayName', txt);
    hold on
%     set(gca,'YScale','log');
    set(gca,'XScale','log');
    set(gca,'YScale','log');
    xl = xlabel('$-d$', 'Interpreter','Latex');
    % xl.Position = [ 1e3  0.148   -1.0000];
    yl = ylabel('$\xi\, \delta_{\alpha}$', 'Interpreter','Latex');
    % yl.Position = [4.9863e-07, 3.9e5, -1];
    set(gca,'FontSize',18)
    
    % figentropy=100;
    figure(figentropy);
    hold on
    % tab = sortrows(tab,'P1','descend');
    plt = plot(d, exp(tab.ShannonS),'.', 'Color', fmap(ff,:), 'MarkerSize',11,'DisplayName', 'Entropy');
    % plot(d, exp(abs(tab.dI)),'.', 'Color', fmap(ff,:), 'MarkerSize',11,'DisplayName', 'Entropy');

    %     plot(d./dalpha, tab.ShannonS/log(ms(ff)),'.', 'Color', fmap(ff,:), 'MarkerSize',11,'DisplayName', 'Entropy');
%     plot(d, -tab.dI*2,'.', 'Color', mmap(ff,:), 'MarkerSize',11, 'DisplayName','10 dI');
%     xlim([0,0.25]);
    xlabel('Distance, $d=P_c-P$', 'Interpreter','Latex');
    ylabel('Eff. species, $m_{e}$', 'Interpreter','Latex');
    % xlim([-0.025,0.1]);

    xlim([-0.2,0.2]);
    ylim([1, 1000]);
    set(gca,'YScale','log')
    yticks(10.^[0,1,2,3])

    % xlim(10.^[-5, -1]);
    % xticks(10.^[-5,-1]);
    % ylim(10.^[0,4]);
    set(gca,'FontSize', 18);

    figure(figentropy_scaled);
    hold on
    fn = find(d<0.1);
    plot(d(fn)./dalpha(fn), exp(tab.ShannonS(fn))-1,'.', 'Color', fmap(ff,:), 'MarkerSize',11,'DisplayName', 'Entropy');
    %     plot(d./dalpha, tab.ShannonS/log(ms(ff)),'.', 'Color', fmap(ff,:), 'MarkerSize',11,'DisplayName', 'Entropy');
%     plot(d, -tab.dI*2,'.', 'Color', mmap(ff,:), 'MarkerSize',11, 'DisplayName','10 dI');
    set(gca,'XScale','log')
    set(gca,'YScale', 'log')
    xlim(10.^[-4,4]);
    xticks(10.^[-4,0,4]);
    ylim(10.^[-4,4]);
    yticks(10.^[-4,0,4]);
    set(gca,'FontSize', 18);
    xlabel('Scaled distance, $d/\delta_{\alpha}$', 'Interpreter','Latex');
    ylabel('$m_e - 1$', 'Interpreter','Latex');
%     legend();
%     grid on

    
    figure(figcorr_unscaled);
    mmap = colormap(copper(length(ms)));
    hold on
    tab = sortrows(tab, 'P1');
    plot(d, tab.corrlen_Shannon,'.', 'Color', mmap(ff,:),'MarkerSize',11, 'LineWidth', 2);
% errorbar(d, tab.corrlen_Shannon,tab.corrlen_err_Shannon, '.-', 'Color', mmap(ff,:),'MarkerSize',6, 'LineWidth', 2);
%     ylim([10, 10000]);
    xlabel('Distance, $d$', 'Interpreter','Latex')
    ylabel('Relaxation, $\xi$', 'Interpreter','Latex')
    xlim([-0.02, 0.02]);
%     ylim(10.^[0,5.5]);
    set(gca,'Yscale','linear')
    set(gca,'FontSize',18)
    
    figure(figcorr_dalpha);
    mmap = colormap(copper(length(ms)));
    hold on
    tab = sortrows(tab, 'P1');
    plot(d, tab.corrlen_Shannon.*dalpha,'.', 'Color', mmap(ff,:),'MarkerSize',11, 'LineWidth', 2);
    % errorbar(d, tab.corrlen_Shannon,tab.corrlen_err_Shannon, '.-', 'Color', mmap(ff,:),'MarkerSize',6, 'LineWidth', 2);
    xlabel('Distance, $d$', 'Interpreter','Latex')
    ylabel('Relaxation, $\xi\,\,\delta_\alpha$', 'Interpreter','Latex')
    xlim([-0.02, 0.02]);
    ylim(10.^[-1,4]);
    yticks(10.^[0,2,4])
    set(gca,'Yscale','log')
    set(gca,'Xscale','linear')
    set(gca,'FontSize',18)
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure(figcorr_negd);
colormap(copper)
c = colorbar();
% c.Position = [ 0.6924    0.7729    0.0370    0.1800];
c.Position = [0.4126    0.3673    0.0370    0.1800];
set(c,'Fontsize', 15);
c.Ticks = [0 1];
c.TickLabels = [ms(1) ms(end)];
c.TickLabelInterpreter = 'latex';
t=title(c,'$m$','Interpreter','latex');
t.Position = [ -26     8     0];
xx=10.^[-2,-1];
plot(xx,0.18*xx.^(-1),'--b', 'LineWidth',2);
tt=text(10^-2.34, 10^(0.35), '$\xi\sim (-d)^{-1}$', 'Interpreter','latex', 'FontSize',15, 'Color', 'b');
print(gcf, ['../AEFigures/' figcorr_negd.Name], '-dpng', '-r600');
print(gcf, ['../AEFigures/' figcorr_negd.Name], '-dsvg');


figure(figcorr_negd_scaled)
ylim(10.^[0,3])
yticks(10.^[0:3]);
xlim(10.^[-3,-1]);
xticks(10.^[-3:-1]);
set(gca,'YScale', 'log');
set(gca,'XScale', 'log');

colormap(copper)
c = colorbar();
c.Position = [0.7 0.7 0.037 0.18];
set(c,'Fontsize', 15);
c.Ticks = [0 1];
c.TickLabels = [ms(1) ms(end)];
c.TickLabelInterpreter = 'latex';
t=title(c,'$m$','Interpreter','latex');

print(gcf, ['../AEFigures/' figcorr_negd_scaled.Name], '-dpng', '-r600');
print(gcf, ['../AEFigures/' figcorr_negd_scaled.Name], '-dsvg');


figure(figcorr_log_noscale);
set(gca,'FontSize',18);
xlim(10.^[-4, -1]);
xticks(10.^[-4,-1]);
ylim(10.^[0,5]);
colormap(copper)
c = colorbar();
c.Position = [0.4131    0.3539    0.0370    0.1800];
set(c,'Fontsize', 15);
c.Ticks = [0 1];
c.TickLabels = [ms(1) ms(end)];
c.TickLabelInterpreter = 'latex';
t=title(c,'$m$','Interpreter','latex');
t.Position = [ -28.5045   35.6500         0];
plot(10.^[-3.25, -1.75], 10.^[2.25,0.75], '--b', 'LineWidth', 2);
text(10^-3, 10^(0.5), '$\xi\sim d^{-1}$', 'Interpreter','latex', 'FontSize',15, 'Color', 'b');
plot(10.^[-2, -1], 10.^[3.6,1.6], '--b', 'LineWidth', 2);
text(10^(-1.8), 10^(3.6), '$\xi\sim d^{-2}$', 'Interpreter','latex', 'FontSize',15, 'Color', 'b');
print(gcf, ['../AEFigures/' figcorr_log_noscale.Name], '-dpng', '-r600');
print(gcf, ['../AEFigures/' figcorr_log_noscale.Name], '-dsvg');


figure(figcorr_log_dalpha);
set(gca,'FontSize',18);
xlim(10.^[-4, -1]);
xticks(10.^[-4:-1]);
ylim(10.^[-3,3]);
yticks(10.^[-3,0,3]);
colormap(copper)
c = colorbar();
c.Position = [0.4131    0.3539    0.0370    0.1800];
set(c,'Fontsize', 15);
c.Ticks = [0 1];
c.TickLabels = [ms(1) ms(end)];
c.TickLabelInterpreter = 'latex';
title(c,'$m$','Interpreter','latex');
plot(10.^[-2.5,-1], 10.^[2.25,0.75], '--b', 'LineWidth', 2);
text(10^(-2.5), 10^(2.75), '$\xi\sim d^{-1}$', 'Interpreter','latex', 'FontSize',16, 'Color', 'b');
plot(10.^[-2.5, -1], 10.^[0.1,-2.9], '--b', 'LineWidth', 2);
text(10^(-2.5), 10^(-2.5), '$\xi\sim d^{-2}$', 'Interpreter','latex', 'FontSize',16, 'Color', 'b');
print(gcf, ['../AEFigures/' figcorr_log_dalpha.Name], '-dpng', '-r600');
print(gcf, ['../AEFigures/' figcorr_log_dalpha.Name], '-dsvg');


figure(figcorr_log_scaled);
set(gca,'FontSize',18);
xlim(10.^[-3, 3]);
xticks(10.^[-3,0,3]);
ylim(10.^[-3,-0.5]);
yticks(10.^[-3,-2,-1]);
colormap(copper)
c = colorbar();
c.Position = [0.7500    0.704    0.037    0.18];
set(c,'Fontsize', 15);
c.Ticks = [0 1];
c.TickLabels = [ms(1) ms(end)];
c.TickLabelInterpreter = 'latex';
title(c,'$m$','Interpreter','latex');
KK=10.^[-3:0.01:3];
loglog(KK, 0.07*1./(1+KK), '--', 'Color', 'b', 'LineWidth', 2);
tx = text(2e-3, 0.0025, '$\xi\sim\frac{1}{d\,\delta_\alpha}\,\frac{1}{1+d/\delta_{\alpha}}$', 'Interpreter','latex', 'FontSize',17, 'Color', 'b');
print(gcf, ['../AEFigures/' figcorr_log_scaled.Name], '-dpng', '-r600');
print(gcf, ['../AEFigures/' figcorr_log_scaled.Name], '-dsvg');



figure(figcorr_unscaled);
colormap(copper)
c = colorbar();
c.Position = [0.6859    0.6411    0.0370    0.1800];
set(c,'Fontsize', 15);
c.Ticks = [0 1];
c.TickLabels = [ms(1) ms(end)];
c.TickLabelInterpreter = 'latex';
title(c,'$m$','Interpreter','latex');
print(gcf, ['../AEFigures/' figcorr_unscaled.Name], '-dpng', '-r600');
print(gcf, ['../AEFigures/' figcorr_unscaled.Name], '-dsvg');


figure(figcorr_dalpha);
colormap(copper)
c = colorbar();
c.Position = [0.6859    0.6411    0.0370    0.1800];
set(c,'Fontsize', 15);
c.Ticks = [0 1];
c.TickLabels = [ms(1) ms(end)];
c.TickLabelInterpreter = 'latex';
title(c,'$m$','Interpreter','latex');
print(gcf, ['../AEFigures/' figcorr_dalpha.Name], '-dpng', '-r600');
print(gcf, ['../AEFigures/' figcorr_dalpha.Name], '-dsvg');



figure(figentropy)
colormap(copper)
c = colorbar();
% c.Position = [0.59 0.7 0.037 0.18];
set(gca,'YScale','log')
c.Position = [0.42 0.72 0.037 0.18];
set(c,'Fontsize', 15);
c.Ticks = [0 1];
c.TickLabels = [ms(1) ms(end)];
c.TickLabelInterpreter = 'latex';
t=title(c,'$m$','Interpreter','latex');
print(gcf, ['../AEFigures/' figentropy.Name], '-dpng', '-r600');
print(gcf, ['../AEFigures/' figentropy.Name], '-dsvg');


figure(figentropy_scaled)
% q=0.98;
q=1;
xx=10.^[-4:0.01:-0.5];
plot(xx, 0.2*(xx.^q).*(1-log(xx.^q)), '--b', 'LineWidth', 2);
xx=10.^[0.5:0.01:3];
plot(xx, 15*(xx.^q), '--b', 'LineWidth', 2);
tx = text(78,20.5,'$\sim \left(\frac{d}{\delta_{\alpha}}\right)$', 'Interpreter','latex', 'FontSize',16, 'Color','b');
% tx2 = text(1e-3, 2e-3,'$\sim \left(\frac{d}{\delta_{\alpha}}\right)^q\left(1-\ln \left(\frac{d}{\delta_{\alpha}}\right)^q \right)$', 'Interpreter','latex', 'FontSize',13, 'Color','b');
tx2 = text(6e-3, 2e-3,'$\sim \left(\frac{d}{\delta_{\alpha}}\right)\left(1-\ln \left(\frac{d}{\delta_{\alpha}}\right) \right)$', 'Interpreter','latex', 'FontSize',14, 'Color','b');
colormap(copper)
c = colorbar();
set(gca,'YScale','log')
c.Position = [0.49 0.67 0.037 0.18];
set(c,'Fontsize', 15);
c.Ticks = [0 1];
c.TickLabels = [ms(1) ms(end)];
c.TickLabelInterpreter = 'latex';
t=title(c,'$m$','Interpreter','latex');
print(gcf, ['../AEFigures/' figentropy_scaled.Name], '-dpng', '-r600');
print(gcf, ['../AEFigures/' figentropy_scaled.Name], '-dsvg');


